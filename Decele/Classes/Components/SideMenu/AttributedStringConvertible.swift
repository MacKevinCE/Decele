//
//  AttributedStringConvertible.swift
//  Decele
//
//  Created by Mc Kevin on 9/01/23.
//

import Foundation

public protocol AttributedStringConvertible {
    func asMutableAttributedString() -> NSMutableAttributedString
}

extension String: AttributedStringConvertible {
    public func asMutableAttributedString() -> NSMutableAttributedString { return .init(string: self) }
}

extension NSAttributedString: AttributedStringConvertible {
    public func asMutableAttributedString() -> NSMutableAttributedString { return .init(attributedString: self) }
}

@available(iOS 15, *)
extension AttributedString: AttributedStringConvertible {
    public func asMutableAttributedString() -> NSMutableAttributedString { return .init(self) }
}
