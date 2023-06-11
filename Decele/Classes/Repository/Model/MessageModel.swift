//
//  MessageModel.swift
//  Decele
//
//  Created by Mc Kevin on 3/01/23.
//

import Foundation

public struct MessageModel: Error, Decodable {
    public let code: Int
    public let title: String
    public let message: String
}
