//
//  FontStyle.swift
//  Decele
//
//  Created by Mc Kevin on 24/06/23.
//

import Foundation

// MARK: - FontStyle
public protocol FontStyle: Equatable, CaseIterable {
    static var name: String { get }
    static var prefix: String { get }
    static var tag: String { get }
    var fontFilePath: String { get }

    init?(rawValue: String)
    var rawValue: String { get }
}
