//
//  ErrorModel.swift
//  Decele
//
//  Created by Mc Kevin on 8/01/23.
//

// MARK: - ErrorModelProtocol
public protocol ErrorModelProtocol {
    var messageModelGeneric: MessageModel { get }
    func getMessageModel(statusCode: Int) -> MessageModel?
    func getMessageModel(error: Error) -> MessageModel?
}

// MARK: - ErrorModel
public struct ErrorModel: ErrorModelProtocol {
    public init() {}

    public var messageModelGeneric: MessageModel {
        MessageModel(code: .zero, title: "messageModelGeneric", message: "messageModelGeneric")
    }

    public func getMessageModel(statusCode: Int) -> MessageModel? {
        nil
    }

    public func getMessageModel(error: Error) -> MessageModel? {
        nil
    }
}
