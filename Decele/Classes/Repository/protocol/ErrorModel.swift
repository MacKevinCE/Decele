//
//  ErrorModel.swift
//  Decele
//
//  Created by Mc Kevin on 8/01/23.
//

import Alamofire

public protocol ErrorModelProtocol {
    var messageModelNil: MessageModel { get }
    func getMessageModel(statusCode: Int) -> MessageModel?
    func getMessageModel(error: AFError) -> MessageModel?
}

struct ErrorModel: ErrorModelProtocol {
    var messageModelNil: MessageModel {
        return MessageModel(statusCode: Int.max, title: "messageModelNil", message: "messageModelNil")
    }

    func getMessageModel(statusCode: Int) -> MessageModel? {
        return nil
    }

    func getMessageModel(error: AFError) -> MessageModel? {
        return nil
    }
}
