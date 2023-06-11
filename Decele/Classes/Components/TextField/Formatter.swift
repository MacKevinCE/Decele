//
//  Formatter.swift
//  Decele
//
//  Created by Mc Kevin on 20/02/23.
//

// MARK: - Formatter
open class Formatter {
    private var next: Formatter?

    public init(next: Formatter?) {
        self.next = next
    }

    func setNext(next: Formatter?) {
        self.next = next
    }

    open func format(text: String) -> String {
        next?.format(text: text) ?? text
    }

    // MARK: - static/
    public static func maxLength(max: Int, next: Formatter? = nil) -> Formatter {
        MaxLengthFormatter(length: max, next: next)
    }

    public static func character(allowedCharacterSet: CharacterSet, next: Formatter? = nil) -> Formatter {
        CharacterFormatter(allowedCharacterSet: allowedCharacterSet, next: next)
    }

    public static func replace(replaceText: String, at: Int, next: Formatter? = nil) -> Formatter {
        ReplaceFormatter(replaceText: replaceText, at: at, next: next)
    }
}

// MARK: - MaxLengthFormatter
open class MaxLengthFormatter: Formatter {
    private let length: Int

    public init(length: Int, next: Formatter?) {
        self.length = length
        super.init(next: next)
    }

    override open func format(text: String) -> String {
        text.prefix(length).description
    }
}

// MARK: - CharacterFormatter
open class CharacterFormatter: Formatter {
    private let allowedCharacterSet: CharacterSet

    public init(allowedCharacterSet: CharacterSet, next: Formatter?) {
        self.allowedCharacterSet = allowedCharacterSet
        super.init(next: next)
    }

    override open func format(text: String) -> String {
        text.components(separatedBy: allowedCharacterSet.inverted).joined()
    }
}

// MARK: - ReplaceFormatter
open class ReplaceFormatter: Formatter {
    private let replaceText: String
    private let at: Int

    init(replaceText: String, at: Int, next: Formatter?) {
        self.replaceText = replaceText
        self.at = max(0, at)
        super.init(next: next)
    }

    override open func format(text: String) -> String {
        if text.count > at, !replaceText.isEmpty {
            let substrings = Array(1 ... replaceText.count).reversed().map { index in
                let endIndex = replaceText.index(replaceText.startIndex, offsetBy: index)
                return String(replaceText[..<endIndex])
            }
            if let rangeReplace = (substrings.reduce(into: nil) {
                $0 = (($0 != nil) ? $0 : text.range(of: $1, options: .caseInsensitive, range: text.index(text.startIndex, offsetBy: at) ..< text.endIndex))
            } ?? Range(NSRange(location: at, length: 0), in: text)) {
                let newText = text.replacingOccurrences(of: text[rangeReplace], with: "", range: rangeReplace)
                return String(newText.prefix(at)) + replaceText + String(newText.suffix(newText.count - at))
            } else {
                return text
            }
        } else {
            return text
        }
    }
}
