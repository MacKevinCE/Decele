//
//  DataRequest.swift
//  Decele
//
//  Created by Mc Kevin on 3/01/23.
//

import Alamofire
import PromiseKit

extension DataRequest {
    public func resolve<T: Decodable>(
        _ success: @escaping (T) -> Void,
        _ failed: @escaping (Error) -> Bool = { _ in true }
    ) {
        ConfigRepository.shared.progress.showProgress(self)
        make().done { (response: T) in
            ConfigRepository.shared.progress.dismisssProgress(self)
            success(response)
        }.catch(catchFailed(failed))
    }

    public func resolve<T: Decodable>(
        success statusCode: Int = ConfigRepository.shared.successStatusCode,
        _ success: @escaping (T, MessageModel) -> Void,
        _ failed: @escaping (Error) -> Bool = { _ in true }
    ) {
        ConfigRepository.shared.progress.showProgress(self)
        makeResponse().done { (response: T?, message) in
            ConfigRepository.shared.progress.dismisssProgress(self)
            if let response = response,
               let message = message,
               message.statusCode == statusCode
            {
                success(response, message)
            } else {
                let err = message ?? ConfigRepository.shared.error.messageModelNil
                self.catchFailed(failed)(err)
            }
        }.catch(catchFailed(failed))
    }

    public func resolve(
        _ success: @escaping (Int) -> Void,
        _ failed: @escaping (Error) -> Bool = { _ in true }
    ) {
        ConfigRepository.shared.progress.showProgress(self)
        makeVoid().done { response in
            ConfigRepository.shared.progress.dismisssProgress(self)
            success(response)
        }.catch(catchFailed(failed))
    }

    private func catchFailed(
        _ failed: @escaping (Error) -> Bool
    ) -> (Error) -> Void {
        return { err in
            ConfigRepository.shared.progress.dismisssProgress(self)
            ConfigRepository.shared.debug.printError(err)
            if let message = err as? MessageModel, failed(message) {
                ConfigRepository.shared.progress.showError(message)
            } else if let afError = err as? AFError, failed(afError) {
                ConfigRepository.shared.progress.showError(afError)
            } else if failed(err) {
                ConfigRepository.shared.progress.showError(err)
            }
        }
    }

    private func make<T: Decodable>() -> Promise<T> {
        return Promise<T> { seal in
            self.validate().responseDecodable(queue: ConfigRepository.shared.queue, completionHandler: { (response: DataResponse<T, AFError>) in
                ConfigRepository.shared.debug.printResponse(response)
                switch response.result {
                case let .failure(error):
                    seal.reject(self.failed(error: error, response: response))
                case let .success(rpta):
                    seal.fulfill(rpta)
                }
            })
        }
    }

    private func makeResponse<T: Decodable>() -> Promise<(response: T?, message: MessageModel?)> {
        return Promise<(response: T?, message: MessageModel?)> { seal in
            self.validate().responseDecodable(queue: ConfigRepository.shared.queue, completionHandler: { (response: DataResponse<ResponseModel<T>, AFError>) in
                ConfigRepository.shared.debug.printResponse(response)
                switch response.result {
                case let .failure(error):
                    seal.reject(self.failed(error: error, response: response))
                case let .success(rpta):
                    seal.fulfill((response: rpta.payload, message: rpta.message))
                }
            })
        }
    }

    private func makeVoid() -> Promise<Int> {
        return Promise<Int> { seal in
            self.validate().response(queue: ConfigRepository.shared.queue, completionHandler: { response in
                ConfigRepository.shared.debug.printResponse(response)
                switch response.result {
                case let .failure(error):
                    seal.reject(self.failed(error: error, response: response))
                case .success:
                    seal.fulfill(response.response?.statusCode ?? 0)
                }
            })
        }
    }

    private func failed<T>(error: Error, response: AFDataResponse<T>) -> Error {
        if let messageModel: MessageModel = response.data?.decode() {
            return messageModel
        } else if let statusCode = response.response?.statusCode, let getError = ConfigRepository.shared.error.getMessageModel(statusCode: statusCode) {
            return getError
        } else if let err = error as? AFError, let getError = ConfigRepository.shared.error.getMessageModel(error: err) {
            return getError
        } else {
            return response.error ?? error
        }
    }
}
