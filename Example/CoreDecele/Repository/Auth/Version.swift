//
//  Version.swift
//  CoreDecele
//
//  Created by Mc Kevin on 10/06/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Alamofire
import Decele
import Mocker

// MARK: - VersionResponse
public struct VersionResponse: Decodable {
    public let version: String
}

// MARK: - VersionRequest
public struct VersionRequest: RepositoryDecodable {
    public typealias Response = VersionResponse

    public var dataRequest: DataRequest

    public init() {
        dataRequest = AFM.request(.authVersion())
    }
}
