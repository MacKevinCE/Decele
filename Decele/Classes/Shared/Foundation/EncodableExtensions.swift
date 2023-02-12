//
//  EncodableExtensions.swift
//  Decele
//
//  Created by Mc Kevin on 27/01/23.
//
import SwifterSwift

public extension Encodable {
    var encode: Data? {
        do {
            let encoder = JSONEncoder()
            return try encoder.encode(self)
        } catch {
            return nil
        }
    }

    func getDictionary() -> [String: Any]? {
        do {
            return try encode?.jsonObject() as? [String: Any]
        } catch {
            return nil
        }
    }

    func toPrettyPrintedJSONString() -> String {
        return self.encode?.prettyPrintedJSONString.nonEmpty ?? .empty
    }
}
