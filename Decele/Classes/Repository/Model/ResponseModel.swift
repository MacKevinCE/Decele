//
//  ResponseModel.swift
//  Decele
//
//  Created by Mc Kevin on 4/01/23.
//

import Foundation

public struct ResponseModel<T: Decodable>: Decodable {
    let message: MessageModel?
    let payload: T?
}
