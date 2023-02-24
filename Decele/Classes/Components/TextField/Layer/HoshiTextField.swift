//
//  HoshiTextField.swift
//  Decele
//
//  Created by Mc Kevin on 22/02/23.
//

import Foundation

open class HoshiTextField: TextField {
    // MARK: - public var
    public var borderInactiveColor: UIColor = .black {
        didSet {
            updateBorder()
        }
    }

    public var borderActiveColor: UIColor = .black {
        didSet {
            updateBorder()
        }
    }

    public var placeholderColor: UIColor = .black {
        didSet {
            updatePlaceholder()
        }
    }

    public var placeholderFontScale: CGFloat = 0.65 {
        didSet {
            updatePlaceholder()
        }
    }

    public var borderThickness: (active: CGFloat, inactive: CGFloat) = (active: 2, inactive: 0.5) {
        didSet {
            updateBorder()
        }
    }

    public var placeholderInsets: CGPoint = .init(x: 0, y: 8) {
        didSet {
            layoutPlaceholderInTextRect()
        }
    }

    // MARK: - public let
    public let placeholderLabel = UILabel()
    public let inactiveBorderLayer = CALayer()
    public let activeBorderLayer = CALayer()

    // MARK: - private
    private var activePlaceholderPoint: CGPoint = .zero

    // MARK: - override
    override open func updatePlaceholder() {
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.sizeToFit()
        layoutPlaceholderInTextRect()

        if isFirstResponder || !text!.isEmpty {
            animateViewsForTextEntry()
        }
    }

    override open func drawViewsForRect(_ rect: CGRect) {
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: rect.size.width, height: rect.size.height))

        placeholderLabel.frame = frame.insetBy(dx: placeholderInsets.x, dy: placeholderInsets.y)
        placeholderLabel.font = placeholderFontFromFont(font!)

        updateBorder()
        updatePlaceholder()

        layer.addSublayer(inactiveBorderLayer)
        layer.addSublayer(activeBorderLayer)
        addSubview(placeholderLabel)
    }

    override open func drawPlaceholder(in _: CGRect) {}

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        super.placeholderRect(forBounds: bounds)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds)
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
    }

    override open func animateViewsForTextEntry() {
        if text!.isEmpty {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .beginFromCurrentState, animations: ({
                self.placeholderLabel.frame.origin = CGPoint(x: 10, y: self.placeholderLabel.frame.origin.y)
                self.placeholderLabel.alpha = 0
            }), completion: { isCompletion in
                self.delegateLayout?.textField(self, animationCompletion: .textEntry, isCompletion: isCompletion)
            })
        }

        layoutPlaceholderInTextRect()
        placeholderLabel.frame.origin = activePlaceholderPoint

        UIView.animate(withDuration: 0.4, animations: {
            self.placeholderLabel.alpha = 1.0
        })

        activeBorderLayer.frame = rectForBorder(borderThickness.active, isFilled: true)
    }

    override open func animateViewsForTextDisplay() {
        if let text = text, text.isEmpty {
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .beginFromCurrentState, animations: ({
                self.layoutPlaceholderInTextRect()
                self.placeholderLabel.alpha = 1
            }), completion: { isCompletion in
                self.delegateLayout?.textField(self, animationCompletion: .textDisplay, isCompletion: isCompletion)
            })

            activeBorderLayer.frame = self.rectForBorder(self.borderThickness.active, isFilled: false)
            inactiveBorderLayer.frame = self.rectForBorder(self.borderThickness.inactive, isFilled: true)
        }
    }

    // MARK: - func
    private func updateBorder() {
        clearBorder()
        inactiveBorderLayer.frame = rectForBorder(borderThickness.inactive, isFilled: !isFirstResponder)
        inactiveBorderLayer.backgroundColor = borderInactiveColor.cgColor

        activeBorderLayer.frame = rectForBorder(borderThickness.active, isFilled: isFirstResponder)
        activeBorderLayer.backgroundColor = borderActiveColor.cgColor
    }

    private func layoutPlaceholderInTextRect() {
        let textRect = super.textRect(forBounds: bounds)
        var originX = textRect.origin.x
        switch self.textAlignment {
        case .center:
            originX += textRect.size.width / 2 - placeholderLabel.bounds.width / 2
        case .right:
            originX += textRect.size.width - placeholderLabel.bounds.width
        default:
            break
        }
        placeholderLabel.frame = CGRect(x: originX, y: textRect.height / 2,
                                        width: placeholderLabel.bounds.width, height: placeholderLabel.bounds.height)
        activePlaceholderPoint = CGPoint(x: placeholderLabel.frame.origin.x, y: placeholderLabel.frame.origin.y - placeholderLabel.frame.size.height - placeholderInsets.y)
    }

    private func rectForBorder(_ thickness: CGFloat, isFilled: Bool) -> CGRect {
        if isFilled {
            return CGRect(origin: CGPoint(x: 0, y: frame.height - thickness), size: CGSize(width: frame.width, height: thickness))
        } else {
            return CGRect(origin: CGPoint(x: 0, y: frame.height - thickness), size: CGSize(width: 0, height: thickness))
        }
    }

    private func placeholderFontFromFont(_ font: UIFont) -> UIFont! {
        let smallerFont = UIFont(descriptor: font.fontDescriptor, size: font.pointSize * placeholderFontScale)
        return smallerFont
    }
}
