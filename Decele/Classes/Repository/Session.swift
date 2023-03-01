//
//  Decele.swift
//  Decele
//
//  Created by Mc Kevin on 3/01/23.
//

import Alamofire

public extension Session {
    func request(_ convertible: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, headers: Headers = .basic, interceptor: RequestInterceptor? = nil) -> DataRequest {
        request(convertible, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers.getHeader, interceptor: interceptor)
    }

    func request(endPoint: EndPoint, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: Headers = .basic, interceptor: RequestInterceptor? = nil) -> DataRequest {
        request(endPoint, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers.getHeader, interceptor: interceptor)
    }

    func request(endPoint: EndPoint, method: HTTPMethod = .get, request req: Encodable, headers: Headers = .basic, interceptor: RequestInterceptor? = nil) -> DataRequest {
        request(endPoint, method: method, parameters: req.getDictionary(), encoding: JSONEncoding.default, headers: headers.getHeader, interceptor: interceptor)
    }

    func requestToken(endPoint: EndPoint, method: HTTPMethod = .post, parameters: Parameters? = nil) -> DataRequest {
        request(endPoint: endPoint, method: method, parameters: parameters, headers: .basic, interceptor: ConfigRepository.shared.tokenInterceptor)
    }

    func requestToken(endPoint: EndPoint, method: HTTPMethod = .post, request req: Encodable) -> DataRequest {
        request(endPoint: endPoint, method: method, request: req, headers: .basic, interceptor: ConfigRepository.shared.tokenInterceptor)
    }

    func requestSignature(endPoint: EndPoint, method: HTTPMethod = .post, request req: Encodable, signature: (Encodable) -> String = ConfigRepository.shared.closureSignature) -> DataRequest {
        request(endPoint: endPoint, method: method, request: req, headers: .signature(sign: signature(req)))
    }

    func requestSignatureToken(endPoint: EndPoint, method: HTTPMethod = .post, request req: Encodable, signature: (Encodable) -> String = ConfigRepository.shared.closureSignature) -> DataRequest {
        request(endPoint: endPoint, method: method, request: req, headers: .signature(sign: signature(req)), interceptor: ConfigRepository.shared.tokenInterceptor)
    }
}
