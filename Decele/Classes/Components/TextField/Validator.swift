//
//  Validator.swift
//  Decele
//
//  Created by Mc Kevin on 20/02/23.
//

// MARK: - Validator
open class Validator {
    private var next: Validator?
    private let failText: String

    public init(failText: String, next: Validator?) {
        self.next = next
        self.failText = failText
    }

    func setNext(next: Validator?) {
        self.next = next
    }

    public func failed() -> String? {
        failText
    }

    open func validate(_ text: String) -> String? {
        next?.validate(text)
    }

    // MARK: - static
    public static func length(length: Int, compareOptions: TextField.CompareOptions, failText: String = "length", next: Validator? = nil) -> Validator {
        LengthValidator(length: length, compareOptions: compareOptions, failText: failText, next: next)
    }

    public static func maxLength(max: Int, failText: String = "MaxLength", next: Validator? = nil) -> Validator {
        length(length: max, compareOptions: .greaterEqual, failText: failText, next: next)
    }

    public static func minLength(min: Int, failText: String = "MinLength", next: Validator? = nil) -> Validator {
        length(length: min, compareOptions: .lessEqual, failText: failText, next: next)
    }

    public static func rangeLength(max: Int, min: Int, failText: String = "RangeLength", next: Validator? = nil) -> Validator {
        maxLength(max: max, failText: failText, next: minLength(min: min, failText: failText, next: next))
    }

    public static func character(allowedCharacterSet: CharacterSet, failText: String = "Character", next: Validator? = nil) -> Validator {
        CharacterValidator(allowedCharacterSet: allowedCharacterSet, failText: failText, next: next)
    }

    public static func date(formatter: String, failText: String = "Date", next: Validator? = nil) -> Validator {
        DateValidator(formatter: formatter, failText: failText, next: next)
    }

    public static func search(text find: String, compareOptions: String.CompareOptions, rangeOptions: TextField.RangeOptions, failText: String = "Search", next: Validator? = nil) -> Validator {
        SearchValidator(text: find, compareOptions: compareOptions, rangeOptions: rangeOptions, failText: failText, next: next)
    }

    public static func regex(regex: String, failText: String = "Regex", next: Validator? = nil) -> Validator {
        search(text: regex, compareOptions: .regularExpression, rangeOptions: .equal, failText: failText, next: next)
    }

    public static func email(failText: String = "Email", next: Validator? = nil) -> Validator {
        regex(regex: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*$", failText: failText, next: next)
    }

    /// Example:  +51 987 654 321
    public static func phonePE(failText: String = "PhonePE", next: Validator? = nil) -> Validator {
        .regex(regex: #"^(?:\+51)?(?:\s)?9\d{2}(?:\s?\d{3}){2}$"#, failText: failText, next: next)
    }
}

// MARK: - LengthValidator
open class LengthValidator: Validator {
    private let length: Int
    private let compareOptions: TextField.CompareOptions

    public init(length: Int, compareOptions: TextField.CompareOptions, failText: String, next: Validator?) {
        self.length = length
        self.compareOptions = compareOptions
        super.init(failText: failText, next: next)
    }

    override open func validate(_ text: String) -> String? {
        if compareOptions.contains(.less), !(text.count < length) {
            guard compareOptions.contains(.equal), text.count == length else {
                return super.failed()
            }
        }

        if compareOptions.contains(.greater), !(text.count > length) {
            guard compareOptions.contains(.equal), text.count == length else {
                return super.failed()
            }
        }

        if compareOptions.contains(.equal), !(text.count == length) {
            if !compareOptions.contains(.less) || !(text.count < length) {
                if !compareOptions.contains(.greater) || !(text.count > length) {
                    return super.failed()
                }
            }
        }

        return super.validate(text)
    }
}

// MARK: - CharacterValidator
open class CharacterValidator: Validator {
    private let allowedCharacterSet: CharacterSet

    public init(allowedCharacterSet: CharacterSet, failText: String, next: Validator?) {
        self.allowedCharacterSet = allowedCharacterSet
        super.init(failText: failText, next: next)
    }

    override open func validate(_ text: String) -> String? {
        guard text.rangeOfCharacter(from: allowedCharacterSet.inverted) == nil else {
            return super.failed()
        }

        return super.validate(text)
    }
}

// MARK: - DateValidator
open class DateValidator: Validator {
    private let formatter: String

    public init(formatter: String, failText: String, next: Validator?) {
        self.formatter = formatter
        super.init(failText: failText, next: next)
    }

    override open func validate(_ text: String) -> String? {
        guard date(text: text, withFormat: formatter) != nil else {
            return super.failed()
        }
        return super.validate(text)
    }

    private func date(text: String, withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: text)
    }
}

// MARK: - SearchValidator
open class SearchValidator: Validator {
    private let textFind: String
    private let compareOptions: String.CompareOptions
    private let rangeOptions: TextField.RangeOptions

    public init(text find: String, compareOptions: String.CompareOptions, rangeOptions: TextField.RangeOptions, failText: String, next: Validator?) {
        self.textFind = find
        self.compareOptions = compareOptions
        self.rangeOptions = rangeOptions
        super.init(failText: failText, next: next)
    }

    override open func validate(_ text: String) -> String? {
        guard let range = text.range(of: textFind, options: compareOptions) else {
            return super.failed()
        }

        guard !rangeOptions.contains(.prefix) || (range.lowerBound == text.startIndex) else {
            return super.failed()
        }

        guard !rangeOptions.contains(.suffix) || (range.upperBound == text.endIndex) else {
            return super.failed()
        }

        return super.validate(text)
    }
}
