//
//  Repository.swift
//  Pods
//
//  Created by Mc Kevin on 11/06/23.
//

import Alamofire
import Combine
import Foundation

// MARK: - Repository
public protocol Repository {
    associatedtype Result
    associatedtype Failure: Error

    var dataRequest: DataRequest { get }

    func resolve(
        showError: Bool,
        receiveCompletion: @escaping ((Subscribers.Completion<Failure>) -> Void),
        receiveValue: @escaping ((Result) -> Void)
    ) -> AnyCancellable
}

public extension Repository where Failure == MessageModel {
    func failed<T: Decodable>(error: Error, response: AFDataResponse<T>) -> Failure {
        if let responseModal: ResponseModel<T> = response.data?.decode(), let messageModel = responseModal.message {
            return messageModel
        } else if let messageModel: Failure = response.data?.decode() {
            return messageModel
        } else if let messageModel = error as? Failure {
            return messageModel
        } else if let getError = RepositorySetting.shared.error.getMessageModel(error: error) {
            return getError
        } else if let statusCode = response.response?.statusCode, let getError = RepositorySetting.shared.error.getMessageModel(statusCode: statusCode) {
            return getError
        } else {
            return RepositorySetting.shared.error.messageModelGeneric
        }
    }
}

// MARK: - RepositoryDecodable
public protocol RepositoryDecodable: Repository where Response: Decodable, Result == Response, Failure == MessageModel {
    associatedtype Response
}

public extension RepositoryDecodable {
    func resolve(
        showError: Bool = RepositorySetting.shared.showError,
        receiveCompletion: @escaping ((Subscribers.Completion<Failure>) -> Void) = { _ in },
        receiveValue: @escaping ((Result) -> Void)
    ) -> AnyCancellable {
        let subject = PassthroughSubject<Result, Failure>()

        let request = dataRequest.validate().responseDecodable(
            queue: RepositorySetting.shared.queue,
            completionHandler: { (response: AFDataResponse<Response>) in
                RepositorySetting.shared.progress.dismisssProgress(dataRequest)
                RepositorySetting.shared.debug.printResponse(response)
                switch response.result {
                case let .failure(error):
                    RepositorySetting.shared.debug.printError(error)
                    let messageModel = self.failed(error: error, response: response)
                    RepositorySetting.shared.progress.showError(showError, messageModel)
                    subject.send(completion: .failure(messageModel))
                case let .success(rpta):
                    subject.send(rpta)
                    subject.send(completion: .finished)
                }
            }
        )

        let cancellable = subject.handleEvents(receiveCancel: {
            request.cancel()
            RepositorySetting.shared.progress.dismisssProgress(dataRequest)
        }).eraseToAnyPublisher().sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)

        RepositorySetting.shared.progress.showProgress(dataRequest, cancellable)

        return cancellable
    }
}

// MARK: - RepositoryData
public protocol RepositoryData: Repository where Result == Data, Failure == MessageModel {}

public extension RepositoryData {
    func resolve(
        showError: Bool = RepositorySetting.shared.showError,
        receiveCompletion: @escaping ((Subscribers.Completion<Failure>) -> Void) = { _ in },
        receiveValue: @escaping ((Result) -> Void)
    ) -> AnyCancellable {
        let subject = PassthroughSubject<Result, Failure>()

        let request = dataRequest.validate().responseData(
            queue: RepositorySetting.shared.queue,
            completionHandler: { (response: AFDataResponse<Result>) in
                RepositorySetting.shared.progress.dismisssProgress(dataRequest)
                RepositorySetting.shared.debug.printResponse(response)
                switch response.result {
                case let .failure(error):
                    RepositorySetting.shared.debug.printError(error)
                    let messageModel = self.failed(error: error, response: response)
                    RepositorySetting.shared.progress.showError(showError, messageModel)
                    subject.send(completion: .failure(messageModel))
                case let .success(rpta):
                    subject.send(rpta)
                    subject.send(completion: .finished)
                }
            }
        )

        let cancellable = subject.handleEvents(receiveCancel: {
            request.cancel()
            RepositorySetting.shared.progress.dismisssProgress(dataRequest)
        }).eraseToAnyPublisher().sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)

        RepositorySetting.shared.progress.showProgress(dataRequest, cancellable)

        return cancellable
    }
}

// MARK: - RepositoryString
public protocol RepositoryString: Repository where Result == String, Failure == MessageModel {}

