//
//  TokenInterceptor.swift
//  Decele
//
//  Created by Mc Kevin on 3/01/23.
//

import Alamofire

// MARK: - TokenInterceptor
open class TokenInterceptor: RequestInterceptor {
    public init() {}

    private var isRefreshing = false
    private let lock = NSLock()

    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var adaptedRequest = urlRequest
        if let token = getToken() {
            createHeader(token: token).forEach { header in
                adaptedRequest.addValue(header.value, forHTTPHeaderField: header.name)
            }
        }
        completion(.success(adaptedRequest))
    }

    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        lock.lock(); defer { lock.unlock() }
        if isRefreshing {
            isRefreshing = false
            if conditionToRefresh(request, for: session, dueTo: error, token: getToken()) {
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
        refreshToken { [weak self] result in
            switch result {
            case let .success(success):
                self?.saveToken(success)
                completion(.retry)
            case .failure:
                completion(.doNotRetry)
            }
        }
    }

    open func refreshToken(_ completion: @escaping (Result<TokenProtocol, Error>) -> Void) {}

    open func saveToken(_ token: TokenProtocol) {}

    open func getToken() -> TokenProtocol? {
        nil
    }

    open func conditionToRefresh(_ request: Request, for session: Session, dueTo error: Error, token: TokenProtocol?) -> Bool {
        false
    }

    open func createHeader(token: TokenProtocol) -> [HTTPHeader] {
        [.authorization(bearerToken: token.accessToken)]
    }
}
