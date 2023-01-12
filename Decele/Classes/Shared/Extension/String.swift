//
//  String.swift
//  Chuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

extension String {
    var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var urlDecoded: String {
        return removingPercentEncoding ?? self
    }

    var nsString: NSString {
        return NSString(string: self)
    }

    func null() -> String? { isEmpty ? nil : self }

    func unaccent() -> String {
        let components = self.components(separatedBy: "ñ")
        let parts = components.map {
            $0.folding(options: .diacriticInsensitive, locale: .current)
        }
        return parts.joined(separator: "ñ")
    }

    func visible() -> String {
        return replacingOccurrences(of: "\r", with: "\\r")
            .replacingOccurrences(of: "\n", with: "\\n")
            .replacingOccurrences(of: "\t", with: "\\t")
    }

    func visibleUltra() -> String {
        return visible()
            .replacingOccurrences(of: " ", with: "(space)")
    }

    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [NSRange] {
        var result: [NSRange] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
              let range = self[startIndex...]
              .range(of: string, options: options)
        {
            result.append(NSRange(range, in: self))
            startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }

    func resume(pre: UInt = 50, suf: UInt = 50) -> String {
        if count > (pre + suf) {
            let pre = prefix(Int(pre))
            let post = suffix(Int(suf))
            return "\(pre)...\(post)"
        } else {
            return self
        }
    }

    public func initAttributeText(color: UIColor? = nil, font: UIFont? = nil, isUnderline: Bool = false, backgroundColor: UIColor? = nil) -> NSMutableAttributedString {
        NSMutableAttributedString(string: self).addAttributeText(color: color, font: font, isUnderline: isUnderline, backgroundColor: backgroundColor)
    }

    public func initAttributeIndentation(indentation: CGFloat = 20) -> NSMutableAttributedString {
        NSMutableAttributedString(string: self).addAttributeIndentation(indentation: indentation)
    }

    func height(with width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = nsString.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(with height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = nsString.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
