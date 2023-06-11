//
//  AttributedStringConvertible.swift
//  Decele
//
//  Created by Mc Kevin on 9/01/23.
//

import Foundation

// MARK: - AttributedStringConvertible
public protocol AttributedStringConvertible {
    func asMutableAttributedString() -> NSMutableAttributedString
}

// MARK: - String + AttributedStringConvertible
extension String: AttributedStringConvertible {
    public func asMutableAttributedString() -> NSMutableAttributedString { .init(string: self) }
}

// MARK: - Character + AttributedStringConvertible
extension Character: AttributedStringConvertible {
    public func asMutableAttributedString() -> NSMutableAttributedString { .init(string: self.string) }
}

// MARK: - Int + AttributedStringConvertible
extension Int: AttributedStringConvertible {
    public func asMutableAttributedString() -> NSMutableAttributedString { .init(string: self.string) }
}

// MARK: - Double + AttributedStringConvertible
extension Double: AttributedStringConvertible {
    public func asMutableAttributedString() -> NSMutableAttributedString { .init(string: self.string) }
}

// MARK: - Float + AttributedStringConvertible
extension Float: AttributedStringConvertible {
    public func asMutableAttributedString() -> NSMutableAttributedString { .init(string: self.string) }
}

// MARK: - Substring + AttributedStringConvertible
extension Substring: AttributedStringConvertible {
    public func asMutableAttributedString() -> NSMutableAttributedString { .init(string: String(self)) }
}

// MARK: - NSAttributedString + AttributedStringConvertible
extension NSAttributedString: AttributedStringConvertible {
    public func asMutableAttributedString() -> NSMutableAttributedString { .init(attributedString: self) }
}

// MARK: - AttributedString + AttributedStringConvertible
@available(iOS 15, *)
extension AttributedString: AttributedStringConvertible {
    public func asMutableAttributedString() -> NSMutableAttributedString { .init(self) }
}
