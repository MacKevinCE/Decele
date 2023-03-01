//
//  TokenResponse.swift
//  Decele
//
//  Created by Mc Kevin on 4/01/23.
//

import Foundation

// MARK: - TokenProtocol
public protocol TokenProtocol: Decodable {
    var accessToken: String { get set }
    var refreshToken: String { get set }
}

// MARK: - TokenResponse
public struct TokenResponse: TokenProtocol {
    public var accessToken: String
    public var refreshToken: String

    public init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
