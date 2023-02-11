//
//  Decele+NSMutableAttributedString.swift
//  Decele
//
//  Created by Mc Kevin on 11/01/23.
//

import Foundation

extension NSMutableAttributedString {
    func printParStringForChuck(_ par: (key: String, value: String)) -> NSMutableAttributedString {
        addTextApplying(text: "[\(par.key)]: ", font: .semibold14)
            .addTextApplying(text: "\(par.value)", font: .regular14)
    }

    func printEnter() -> NSMutableAttributedString {
        addTextApplying(text: .enter)
    }

    func printSpacer() -> NSMutableAttributedString {
        addTextApplying(text: .space)
    }

    func printTab() -> NSMutableAttributedString {
        addTextApplying(text: .tab)
    }

    func printJSONForChuck(_ json: String) -> NSMutableAttributedString {
        let attributedString = json.applying(font: .regular14)
            .applying(textFind: "=", font: .semibold14)
            .applying(textFind: ":", font: .semibold14)
            .applying(textFind: ",", font: .semibold14)
            .applying(textFind: "{", font: .semibold14)
            .applying(textFind: "}", font: .semibold14)
            .applying(textFind: "[", font: .semibold14)
            .applying(textFind: "]", font: .semibold14)
            .applying(textFind: "\"", font: .semibold14)
        append(attributedString)
        return self
    }

    func printTitleChuck(_ text: String, color: UIColor = .systemBlue) -> NSMutableAttributedString {
        addTextApplying(text: text, font: .semibold14, color: color, isUnderline: true)
    }
}
