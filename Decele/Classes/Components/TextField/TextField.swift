//
//  TextField.swift
//  SwiftyComponents
//
//  Created by Mc Kevin on 10/01/23.
//

import UIKit

public class TextField: UITextField {}

public protocol ViewConvertible {}
extension String: ViewConvertible {}
extension UIImage: ViewConvertible {}
extension UIView: ViewConvertible {}

private var __maxLengths = [UITextField: Int]()
public extension UITextField {
    var maxLength: Int {
        get {
            guard let lenght = __maxLengths[self] else {
                return 0
            }
            return lenght
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        }
    }

    @objc private func editingChanged(textField: UITextField) {
        let text = textField.text
        textField.text = text?.prefix(maxLength).description
    }

    func setLeftView(view: ViewConvertible? = nil, padding: CGFloat = 0, margin: CGFloat = 0) {
        let viewPadding = leftView as? ViewPadding ?? ViewPadding()
        let subview = viewPadding.subviews.first
        viewPadding.removeSubviews()
        if let string = view as? String {
            let newView = (subview as? UILabel) ?? UILabel()
            newView.text = string
            viewPadding.addSubview(newView)
        } else if let image = view as? UIImage {
            let newView = (subview as? UIImageView) ?? UIImageView()
            newView.image = image
            viewPadding.addSubview(newView)
        } else {
            let newView = subview ?? UIView()
            viewPadding.addSubview(newView)
        }
        let newView = viewPadding.subviews.first
        newView?.makeConstraintsTopEqualToSuperview()
        newView?.makeConstraintsBottomEqualToSuperview()
        newView?.makeConstraintsLeftEqualToSuperview(constant: margin)
        newView?.makeConstraintsRightEqualToSuperview(constant: -padding)
        leftView = viewPadding
        leftView?.isUserInteractionEnabled = true
        leftViewMode = .always
    }

    func setRightView(view: ViewConvertible? = nil, padding: CGFloat = 0, margin: CGFloat = 0) {
        let viewPadding = rightView as? ViewPadding ?? ViewPadding()
        let subview = viewPadding.subviews.first
        viewPadding.removeSubviews()
        if let string = view as? String {
            let newView = (subview as? UILabel) ?? UILabel()
            newView.text = string
            viewPadding.addSubview(newView)
        } else if let image = view as? UIImage {
            let newView = (subview as? UIImageView) ?? UIImageView()
            newView.image = image
            viewPadding.addSubview(newView)
        } else {
            let newView = subview ?? UIView()
            viewPadding.addSubview(newView)
        }
        let newView = viewPadding.subviews.first
        newView?.makeConstraintsTopEqualToSuperview()
        newView?.makeConstraintsBottomEqualToSuperview()
        newView?.makeConstraintsRightEqualToSuperview(constant: -margin)
        newView?.makeConstraintsLeftEqualToSuperview(constant: padding)
        rightView = viewPadding
        rightView?.isUserInteractionEnabled = true
        rightViewMode = .always
    }
}

private class ViewPadding: UIView {}
