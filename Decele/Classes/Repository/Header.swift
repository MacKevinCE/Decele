//
//  Header.swift
//  Decele
//
//  Created by Mac Kevin Cabanillas Encarnacion on 7/15/21.
//

import Alamofire
import Foundation

public extension HTTPHeader {
    static func signature(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Signature", value: value)
    }
}

public extension HTTPHeaders {
    static func custom(_ headers: [HTTPHeader]) -> HTTPHeaders {
        HTTPHeaders(headers)
    }

    static func basic() -> HTTPHeaders {
        [
            .contentType("application/json"),
        ]
    }

    static func authorization(username: String, password: String) -> HTTPHeaders {
        [
            .contentType("application/json"),
            .authorization(username: username, password: password),
        ]
    }

    static func token(_ token: String) -> HTTPHeaders {
        [
            .contentType("application/json"),
            .authorization(bearerToken: token),
        ]
    }

    static func signature(_ sign: String) -> HTTPHeaders {
        [
            .contentType("application/json"),
            .signature(sign),
        ]
    }
}
