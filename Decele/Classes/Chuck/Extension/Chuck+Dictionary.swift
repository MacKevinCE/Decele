//
//  Dictionary.swift
//  Alamofire
//
//  Created by Mc Kevin on 11/01/23.
//

import UIKit

extension Dictionary where Key == String, Value == String {
    func toString() -> String {
        reduce(.empty) { ($1.value != .empty) ? "\($0)\n(\($1.key)): \($1.value)" : .empty }
    }

    func toAttributedString() -> NSMutableAttributedString {
        reduce(String.empty.initAttributeText(font: .regular14)) {
            ($1.value != .empty) ? $0.printParStringForChuck($1).printEnter() : $0
        }
    }
}
