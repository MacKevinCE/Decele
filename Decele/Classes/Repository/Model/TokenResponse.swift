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
