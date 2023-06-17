//
//  CreateEnum.swift
//  Decele
//
//  Created by Mc Kevin on 24/06/23.
//

import Foundation

func addPrefix(_ prefix: String, _ name: String) -> String {
    "\(prefix)-\(name)"
}

func hasStylesAllowed(allStyles: [String], value: FontDicValue) -> Bool {
    switch value {
    case let .special1(special):
        return !onlyFiltersAllowed(allStyles: allStyles, styles: special.styles).isEmpty
    case .integer, .string:
        return true
    }
}

func onlyFiltersAllowed(allStyles: [String], styles: [String]) -> [String] {
    var stlyes = styles
    stlyes.removeAll(where: { !allStyles.contains($0) })
    return stlyes
}

@discardableResult
func createEnum(name: String, prefix: String, allStyles: [String], codepoints: String, pathEnum: String) -> Bool {
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

    fontEnum += "\n"

    fontEnum += """
    // MARK: - \(name)
    public enum \(name): String, FontName {

    """

    let filterKeys = fonts.filter { hasStylesAllowed(allStyles: allStyles, value: $0.value) }

    let sortedKeys = Array(filterKeys.keys).sorted(by: <)

    sortedKeys.forEach { key in
        guard fonts[key] != nil else { return }
        let value = addPrefix(prefix, key)
        let enumKeyName = value.camelCased(with: "-")
        fontEnum += """
            case \(enumKeyName) = \"\(value)\"
        """
        fontEnum += "\n"
    }

    fontEnum += "\n"

    fontEnum += """
        public var unicode: String {
            switch self {
    """

    fontEnum += "\n"

    sortedKeys.forEach { key in
        guard let value = fonts[key] else { return }
        let enumKeyName = addPrefix(prefix, key).camelCased(with: "-")
        fontEnum += """
                    case .\(enumKeyName): return \"\\u{\(value.getUnicode)}\"
        """
        fontEnum += "\n"
    }

    fontEnum += "\n"

    fontEnum += """
            }
        }
    """

    fontEnum += "\n"

    fontEnum += """
        public var supportedStyles: [\(name)Style] {
            switch self {
    """

    fontEnum += "\n"

    sortedKeys.forEach { key in
        guard let value = fonts[key] else { return }
        let enumKeyName = addPrefix(prefix, key).camelCased(with: "-")
        switch value {
        case let .special1(data):
            fontEnum += """
                        case .\(enumKeyName): return [.\(onlyFiltersAllowed(allStyles: allStyles, styles: data.styles).joined(separator: ", ."))]
            """

        case .integer, .string:
            fontEnum += """
                        case .\(enumKeyName): return [.\(allStyles.joined(separator: ", ."))]
            """
        }
        fontEnum += "\n"
    }

    fontEnum += "\n"

    fontEnum += """
            }
        }
    }
    """

    return FileManager.default.createFile(atPath: pathEnum, contents: fontEnum.data(using: .utf8), attributes: nil)
}

public extension String {
    func camelCased(with separator: Character) -> String {
        split(separator: separator).reduce("") { result, element in
            "\(result)\(result.count > 0 ? String(element.capitalized) : String(element))"
        }
    }
}
