//
//  CreateEnum.swift
//  Decele
//
//  Created by Mc Kevin on 24/06/23.
//

import Foundation

func onlyFiltersAllowed(allStyles: [String], value: FontDicValue) -> [String] {
    switch value {
    case let .special1(special):
        var stlyes = special.styles
        stlyes.removeAll(where: { !allStyles.contains($0) })
        return stlyes
    case .integer, .string:
        return allStyles
    }
}

@discardableResult
func createEnum(importDecele: Bool, name: String, prefix: String, allStyles: [String], codepoints: String, pathEnum: String) -> Bool {
    guard let json = FileManager.default.contents(atPath: codepoints) else { return false }
    guard let fonts = try? JSONDecoder().decode(FontDic.self, from: json) else { return false }

    var fontEnum = ""

    fontEnum += """
    //
    //  \(name).swift
    //  Decele
    //
    //  Created by Mc Kevin on 25/06/23.
    //

    """

    if importDecele {
        fontEnum += """

        import Decele

        """
    }

    fontEnum += """

    // MARK: - \(name)
    public enum \(name): String, FontName {

    """

    let filterKeys = fonts.filter {
        !onlyFiltersAllowed(allStyles: allStyles, value: $0.value).isEmpty
    }

    let sortedKeys = Array(filterKeys.keys).sorted(by: <)

    sortedKeys.forEach { key in
        guard fonts[key] != nil else { return }
        let value = "\(prefix)-\(key)"
        let enumKeyName = value.camelCased
        fontEnum += """
            case \(enumKeyName) = \"\(value)\"

        """
    }

    fontEnum += """

        public var unicode: String {
            switch self {

    """

    sortedKeys.forEach { key in
        guard let value = fonts[key] else { return }
        let enumKeyName = "\(prefix)-\(key)".camelCased
        fontEnum += """
                case .\(enumKeyName): return \"\\u{\(value.getUnicode)}\"

        """
    }

    fontEnum += """
            }
        }

    """

    fontEnum += """

        public var supportedStyles: [\(name)Style] {
            switch self {

    """

    sortedKeys.forEach { key in
        guard let value = fonts[key] else { return }
        let enumKeyName = "\(prefix)-\(key)".camelCased
        let styles = onlyFiltersAllowed(allStyles: allStyles, value: value)
        fontEnum += """
                case .\(enumKeyName): return [.\(styles.joined(separator: ", ."))]

        """
    }

    fontEnum += """
            }
        }
    }

    """

    return FileManager.default.createFile(atPath: pathEnum, contents: fontEnum.data(using: .utf8), attributes: nil)
}

public extension String {
    var camelCased: String {
        let components = self.components(separatedBy: CharacterSet.alphanumerics.inverted)
        let capitalizedComponents = components.map(\.capitalized)
        let joinedString = capitalizedComponents.joined()
        let firstCharacter = String(joinedString.prefix(1)).lowercased()
        let camelCaseString = firstCharacter + String(joinedString.dropFirst())
        return camelCaseString
    }

    var bool: Bool? {
        let selfLowercased = trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        switch selfLowercased {
        case "true", "yes", "1":
            return true
        case "false", "no", "0":
            return false
        default:
            return nil
        }
    }
}
