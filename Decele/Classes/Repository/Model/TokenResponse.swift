//
//  TokenResponse.swift
//  Decele
//
//  Created by Mc Kevin on 4/01/23.
//

import Foundation

public struct TokenResponse: Decodable {
    var accessToken: String
    var refreshToken: String

    public init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
