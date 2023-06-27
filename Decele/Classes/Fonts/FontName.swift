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

extension FontName {
    private func isSupportedF(style: FS) -> Bool {
        self.supportedStyles.contains(style)
    }

    static func fontListF(style: FS) -> [Self] {
        allCases.filter {
            $0.isSupportedF(style: style)
        }
    }

    static func fontF(ofSize fontSize: CGFloat, style: FS) -> UIFont {
        style.loadFont()
        let getFontNames = style.getFontNames()
        return UIFont(name: getFontNames.postScriptName, size: fontSize)!
    }

    private static func stringF(name: Self) -> String {
        let toIndex = name.unicode.index(name.unicode.startIndex, offsetBy: 1)
        return String(name.unicode[name.unicode.startIndex ..< toIndex])
    }

    private static func stringF(code: String) -> String? {
        guard let name = Self(rawValue: code) else {
            return nil
        }

        return self.stringF(name: name)
    }

    static func imageF(name: Self, style: FS, textColor: UIColor, size: CGSize, backgroundColor: UIColor = .clear, borderWidth: CGFloat = 0, borderColor: UIColor = .clear) -> UIImage? {
        guard name.isSupportedF(style: style) else { return nil }
        // Prevent application crash when passing size where width or height is set equal to or less than zero, by clipping width and height to a minimum of 1 pixel.
        var size = size
        if size.width <= 0 { size.width = 1 }
        if size.height <= 0 { size.height = 1 }

        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = NSTextAlignment.center

        let fontSize = min(size.width / FontSetting.shared.fontAspectRatio, size.height)

        // stroke width expects a whole number percentage of the font size
        let strokeWidth: CGFloat = fontSize == 0 ? 0 : (-100 * borderWidth / fontSize)

        let attributedString = NSAttributedString(string: stringF(name: name), attributes: [
            NSAttributedString.Key.font: fontF(ofSize: fontSize, style: style),
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

    static func imageF(code: String, style: FS, textColor: UIColor, size: CGSize, backgroundColor: UIColor = .clear, borderWidth: CGFloat = 0, borderColor: UIColor = .clear) -> UIImage? {
        guard let name = Self(rawValue: code) else { return nil }
        return imageF(name: name, style: style, textColor: textColor, size: size, backgroundColor: backgroundColor, borderWidth: borderWidth, borderColor: borderColor)
    }
}

// MARK: - FontNameMultiple
public protocol FontNameMultiple: FontName {}
public extension FontNameMultiple {
    static func fontList(style: FS) -> [Self] {
        fontListF(style: style)
    }

    static func font(ofSize fontSize: CGFloat, style: FS) -> UIFont {
        Self.fontF(ofSize: fontSize, style: style)
    }

    static func image(name: Self, style: FS, textColor: UIColor, size: CGSize, backgroundColor: UIColor = .clear, borderWidth: CGFloat = 0, borderColor: UIColor = .clear) -> UIImage? {
        Self.imageF(name: name, style: style, textColor: textColor, size: size, borderWidth: borderWidth, borderColor: borderColor)
    }

    static func image(code: String, style: FS, textColor: UIColor, size: CGSize, backgroundColor: UIColor = .clear, borderWidth: CGFloat = 0, borderColor: UIColor = .clear) -> UIImage? {
        Self.imageF(code: code, style: style, textColor: textColor, size: size, borderWidth: borderWidth, borderColor: borderColor)
    }
}

// MARK: - FontNameOnly
public protocol FontNameOnly: FontName {}
public extension FontNameOnly {
    static func fontList() -> [Self] {
        let style = FS.allCases.first!
        return Self.fontListF(style: style)
    }

    static func font(ofSize fontSize: CGFloat) -> UIFont {
        let style = FS.allCases.first!
        return Self.fontF(ofSize: fontSize, style: style)
    }

    static func image(name: Self, textColor: UIColor, size: CGSize, backgroundColor: UIColor = .clear, borderWidth: CGFloat = 0, borderColor: UIColor = .clear) -> UIImage? {
        let style = FS.allCases.first!
        return Self.imageF(name: name, style: style, textColor: textColor, size: size, borderWidth: borderWidth, borderColor: borderColor)
    }

    static func image(code: String, textColor: UIColor, size: CGSize, backgroundColor: UIColor = .clear, borderWidth: CGFloat = 0, borderColor: UIColor = .clear) -> UIImage? {
        let style = FS.allCases.first!
        return Self.imageF(code: code, style: style, textColor: textColor, size: size, borderWidth: borderWidth, borderColor: borderColor)
    }
}

public extension UIImageView {
    func image<FNM: FontNameMultiple>(name: FNM, style: FNM.FS, textColor: UIColor, backgroundColor: UIColor = .clear, borderWidth: CGFloat = 0, borderColor: UIColor = .clear) {
        image = FNM.image(name: name, style: style, textColor: textColor, size: self.size, backgroundColor: backgroundColor, borderWidth: borderWidth, borderColor: borderColor)
    }

    func image<FNO: FontNameOnly>(name: FNO, textColor: UIColor, backgroundColor: UIColor = .clear, borderWidth: CGFloat = 0, borderColor: UIColor = .clear) {
        image = FNO.image(name: name, textColor: textColor, size: self.size, backgroundColor: backgroundColor, borderWidth: borderWidth, borderColor: borderColor)
    }
}
