//
//  UIViewExtensions.swift
//  Decele
//
//  Created by Mc Kevin on 9/02/23.
//

import UIKit

public extension UIView {
    func getImagenWithText(text: String, weight: UIFont.Weight = .regular, textColor: UIColor = .black, backgroundColor: UIColor = UIColor.clear, borderWidth: CGFloat = 0, borderColor: UIColor = UIColor.clear) -> UIImage {
        let size = bounds.size

        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = NSTextAlignment.center

        let fontSize = min(size.width, size.height)

        // stroke width expects a whole number percentage of the font size
        let strokeWidth: CGFloat = fontSize == 0 ? 0 : (-100 * borderWidth / fontSize)
        let attributedString = NSAttributedString(string: text.description, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: weight),
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.backgroundColor: backgroundColor,
            NSAttributedString.Key.paragraphStyle: paragraph,
            NSAttributedString.Key.strokeWidth: strokeWidth,
            NSAttributedString.Key.strokeColor: borderColor,
        ])

        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let rect = CGRect(x: -8, y: -8, width: 17, height: 17)
        attributedString.draw(in: CGRect(x: 0 + rect.origin.x, y: ((size.height - fontSize) / 2) + rect.origin.y, width: size.width + rect.size.width, height: fontSize + rect.size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
