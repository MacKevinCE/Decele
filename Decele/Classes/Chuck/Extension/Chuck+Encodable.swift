//
//  Decele+Encodable.swift
//  Decele
//
//  Created by Mc Kevin on 10/01/23.
//
import SwifterSwift

extension Encodable {
    func toPrettyPrintedJSONString() -> String {
        return self.encode?.prettyPrintedJSONString.nonEmpty ?? .empty
    }
}
