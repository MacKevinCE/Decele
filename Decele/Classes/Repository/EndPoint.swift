//
//  Service.swift
//  Alamofire
//
//  Created by Mc Kevin on 3/01/23.
//

import Alamofire

public enum EndPoint: Hashable, Equatable {
    case path(_ path: String)
    case literal(string: String)
    case custom(baseURL: String, path: String)
}

extension EndPoint: URLConvertible {
    public func asURL() throws -> URL {
        try self.endPoint.asURL()
    }

    public var endPoint: URLConvertible {
        switch self {
        case let .path(path):
            return Self.custom(baseURL: ConfigRepository.shared.baseURL, path: path).endPoint
        case let .custom(baseURL, path):
            return URL(string: baseURL)?.appendingPathComponent(path).absoluteString ?? "\(baseURL)\(path)"
        case let .literal(string):
            return string
        }
    }
}
