//
//  Debug.swift
//  Decele
//
//  Created by Mc Kevin on 8/01/23.
//

import Alamofire

// MARK: - DebugProtocol
public protocol DebugProtocol {
    func printResponse<Success>(_ response: DataResponse<Success, AFError>)
    func printError(_ error: Error)
}

// MARK: - Debug
public struct Debug: DebugProtocol {
    public init() {}

    public func printResponse<Success>(_ response: DataResponse<Success, AFError>) {}

    public func printError(_ error: Error) {
        if let err = error as? DecodingError {
            switch err {
            case let .typeMismatch(type, context):
                debugPrint("[DecodingError] typeMismatch, type: \(type), context: \(context.debugDescription)")
            case let .valueNotFound(type, context):
                debugPrint("[DecodingError] valueNotFound, type: \(type), context: \(context.debugDescription)")
            case let .keyNotFound(type, context):
                debugPrint("[DecodingError] keyNotFound, type: \(type.stringValue), context: \(context.debugDescription)")
            case let .dataCorrupted(context):
                debugPrint("[DecodingError] dataCorrupted , context: \(context.debugDescription)")
            @unknown default:
                debugPrint("[DecodingError] unkonwn Error: \(err.localizedDescription)")
            }
        } else if let err = error as? EncodingError {
            switch err {
            case let .invalidValue(data, context):
                debugPrint("[EncodingError] invalidValue, data: \(data), context: \(context.debugDescription)")
            @unknown default:
                debugPrint("[EncodingError] unkonwn Error: \(err.localizedDescription)")
            }
        } else if let err = error as? MessageModel {
            debugPrint("[MessageModel \(err.code)] \(err.title): \(err.message)")
        } else if let err = error as? AFError {
            debugPrint("[AFError] \(err.errorDescription ?? err.localizedDescription)")
        } else {
            debugPrint("[Error] \(error.localizedDescription)")
        }
    }
}
