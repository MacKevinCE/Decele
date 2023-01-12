//
//  Array.swift
//  Chuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

extension Array {
    func first<T>(with type: T.Type) -> T? {
        first(where: { ($0 as? T) != nil }) as? T
    }
}

extension Array where Element: Hashable {
    mutating func uniqued() {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        self = buffer
    }
}
