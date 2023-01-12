//
//  NSMutableAttributedString.swift
//  Alamofire
//
//  Created by Mc Kevin on 11/01/23.
//

import Foundation

extension NSMutableAttributedString {
    func printParStringForChuck(_ par: (key: String, value: String)) -> NSMutableAttributedString {
        addTextWithAttributeText(text: "[\(par.key)]: ", font: .semibold14)
            .addTextWithAttributeText(text: "\(par.value)", font: .regular14)
    }

    func printEnter() -> NSMutableAttributedString {
        addTextWithAttributeText(text: .enter)
    }

    func printSpacer() -> NSMutableAttributedString {
        addTextWithAttributeText(text: .space)
    }

    func printTab() -> NSMutableAttributedString {
        addTextWithAttributeText(text: .tab)
    }

    func printJSONForChuck(_ json: String) -> NSMutableAttributedString {
        let attributedString = json.initAttributeText(font: .regular14)
            .addAttributeText(textFind: "=", font: .semibold14)
            .addAttributeText(textFind: ":", font: .semibold14)
            .addAttributeText(textFind: ",", font: .semibold14)
            .addAttributeText(textFind: "{", font: .semibold14)
            .addAttributeText(textFind: "}", font: .semibold14)
            .addAttributeText(textFind: "[", font: .semibold14)
            .addAttributeText(textFind: "]", font: .semibold14)
            .addAttributeText(textFind: "\"", font: .semibold14)
        append(attributedString)
        return self
    }

    func printTitleChuck(_ text: String, color: UIColor = .systemBlue) -> NSMutableAttributedString {
        addTextWithAttributeText(text: text, color: color, font: .semibold14, isUnderline: true)
    }
}
