//
//  Login.swift
//  CoreDecele
//
//  Created by Mc Kevin on 13/06/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Alamofire
import Decele

// MARK: - LoginResponse
public struct LoginResponse: TokenProtocol {
    public var accessToken: String
    public var refreshToken: String
}

// MARK: - LoginRequest
public struct LoginRequest: RepositoryResponse {
    public typealias Payload = LoginResponse

    public var dataRequest: DataRequest

    public init() {
        dataRequest = AFM.request(.authLogin())
    }
}
