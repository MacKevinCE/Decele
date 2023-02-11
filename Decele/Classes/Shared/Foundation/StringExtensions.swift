//
//  StringExtensions.swift
//  Decele
//
//  Created by Mc Kevin on 27/01/23.
//

public extension String {
    var nullable: String? { return isEmpty ? nil : self }

    var unaccent: String {
        let parts = components(separatedBy: "ñ").map { p in p.folding(options: .diacriticInsensitive, locale: .current) }
        return parts.joined(separator: "ñ")
    }

    func truncated(prefixLength: Int, suffixLength: Int, trailing: String? = "...") -> String {
        if count > (prefixLength + suffixLength) {
            let pre = prefix(prefixLength)
            let post = suffix(suffixLength)
            return "\(pre)\(trailing ?? "")\(post)"
        } else {
            return self
        }
    }

    func ranges(of textFind: String, options mask: NSString.CompareOptions = []) -> [NSRange] {
        var ranges: [NSRange] = []

        var range = NSRange(location: 0, length: count)
        while range.location != NSNotFound {
            range = NSMutableString(string: self).range(of: textFind, options: mask, range: range)
            if range.location != NSNotFound {
                ranges.append(range)
                let location = range.location + range.length
                range = NSRange(location: location, length: count - location)
            }
        }
        return ranges
    }
}

public extension String {
    func applying(attributes: [NSAttributedString.Key: Any]) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self, attributes: attributes)
    }

    func colored(with color: UIColor) -> NSMutableAttributedString {
        return applying(attributes: [.foregroundColor: color])
    }

    func backgroundColored(with backgroundColor: UIColor) -> NSMutableAttributedString {
        return applying(attributes: [.backgroundColor: backgroundColor])
    }

    func fonted(with font: UIFont) -> NSMutableAttributedString {
        return applying(attributes: [.font: font])
    }

    func underlined() -> NSMutableAttributedString {
        return applying(attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }

    func struckthrough() -> NSMutableAttributedString {
        return applying(attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)])
    }

    func indented(with indentation: CGFloat) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        let nonOptions = [NSTextTab.OptionKey: Any]()
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: indentation, options: nonOptions)]
        paragraphStyle.defaultTabInterval = indentation
        paragraphStyle.headIndent = indentation
        return applying(attributes: [.paragraphStyle: paragraphStyle])
    }

    func applying(font: UIFont? = nil, color: UIColor? = nil, backgroundColor: UIColor? = nil, indentation: CGFloat? = nil, isUnderline: Bool = false, isStruckthrough: Bool = false) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self).applying(font: font, color: color, backgroundColor: backgroundColor, indentation: indentation, isUnderline: isUnderline, isStruckthrough: isStruckthrough)
    }
}
