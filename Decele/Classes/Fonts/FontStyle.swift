//
//  FontStyle.swift
//  Decele
//
//  Created by Mc Kevin on 24/06/23.
//

import Foundation

// MARK: - FontStyle
public protocol FontStyle: Equatable, CaseIterable {
    static var tag: String { get }
    var fontFilePath: String { get }

    init?(rawValue: String)
    var rawValue: String { get }
}

extension FontStyle {
    static var name: String {
        let input = String(describing: Self.self)
        if let range = input.range(of: "Style", options: .backwards) {
            return input.replacingCharacters(in: range, with: "")
        } else {
            return input
        }
    }
}