public extension RepositoryString {
    func resolve(
        showError: Bool = RepositorySetting.shared.showError,
        receiveCompletion: @escaping ((Subscribers.Completion<Failure>) -> Void) = { _ in },
        receiveValue: @escaping ((Result) -> Void)
    ) -> AnyCancellable {
        let subject = PassthroughSubject<Result, Failure>()

        let request = dataRequest.validate().responseString(
            queue: RepositorySetting.shared.queue,
            completionHandler: { (response: AFDataResponse<Result>) in
                RepositorySetting.shared.progress.dismisssProgress(dataRequest)
                RepositorySetting.shared.debug.printResponse(response)
                switch response.result {
                case let .failure(error):
                    RepositorySetting.shared.debug.printError(error)
                    let messageModel = self.failed(error: error, response: response)
                    RepositorySetting.shared.progress.showError(showError, messageModel)
                    subject.send(completion: .failure(messageModel))
                case let .success(rpta):
                    subject.send(rpta)
                    subject.send(completion: .finished)
                }
            }
        )

        let cancellable = subject.handleEvents(receiveCancel: {
            request.cancel()
            RepositorySetting.shared.progress.dismisssProgress(dataRequest)
        }).eraseToAnyPublisher().sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)

        RepositorySetting.shared.progress.showProgress(dataRequest, cancellable)

        return cancellable
    }
}

// MARK: - RepositoryVoid
public protocol RepositoryVoid: Repository where Result == Int, Failure == MessageModel {}

public extension RepositoryVoid {
    func resolve(
        showError: Bool = RepositorySetting.shared.showError,
        receiveCompletion: @escaping ((Subscribers.Completion<Failure>) -> Void) = { _ in },
        receiveValue: @escaping ((Result) -> Void)
    ) -> AnyCancellable {
        let subject = PassthroughSubject<Result, Failure>()

        let request = dataRequest.validate().response(
            queue: RepositorySetting.shared.queue,
            completionHandler: { (response: AFDataResponse<Data?>) in
                RepositorySetting.shared.progress.dismisssProgress(dataRequest)
                RepositorySetting.shared.debug.printResponse(response)
                switch response.result {
                case let .failure(error):
                    RepositorySetting.shared.debug.printError(error)
                    let messageModel = self.failed(error: error, response: response)
                    RepositorySetting.shared.progress.showError(showError, messageModel)
                    subject.send(completion: .failure(messageModel))
                case .success:
                    if let statusCode = response.response?.statusCode {
                        subject.send(statusCode)
                        subject.send(completion: .finished)
                    } else {
                        let messageModel = RepositorySetting.shared.error.messageModelGeneric
                        RepositorySetting.shared.progress.showError(showError, messageModel)
                        RepositorySetting.shared.debug.printError(messageModel)
                        subject.send(completion: .failure(messageModel))
                    }
                }
            }
        )

        let cancellable = subject.handleEvents(receiveCancel: {
            request.cancel()
            RepositorySetting.shared.progress.dismisssProgress(dataRequest)
        }).eraseToAnyPublisher().sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)

        RepositorySetting.shared.progress.showProgress(dataRequest, cancellable)

        return cancellable
    }
}

// MARK: - RepositoryResponse
public protocol RepositoryResponse: Repository where Response == ResponseModel<Payload>, Payload: Decodable, Result == (payload: Payload, message: MessageModel?), Failure == MessageModel {
    associatedtype Payload
    associatedtype Response
}

public extension RepositoryResponse {
    func resolve(
        showError: Bool = RepositorySetting.shared.showError,
        receiveCompletion: @escaping ((Subscribers.Completion<Failure>) -> Void) = { _ in },
        receiveValue: @escaping ((Result) -> Void)
    ) -> AnyCancellable {
        let subject = PassthroughSubject<Result, Failure>()

        let request = dataRequest.validate().responseDecodable(
            queue: RepositorySetting.shared.queue,
            completionHandler: { (response: AFDataResponse<Response>) in
                RepositorySetting.shared.progress.dismisssProgress(dataRequest)
                RepositorySetting.shared.debug.printResponse(response)
                switch response.result {
                case let .failure(error):
                    RepositorySetting.shared.debug.printError(error)
                    let messageModel = self.failed(error: error, response: response)
                    RepositorySetting.shared.progress.showError(showError, messageModel)
                    subject.send(completion: .failure(messageModel))
                case let .success(rpta):
                    if let resp = rpta.payload, RepositorySetting.shared.isSuccessStatusCode(rpta.message?.code) {
                        subject.send((payload: resp, message: rpta.message))
                        subject.send(completion: .finished)
                    } else {
                        let messageModel = rpta.message ?? RepositorySetting.shared.error.messageModelGeneric
                        RepositorySetting.shared.debug.printError(messageModel)
                        RepositorySetting.shared.progress.showError(showError, messageModel)
                        subject.send(completion: .failure(messageModel))
                    }
                }
            }
        )

        let cancellable = subject.handleEvents(receiveCancel: {
            request.cancel()
            RepositorySetting.shared.progress.dismisssProgress(dataRequest)
        }).eraseToAnyPublisher().sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)

        RepositorySetting.shared.progress.showProgress(dataRequest, cancellable)

        return cancellable
    }
}
