//
//  URLConvertible.swift
//  Decele
//
//  Created by Mc Kevin on 3/01/23.
//

import Alamofire

public extension URLConvertible where Self == String {
    static func baseURLTo(_ path: String) -> URLConvertible {
        let baseURL = RepositorySetting.shared.baseURL
        let link = URL(string: baseURL)?.appendingPathComponent(path).absoluteString
        return link ?? "\(baseURL)\(path)"
    }
}
