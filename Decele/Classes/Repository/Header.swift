//
//  Header.swift
//  Repository
//
//  Created by Mac Kevin Cabanillas Encarnacion on 7/15/21.
//

import Alamofire
import Foundation

public enum Headers {
    case custom(headers: [HTTPHeader])
    case basic
    case authorization(username: String, password: String)
    case token(token: String)
    case signature(sign: String)

    var getHeader: HTTPHeaders {
        switch self {
        case let .custom(headers):
            return HTTPHeaders(headers)
        case .basic:
            return [
                .contentType("application/json"),
            ]
        case let .authorization(username, password):
            return [
                .contentType("application/json"),
                .authorization(username: username, password: password),
            ]
        case let .token(token):
            return [
                .contentType("application/json"),
                .authorization(bearerToken: token),
            ]
        case let .signature(sign):
            return [
                .contentType("application/json"),
                .signature(sign),
            ]
        }
    }
}

public extension HTTPHeader {
    static func signature(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Signature", value: value)
    }
}
