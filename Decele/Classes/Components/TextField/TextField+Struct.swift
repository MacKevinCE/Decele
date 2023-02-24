//
//  TextField+Struct.swift
//  Decele
//
//  Created by Mc Kevin on 22/02/23.
//

public extension TextField {
    // MARK: - CompareOptions
    struct CompareOptions: OptionSet {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        public static let equal = CompareOptions(rawValue: 1 << 0)
        public static let less = CompareOptions(rawValue: 1 << 1)
        public static let greater = CompareOptions(rawValue: 1 << 2)
        public static let lessEqual: CompareOptions = [.less, .equal]
        public static let greaterEqual: CompareOptions = [.greater, .equal]
    }

    // MARK: - RangeOptions
    struct RangeOptions: OptionSet {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        public static let prefix = RangeOptions(rawValue: 1 << 0)
        public static let suffix = RangeOptions(rawValue: 1 << 1)
        public static let equal: RangeOptions = [.prefix, .suffix]
    }

    // MARK: - CharacterType
    enum CharacterType: String, CaseIterable {
        case anyUppercase = "X"
        case onlyUppercaseLetter = "A"
        case onlyUppercaseNumber = "N"
        case anyLowercase = "x"
        case onlyLowercaseLetter = "a"
        case nlyLowercaseNumber = "n"
        case onlySpecial = "S"
    }
}
