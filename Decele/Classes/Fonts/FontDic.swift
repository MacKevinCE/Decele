//
//  FontDic.swift
//  FontsTools
//
//  Created by Mc Kevin on 25/06/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

// MARK: - FontDicValue
enum FontDicValue: Codable {
    case special1(Special1)
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(Special1.self) {
            self = .special1(x)
            return
        }
        throw DecodingError.typeMismatch(FontDicValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for FontDicValue"))
    }

    var getUnicode: String {
        switch self {
        case let .special1(special):
            return special.unicode.getUnicode
        case let .integer(int):
            return int.toHexa()
        case let .string(string):
            return string
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .special1(x):
            try container.encode(x)
        case let .integer(x):
            try container.encode(x)
        case let .string(x):
            try container.encode(x)
        }
    }
}

// MARK: - FontDicClass
struct Special1: Codable {
    let unicode: Unicode
    let styles: [String]
}

// MARK: - Unicode
enum Unicode: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Unicode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Unicode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .integer(x):
            try container.encode(x)
        case let .string(x):
            try container.encode(x)
        }
    }

    var getUnicode: String {
        switch self {
        case let .integer(int):
            return int.toHexa()
        case let .string(string):
            return string
        }
    }
}

typealias FontDic = [String: FontDicValue]

public extension Int {
    func toHexa() -> String {
        var decimalNumber = self
        var hexadecimalString = ""

        while decimalNumber > 0 {
            let remainder = decimalNumber % 16

            if remainder < 10 {
                hexadecimalString = String(remainder) + hexadecimalString
            } else {
                let unicodeScalar = UnicodeScalar(remainder + 55)!
                hexadecimalString = String(unicodeScalar) + hexadecimalString
            }

            decimalNumber /= 16
        }

        return hexadecimalString
    }
}
