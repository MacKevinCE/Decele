//
//  Progress.swift
//  Repository
//
//  Created by Mc Kevin on 8/01/23.
//

import Alamofire

public protocol ProgressProtocol {
    func showProgress(_ request: DataRequest)
    func dismisssProgress(_ request: DataRequest)
    func showError(_ error: Error)
}

struct Progress: ProgressProtocol {
    func showProgress(_ request: Alamofire.DataRequest) {}
    func dismisssProgress(_ request: Alamofire.DataRequest) {}
    func showError(_ error: Error) {}
}
