//
//  CoreSetting.swift
//  CoreDecele
//
//  Created by Mc Kevin on 10/06/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Alamofire
import Decele
import Mocker

extension String {
    static let authVersion = Self.baseURLTo("auth/version")
    static let authLogin = Self.baseURLTo("auth/login")
}

public let AFM: Session = {
    RepositorySetting.shared = RepositorySetting(baseURL: "http://localhost:3000")
    let configuration = URLSessionConfiguration.af.default
    configuration.protocolClasses = [MockingURLProtocol.self]
    return Session(configuration: configuration)
}()

public extension Mock {
    init(
        url: URLConvertible,
        ignoreQuery: Bool = false,
        cacheStoragePolicy: URLCache.StoragePolicy = .notAllowed,
        dataType: DataType = .json,
        statusCode: Int = 200,
        data: [HTTPMethod: URL],
        requestError: Error? = nil,
        additionalHeaders: [String: String] = [:]
    ) {
        self.init(
            url: try! url.asURL(),
            ignoreQuery: ignoreQuery,
            cacheStoragePolicy: cacheStoragePolicy,
            dataType: dataType,
            statusCode: statusCode,
            data: data.mapValues { try! Data(contentsOf: $0) },
            additionalHeaders: additionalHeaders,
            requestError: requestError
        )
    }
}
