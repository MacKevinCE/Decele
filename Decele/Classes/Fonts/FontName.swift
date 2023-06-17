//
//  FontName.swift
//  Decele
//
//  Created by Mc Kevin on 25/06/23.
//

import UIKit

// MARK: - FontName
public protocol FontName: CaseIterable {
    associatedtype FS: FontStyle
    var unicode: String { get }
    var supportedStyles: [FS] { get }

    init?(rawValue: String)
    var rawValue: String { get }
}

public extension FontName {
    func isSupported(style: FS) -> Bool {
        self.supportedStyles.contains(where: { $0 == style })
    }

    static func fontList(style: FS) -> [Self] {
        allCases.filter {
            $0.isSupported(style: style)
        }
    }

    static func font(ofSize fontSize: CGFloat, style: FS) -> UIFont {
        style.loadFont()
        let getFontNames = style.getFontNames()
        return UIFont(name: getFontNames.postScriptName, size: fontSize)!
    }

    private static func string(name: Self) -> String {
        let toIndex = name.unicode.index(name.unicode.startIndex, offsetBy: 1)
        return String(name.unicode[name.unicode.startIndex ..< toIndex])
    }

    private static func string(code: String) -> String? {
        guard let name = Self(rawValue: code) else {
            return nil
        }

        return self.string(name: name)
    }

    static func image(name: Self, style: Self.FS, textColor: UIColor, size: CGSize, backgroundColor: UIColor = .clear, borderWidth: CGFloat = 0, borderColor: UIColor = .clear) -> UIImage? {
        guard name.isSupported(style: style) else { return nil }
        // Prevent application crash when passing size where width or height is set equal to or less than zero, by clipping width and height to a minimum of 1 pixel.
        var size = size
        if size.width <= 0 { size.width = 1 }
        if size.height <= 0 { size.height = 1 }

        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = NSTextAlignment.center

        let fontSize = min(size.width / FontSetting.shared.fontAspectRatio, size.height)

        // stroke width expects a whole number percentage of the font size
        let strokeWidth: CGFloat = fontSize == 0 ? 0 : (-100 * borderWidth / fontSize)

        let attributedString = NSAttributedString(string: string(name: name), attributes: [
            NSAttributedString.Key.font: font(ofSize: fontSize, style: style),
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.backgroundColor: backgroundColor,
            NSAttributedString.Key.paragraphStyle: paragraph,
            NSAttributedString.Key.strokeWidth: strokeWidth,
            NSAttributedString.Key.strokeColor: borderColor,
        ])

        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        attributedString.draw(in: CGRect(x: 0, y: (size.height - fontSize) / 2, width: size.width, height: fontSize))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    static func image(code: String, style: Self.FS, textColor: UIColor, size: CGSize, backgroundColor: UIColor = .clear, borderWidth: CGFloat = 0, borderColor: UIColor = .clear) -> UIImage? {
        guard let name = Self(rawValue: code) else { return nil }
        return image(name: name, style: style, textColor: textColor, size: size, backgroundColor: backgroundColor, borderWidth: borderWidth, borderColor: borderColor)
    }
}
