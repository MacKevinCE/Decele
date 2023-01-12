//
//  Repository.swift
//  Repository
//
//  Created by Mc Kevin on 3/01/23.
//

import Alamofire

public class Repository {
    public static let shared = Repository()

    public func requestCustom(_ convertible: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: Headers = .basic, interceptor: RequestInterceptor? = nil) -> DataRequest {
        return AF.request(convertible, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers.getHeader, interceptor: interceptor)
    }

    public func requestBasic(_ convertible: EndPoint, method: HTTPMethod = .get, request: Encodable? = nil, headers: Headers = .basic, interceptor: RequestInterceptor? = nil) -> DataRequest {
        return AF.request(convertible.endPoint, method: method, parameters: request?.getDictionary(), encoding: JSONEncoding.default, headers: headers.getHeader, interceptor: interceptor)
    }

    public func requestToken(_ convertible: EndPoint, method: HTTPMethod = .post, request: Encodable? = nil) -> DataRequest {
        return requestBasic(convertible, method: method, request: request, headers: .basic, interceptor: TokenInterceptor.shared)
    }

    public func requestSignature(_ convertible: EndPoint, method: HTTPMethod = .post, request: Encodable, signature: (Encodable) -> String) -> DataRequest {
        return requestBasic(convertible, method: method, request: request, headers: .signature(sign: signature(request)))
    }

    public func requestSignatureToken(_ convertible: EndPoint, method: HTTPMethod = .post, request: Encodable, signature: (Encodable) -> String) -> DataRequest {
        return requestBasic(convertible, method: method, request: request, headers: .signature(sign: signature(request)), interceptor: TokenInterceptor.shared)
    }
}
