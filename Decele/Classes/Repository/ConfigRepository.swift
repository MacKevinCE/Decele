//
//  ConfigRepository.swift
//  Repository
//
//  Created by Mc Kevin on 7/01/23.
//

import Alamofire

public class ConfigRepository {
    public static var shared = ConfigRepository()

    public var baseURL: String
    public var dispatchQueueLabel: String
    public var successStatusCode: Int
    public var tokenInterceptor: TokenInterceptor
    public var progress: ProgressProtocol
    public var debug: DebugProtocol
    public var error: ErrorModelProtocol

    public init(baseURL: String, dispatchQueueLabel: String = "Repository.queue", successStatusCode: Int = 200, tokenInterceptor: TokenInterceptor, progress: ProgressProtocol, debug: DebugProtocol, error: ErrorModelProtocol) {
        self.baseURL = baseURL
        self.dispatchQueueLabel = dispatchQueueLabel
        self.successStatusCode = successStatusCode
        self.tokenInterceptor = tokenInterceptor
        self.progress = progress
        self.debug = debug
        self.error = error
    }

    init() {
        self.baseURL = ""
        self.dispatchQueueLabel = "Repository.queue"
        self.successStatusCode = 200
        self.tokenInterceptor = TokenInterceptor()
        self.progress = Progress()
        self.debug = Debug()
        self.error = ErrorModel()
    }

    public var queue: DispatchQueue {
        return DispatchQueue(label: ConfigRepository.shared.dispatchQueueLabel, qos: .utility)
    }
}
