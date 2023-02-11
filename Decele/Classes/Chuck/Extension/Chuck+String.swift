//
//  Decele+String.swift
//  Decele
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

extension String {
    func visible() -> String {
        return replacingOccurrences(of: "\r", with: "\\r")
            .replacingOccurrences(of: "\n", with: "\\n")
            .replacingOccurrences(of: "\t", with: "\\t")
    }

    func visibleUltra() -> String {
        return visible()
            .replacingOccurrences(of: " ", with: "(space)")
    }
}
