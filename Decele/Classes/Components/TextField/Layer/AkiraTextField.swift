//
//  AkiraTextField.swift
//  Decele
//
//  Created by Mc Kevin on 22/02/23.
//

import Foundation

open class AkiraTextField: TextField {
    // MARK: - public var
    var borderTextFieldColor: UIColor = .black {
        didSet {
            updateBorder()
        }
    }

    var placeholderInsetsY: CGFloat = 0 {
        didSet {
            updateBorder()
        }
    }

    var placeholderColor: UIColor = .black {
        didSet {
            updatePlaceholder()
        }
    }

    var placeholderFontScale: CGFloat = 0.7 {
        didSet {
            updatePlaceholder()
        }
    }

    var borderSize: (active: CGFloat, inactive: CGFloat) = (1, 2) {
        didSet {
            updateBorder()
        }
    }

    // MARK: - public let
    public let placeholderLabel = UILabel()
    public let borderLayer = CALayer()

    // MARK: - override
    override open func updatePlaceholder() {
        placeholderLabel.frame = placeholderRect(forBounds: bounds)
        placeholderLabel.attributedText = attributedPlaceholder
        placeholderLabel.text = placeholder
        placeholderLabel.font = placeholderFont(fontScale: placeholderFontScale)
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.textAlignment = textAlignment
    }

    override open func drawViewsForRect(_: CGRect) {
        updateBorder()
        updatePlaceholder()

        addSubview(placeholderLabel)
        layer.addSublayer(borderLayer)
    }

    override open func drawPlaceholder(in _: CGRect) {}

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if isFirstResponder || !text.isNilOrEmpty {
            return CGRect(x: textRect(forBounds: bounds).origin.x, y: placeholderInsetsY, width: bounds.width, height: placeholderHeight)
        } else {
            return textRect(forBounds: bounds)
        }
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds)
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
    }

    override open func animateViewsForTextEntry() {
        UIView.animate(withDuration: 0.3, animations: {
            self.updateBorder()
            self.updatePlaceholder()
        }, completion: { isCompletion in
            self.delegateLayout?.textField(self, animationCompletion: .textEntry, isCompletion: isCompletion)
        })
    }

    override open func animateViewsForTextDisplay() {
        UIView.animate(withDuration: 0.3, animations: {
            self.updateBorder()
            self.updatePlaceholder()
        }, completion: { isCompletion in
            self.delegateLayout?.textField(self, animationCompletion: .textDisplay, isCompletion: isCompletion)
        })
    }

    // MARK: - func
    private func updateBorder() {
        clearBorder()
        borderLayer.frame = bounds
        borderLayer.borderWidth = (isFirstResponder || !text!.isEmpty) ? borderSize.active : borderSize.inactive
        borderLayer.borderColor = borderTextFieldColor.cgColor
    }

    private var placeholderHeight: CGFloat {
        placeholderInsetsY + (placeholderFont(fontScale: placeholderFontScale)?.lineHeight ?? .zero)
    }
}
