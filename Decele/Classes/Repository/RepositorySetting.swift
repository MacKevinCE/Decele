//
//  RepositorySetting.swift
//  Decele
//
//  Created by Mc Kevin on 7/01/23.
//

import Alamofire

// MARK: - RepositorySetting
public class RepositorySetting {
    public static var shared = RepositorySetting()

    public var baseURL: String
    public var queue: DispatchQueue
    public var isSuccessStatusCode: (Int?) -> Bool
    public var closureSignature: (Encodable) -> String
    public var showError: Bool
    public var tokenInterceptor: TokenInterceptor
    public var progress: ProgressProtocol
    public var debug: DebugProtocol
    public var error: ErrorModelProtocol

    public init(
        baseURL: String = .empty,
        queue: DispatchQueue = DispatchQueue(label: "Repository.queue", qos: .utility),
        isSuccessStatusCode: @escaping (Int?) -> Bool = { $0 == 200 },
        closureSignature: @escaping (Encodable) -> String = { _ in .empty },
        showError: Bool = true,
        tokenInterceptor: TokenInterceptor = TokenInterceptor(),
        progress: ProgressProtocol = Progress(),
        debug: DebugProtocol = Debug(),
        error: ErrorModelProtocol = ErrorModel()
    ) {
        self.baseURL = baseURL
        self.queue = queue
        self.isSuccessStatusCode = isSuccessStatusCode
        self.closureSignature = closureSignature
        self.showError = showError
        self.tokenInterceptor = tokenInterceptor
        self.progress = progress
        self.debug = debug
        self.error = error
    }
}
