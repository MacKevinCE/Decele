//
//  MessageModel.swift
//  Decele
//
//  Created by Mc Kevin on 3/01/23.
//

import Foundation

public struct MessageModel: Error, Decodable {
    let statusCode: Int
    let title: String
    let message: String
}
