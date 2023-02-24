//
//  TextField+Delegate.swift
//  Decele
//
//  Created by Mc Kevin on 22/02/23.
//

// MARK: - TextFieldDelegate
@objc public protocol TextFieldDelegate {
    @objc optional func textField(_ textField: TextField, didReach maxLength: Int, text: String, outputText: String)
    @objc optional func textField(_ textField: TextField, didValidate text: String, isValid: Bool, failText: String?)
    @objc optional func textField(_ textField: TextField, didFormat text: String, outputText: String)
    @objc optional func textField(_ textField: TextField, counter rightView: UILabel, counterText: String, ascending: Bool)
}

// MARK: - TextFieldDelegateLayout
public protocol TextFieldDelegateLayout {
    func textField(_ textField: TextField, animationCompletion handler: TextField.AnimationType, isCompletion: Bool)
}
