//
//  TextField.swift
//  Alamofire
//
//  Created by Mc Kevin on 16/02/23.
//

import UIKit

// MARK: - TextField
open class TextField: UITextField {
    // MARK: delegate
    public var delegateTextField: TextFieldDelegate?
    public var delegateLayout: TextFieldDelegateLayout?

    // MARK: functions
    @objc private func editingChanged(textField: UITextField) {
        var text = textField.text ?? ""
        text = formatterReturn(text: text)
        text = maxLengthReturn(text: text)
        ascendingCounterReturn(text: text)
        validatorReturn(text: text)
        textField.text = text
    }

    // MARK: maxLength
    private var _maxLength: Int?
    public var maxLength: Int? {
        get { return _maxLength }
        set {
            if let length = newValue {
                let newLength = max(0, length)
                _maxLength = newLength
            } else {
                _maxLength = newValue
            }
        }
    }

    private func maxLengthReturn(text: String) -> String {
        if let maxLength = maxLength {
            let newText = Formatter.maxLength(max: maxLength).format(text: text)
            if text != newText {
                delegateTextField?.textField?(self, didReach: maxLength, text: text, outputText: newText)
            }
            return newText
        }
        return text
    }

    // MARK: ascendingCounter
    private var _ascendingCounter: Bool?
    public var ascendingCounter: Bool? {
        get { return _ascendingCounter }
        set {
            if let ascending = newValue {
                _ascendingCounter = ascending
                let counterText = getCount(text: text ?? "", ascending: ascending)
                let label = setRightView(counterText, spaceToView: 10)
                delegateTextField?.textField?(self, counter: label, counterText: counterText, ascending: ascending)
                if allTargets.isEmpty {
                    addTarget(self, action: #selector(editingChanged), for: .editingChanged)
                }
            } else {
                _ascendingCounter = newValue
                rightView = nil
            }
        }
    }

    private func getCount(text: String, ascending: Bool) -> String {
        let lenght = maxLength ?? 0
        let number = ascending ? text.count : lenght - text.count
        return String.localizedStringWithFormat("%i", number)
    }

    private func ascendingCounterReturn(text: String) {
        if let ascending = ascendingCounter {
            let counterText = getCount(text: text, ascending: ascending)
            let label = setRightView(counterText, spaceToView: 10)
            delegateTextField?.textField?(self, counter: label, counterText: counterText, ascending: ascending)
        }
    }

    // MARK: formatter
    private var _formatter: Formatter?
    public var formatter: Formatter? {
        get { return _formatter }
        set {
            if let value = newValue {
                _formatter = value
                if allTargets.isEmpty {
                    addTarget(self, action: #selector(editingChanged), for: .editingChanged)
                }
            } else {
                _formatter = newValue
            }
        }
    }

    private func formatterReturn(text: String) -> String {
        if let formatter = formatter {
            let newText = formatter.format(text: text)
            delegateTextField?.textField?(self, didFormat: text, outputText: newText)
            return newText
        }
        return text
    }

    // MARK: validator
    private var _validator: Validator?
    public var validator: Validator? {
        get { return _validator }
        set {
            if let value = newValue {
                _validator = value
                if allTargets.isEmpty {
                    addTarget(self, action: #selector(editingChanged), for: .editingChanged)
                }
            } else {
                _validator = newValue
            }
        }
    }

    private func validatorReturn(text: String) {
        if let validator = validator {
            let failText = validator.validate(text)
            let isValid = (failText == nil)
            delegateTextField?.textField?(self, didValidate: text, isValid: isValid, failText: failText)
        }
    }

    public var fail: String? {
        return validator?.validate(text ?? "")
    }

    // MARK: effects
    public enum AnimationType: Int {
        case textEntry
        case textDisplay
    }

    // MARK: updatePlaceholder
    open func updatePlaceholder() {}

    override open var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }

    open func placeholderFont(fontScale: CGFloat) -> UIFont? {
        guard let font = self.font else { return nil }
        return UIFont(descriptor: font.fontDescriptor, size: font.pointSize * fontScale)
    }

    // MARK: drawViewsForRect
    open func drawViewsForRect(_ rect: CGRect) {
        super.draw(rect)
    }

    open func clearBorder() {
        self.borderStyle = .bezel
        self.layer.borderColor = .none
    }

    override public func draw(_ rect: CGRect) {
        guard self.isFirstResponder == false else { return }
        drawViewsForRect(rect)
    }

    // MARK: drawPlaceholder
    override open func drawPlaceholder(in rect: CGRect) {
        super.drawPlaceholder(in: rect)
    }

    // MARK: placeholderRect
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        super.placeholderRect(forBounds: bounds)
    }

    // MARK: editingRect
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds)
    }

    // MARK: textRect
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
    }

    // MARK: animateViewsForTextEntry and  animateViewsForTextDisplay
    open func animateViewsForTextEntry() {
        delegateLayout?.textField(self, animationCompletion: .textEntry, isCompletion: true)
    }

    open func animateViewsForTextDisplay() {
        delegateLayout?.textField(self, animationCompletion: .textDisplay, isCompletion: true)
    }

    override open var text: String? {
        didSet {
            if let text = text, !text.isEmpty || self.isFirstResponder {
                textFieldDidBeginEditing()
            } else {
                textFieldDidEndEditing()
            }
        }
    }

    // MARK: UITextField Observing

    override open func willMove(toSuperview newSuperview: UIView!) {
        if newSuperview != nil {
            self.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
            self.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        } else {
            self.removeTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
            self.removeTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        }
    }

    @objc private func textFieldDidBeginEditing() {
        animateViewsForTextEntry()
    }

    @objc private func textFieldDidEndEditing() {
        animateViewsForTextDisplay()
    }
}
