//
//  Decele.swift
//  Decele
//
//  Created by Mc Kevin on 3/01/23.
//

import Alamofire

public extension Session {
    func request(_ convertible: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, headers: Headers = .basic, interceptor: RequestInterceptor? = nil) -> DataRequest {
        return request(convertible, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers.getHeader, interceptor: interceptor)
    }

    func request(endPoint: EndPoint, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: Headers = .basic, interceptor: RequestInterceptor? = nil) -> DataRequest {
        return request(endPoint, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers.getHeader, interceptor: interceptor)
    }

    func request(endPoint: EndPoint, method: HTTPMethod = .get, request req: Encodable, headers: Headers = .basic, interceptor: RequestInterceptor? = nil) -> DataRequest {
        return request(endPoint, method: method, parameters: req.getDictionary(), encoding: JSONEncoding.default, headers: headers.getHeader, interceptor: interceptor)
    }

    func requestToken(endPoint: EndPoint, method: HTTPMethod = .post, parameters: Parameters? = nil) -> DataRequest {
        return request(endPoint: endPoint, method: method, parameters: parameters, headers: .basic, interceptor: TokenInterceptor.shared)
    }

    func requestToken(endPoint: EndPoint, method: HTTPMethod = .post, request req: Encodable) -> DataRequest {
        return request(endPoint: endPoint, method: method, request: req, headers: .basic, interceptor: TokenInterceptor.shared)
    }

    func requestSignature(endPoint: EndPoint, method: HTTPMethod = .post, request req: Encodable, signature: (Encodable) -> String = ConfigRepository.shared.closureSignature) -> DataRequest {
        return request(endPoint: endPoint, method: method, request: req, headers: .signature(sign: signature(req)))
    }

    func requestSignatureToken(endPoint: EndPoint, method: HTTPMethod = .post, request req: Encodable, signature: (Encodable) -> String = ConfigRepository.shared.closureSignature) -> DataRequest {
        return request(endPoint: endPoint, method: method, request: req, headers: .signature(sign: signature(req)), interceptor: TokenInterceptor.shared)
    }
}
