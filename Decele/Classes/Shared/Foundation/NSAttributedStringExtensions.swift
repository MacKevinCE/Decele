//
//  NSAttributedStringExtensions.swift
//  Decele
//
//  Created by Mc Kevin on 27/01/23.
//

public extension NSMutableAttributedString {
    @discardableResult
    func applying(attributes: [NSAttributedString.Key: Any], range: NSRange) -> NSMutableAttributedString {
        addAttributes(attributes, range: range)
        return self
    }

    @discardableResult
    func colored(with color: UIColor, range: NSRange) -> NSMutableAttributedString {
        return applying(attributes: [.foregroundColor: color], range: range)
    }

    @discardableResult
    func backgroundColored(with backgroundColor: UIColor, range: NSRange) -> NSMutableAttributedString {
        return applying(attributes: [.backgroundColor: backgroundColor], range: range)
    }

    @discardableResult
    func fonted(with font: UIFont, range: NSRange) -> NSMutableAttributedString {
        return applying(attributes: [.font: font], range: range)
    }

    @discardableResult
    func underlined(range: NSRange) -> NSMutableAttributedString {
        return applying(attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue], range: range)
    }

    @discardableResult
    func struckthrough(range: NSRange) -> NSMutableAttributedString {
        return applying(attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)], range: range)
    }

    @discardableResult
    func indented(with indentation: CGFloat, range: NSRange) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        let nonOptions = [NSTextTab.OptionKey: Any]()
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: indentation, options: nonOptions)]
        paragraphStyle.defaultTabInterval = indentation
        paragraphStyle.headIndent = indentation
        return applying(attributes: [.paragraphStyle: paragraphStyle], range: range)
    }

    @discardableResult
    func applying(range: NSRange, font: UIFont? = nil, color: UIColor? = nil, backgroundColor: UIColor? = nil, indentation: CGFloat? = nil, isUnderline: Bool = false, isStruckthrough: Bool = false) -> NSMutableAttributedString {
        if let font = font {
            fonted(with: font, range: range)
        }
        if let color = color {
            colored(with: color, range: range)
        }
        if let backgroundColor = backgroundColor {
            backgroundColored(with: backgroundColor, range: range)
        }
        if let indentation = indentation {
            indented(with: indentation, range: range)
        }
        if isUnderline {
            underlined(range: range)
        }
        if isStruckthrough {
            struckthrough(range: range)
        }
        return self
    }

    @discardableResult
    func applying(ranges: [NSRange], font: UIFont? = nil, color: UIColor? = nil, backgroundColor: UIColor? = nil, indentation: CGFloat? = nil, isUnderline: Bool = false, isStruckthrough: Bool = false) -> NSMutableAttributedString {
        ranges.forEach {
            applying(range: $0, font: font, color: color, backgroundColor: backgroundColor, indentation: indentation, isUnderline: isUnderline, isStruckthrough: isStruckthrough)
        }
        return self
    }

    @discardableResult
    func applying(font: UIFont? = nil, color: UIColor? = nil, backgroundColor: UIColor? = nil, indentation: CGFloat? = nil, isUnderline: Bool = false, isStruckthrough: Bool = false) -> NSMutableAttributedString {
        let range = (string as NSString).range(of: string)
        return applying(range: range, font: font, color: color, backgroundColor: backgroundColor, indentation: indentation, isUnderline: isUnderline, isStruckthrough: isStruckthrough)
    }

    @discardableResult
    func applying(toOccurrencesOf textFind: String, font: UIFont? = nil, color: UIColor? = nil, backgroundColor: UIColor? = nil, indentation: CGFloat? = nil, isUnderline: Bool = false, isStruckthrough: Bool = false) -> NSMutableAttributedString {
        if textFind != .empty {
            let ranges = string.ranges(of: textFind)
            applying(ranges: ranges, font: font, color: color, backgroundColor: backgroundColor, indentation: indentation, isUnderline: isUnderline, isStruckthrough: isStruckthrough)
        }
        return self
    }

    @discardableResult
    func applying(textFind: String, font: UIFont? = nil, color: UIColor? = nil, backgroundColor: UIColor? = nil, indentation: CGFloat? = nil, isUnderline: Bool = false, isStruckthrough: Bool = false) -> NSMutableAttributedString {
        if textFind != .empty {
            let range = (string as NSString).range(of: textFind)
            applying(range: range, font: font, color: color, backgroundColor: backgroundColor, indentation: indentation, isUnderline: isUnderline, isStruckthrough: isStruckthrough)
        }
        return self
    }

    @discardableResult
    func addTextApplying(text: String, font: UIFont? = nil, color: UIColor? = nil, backgroundColor: UIColor? = nil, indentation: CGFloat? = nil, isUnderline: Bool = false, isStruckthrough: Bool = false) -> NSMutableAttributedString {
        if text != .empty {
            let attributedString = text.applying(font: font, color: color, backgroundColor: backgroundColor, indentation: indentation, isUnderline: isUnderline, isStruckthrough: isStruckthrough)
            append(attributedString)
        }
        return self
    }
}

public extension NSAttributedString {
    static func += (lhs: inout NSAttributedString, rhs: NSAttributedString) {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        lhs = string
    }

    static func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        return NSAttributedString(attributedString: string)
    }

    static func += (lhs: inout NSAttributedString, rhs: String) {
        lhs += NSAttributedString(string: rhs)
    }

    static func + (lhs: NSAttributedString, rhs: String) -> NSAttributedString {
        return lhs + NSAttributedString(string: rhs)
    }
}

public extension NSAttributedString {
    var attributes: [NSAttributedString.Key: Any] {
        guard length > 0 else { return [:] }
        return attributes(at: 0, effectiveRange: nil)
    }

    func applying(attributes: [NSAttributedString.Key: Any],
                  toRangesMatching pattern: String,
                  options: NSRegularExpression.Options = []) -> NSAttributedString
    {
        guard let pattern = try? NSRegularExpression(pattern: pattern, options: options) else { return self }

        let matches = pattern.matches(in: string, options: [], range: NSRange(0 ..< length))
        let result = NSMutableAttributedString(attributedString: self)

        for match in matches {
            result.addAttributes(attributes, range: match.range)
        }

        return result
    }

    func applying<T: StringProtocol>(attributes: [NSAttributedString.Key: Any], toOccurrencesOf target: T) -> NSAttributedString {
        let pattern = "\\Q\(target)\\E"
        return applying(attributes: attributes, toRangesMatching: pattern)
    }
}
