//
//  Progress.swift
//  Decele
//
//  Created by Mc Kevin on 8/01/23.
//

import Alamofire
import Combine

// MARK: - ProgressProtocol
public protocol ProgressProtocol {
    func showProgress(_ request: DataRequest, _ cancellable: AnyCancellable)
    func dismisssProgress(_ request: DataRequest)
    func showError(_ show: Bool, _ error: MessageModel)
}

// MARK: - Progress
public struct Progress: ProgressProtocol {
    public init() {}

    public func showProgress(_ request: DataRequest, _ cancellable: AnyCancellable) {
        print("showProgress")
    }

    public func dismisssProgress(_ request: DataRequest) {
        print("dismisssProgress")
    }

    public func showError(_ show: Bool, _ error: MessageModel) {
        print("showError")
    }
}
