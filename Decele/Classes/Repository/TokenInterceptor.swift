//
//  TokenInterceptor.swift
//  Repository
//
//  Created by Mc Kevin on 3/01/23.
//

import Alamofire

public class TokenInterceptor: RequestInterceptor {
    let tokenExpiredStatusCode: Int
    let refreshToken: (String?) -> TokenResponse?
    var token: TokenResponse?

    static var shared = ConfigRepository.shared.tokenInterceptor

    init() {
        self.tokenExpiredStatusCode = 401
        self.refreshToken = { _ in nil }
    }

    public init(sessionExpired statusCode: Int = 401, refreshToken closure: @escaping (String?) -> TokenResponse) {
        self.tokenExpiredStatusCode = statusCode
        self.refreshToken = closure
    }

    public func setToken(token: TokenResponse) {
        self.token = token
    }

    private var isRefreshing = false
    private let lock = NSLock()

    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var adaptedRequest = urlRequest
        if let token = token?.accessToken {
            let header: HTTPHeader = .authorization(bearerToken: token)
            adaptedRequest.addValue(header.value, forHTTPHeaderField: header.name)
        }
        completion(.success(adaptedRequest))
    }

    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        lock.lock(); defer { lock.unlock() }
        if isRefreshing {
            isRefreshing = false
            if let response = request.task?.response as? HTTPURLResponse, response.statusCode == tokenExpiredStatusCode {
                refreshToken(completion)
            } else {
                completion(.doNotRetry)
            }
        } else {
            isRefreshing = true
            completion(.doNotRetry)
        }
    }

    private func refreshToken(_ completion: @escaping (RetryResult) -> Void) {
        if let token = refreshToken(token?.refreshToken) {
            self.token = token
            completion(.retry)
        } else {
            completion(.doNotRetry)
        }
    }
}
