//
//  Session.swift
//  Decele
//
//  Created by Mc Kevin on 3/01/23.
//

import Alamofire

public extension Session {
    func request(_ convertible: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders = .basic(), interceptor: RequestInterceptor? = nil) -> DataRequest {
        request(convertible, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: interceptor)
    }

    func request(_ convertible: URLConvertible, method: HTTPMethod = .get, request req: Encodable, headers: HTTPHeaders = .basic(), interceptor: RequestInterceptor? = nil) -> DataRequest {
        request(convertible, method: method, parameters: (try? req.encode?.jsonObject()) as? [String: Any], encoding: JSONEncoding.default, headers: headers, interceptor: interceptor)
    }

    func requestToken(_ convertible: URLConvertible, method: HTTPMethod = .post, parameters: Parameters? = nil) -> DataRequest {
        request(convertible, method: method, parameters: parameters, headers: .basic(), interceptor: RepositorySetting.shared.tokenInterceptor)
    }

    func requestToken(_ convertible: URLConvertible, method: HTTPMethod = .post, request req: Encodable) -> DataRequest {
        request(convertible, method: method, request: req, headers: .basic(), interceptor: RepositorySetting.shared.tokenInterceptor)
    }

    func requestSignature(_ convertible: URLConvertible, method: HTTPMethod = .post, request req: Encodable, signature: (Encodable) -> String = RepositorySetting.shared.closureSignature) -> DataRequest {
        request(convertible, method: method, request: req, headers: .signature(signature(req)))
    }

    func requestSignatureToken(_ convertible: URLConvertible, method: HTTPMethod = .post, request req: Encodable, signature: (Encodable) -> String = RepositorySetting.shared.closureSignature) -> DataRequest {
        request(convertible, method: method, request: req, headers: .signature(signature(req)), interceptor: RepositorySetting.shared.tokenInterceptor)
    }
}
