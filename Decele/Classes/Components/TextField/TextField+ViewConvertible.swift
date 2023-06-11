//
//  TextField+ViewConvertible.swift
//  Decele
//
//  Created by Mc Kevin on 20/02/23.
//

import SnapKit
import UIKit

public extension TextField {
    override var rightView: UIView? {
        get {
            let viewPadding = (super.rightView as? ViewPadding) ?? ViewPadding()
            return viewPadding.subviews.first
        }
        set {
            if let value = newValue {
                setRightView(convertible: value)
            } else {
                super.rightView = nil
            }
        }
    }

    override var leftView: UIView? {
        get {
            let viewPadding = (super.leftView as? ViewPadding) ?? ViewPadding()
            return viewPadding.subviews.first
        }
        set {
            if let value = newValue {
                setLeftView(convertible: value)
            } else {
                super.leftView = nil
            }
        }
    }

    @discardableResult
    func setLeftView(convertible: ViewConvertible? = nil, spaceToText: CGFloat = 0, spaceToView: CGFloat = 0) -> UIView {
        let viewPadding = (super.leftView as? ViewPadding) ?? ViewPadding()
        let subview = viewPadding.subviews.first
        viewPadding.removeSubviews()
        let newView = convertible?.asView(view: subview) ?? UIView()
        viewPadding.addSubview(newView)
        newView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(spaceToView)
            make.right.equalToSuperview().offset(-spaceToText)
        }
        super.leftView = viewPadding
        leftViewMode = .always
        return newView
    }

    @discardableResult
    func setLeftView(numberStates: Int, spaceToText: CGFloat = 0, spaceToView: CGFloat = 0) -> Button {
        setLeftView(convertible: Button(numberStates), spaceToText: spaceToText, spaceToView: spaceToView) as! Button
    }

    @discardableResult
    func setLeftView(_ string: String, spaceToText: CGFloat = 0, spaceToView: CGFloat = 0) -> UILabel {
        setLeftView(convertible: string, spaceToText: spaceToText, spaceToView: spaceToView) as! UILabel
    }

    @discardableResult
    func setLeftView(_ character: Character, spaceToText: CGFloat = 0, spaceToView: CGFloat = 0) -> UILabel {
        setLeftView(convertible: character, spaceToText: spaceToText, spaceToView: spaceToView) as! UILabel
    }

    @discardableResult
    func setLeftView(_ int: Int, spaceToText: CGFloat = 0, spaceToView: CGFloat = 0) -> UILabel {
        setLeftView(convertible: int, spaceToText: spaceToText, spaceToView: spaceToView) as! UILabel
    }

    @discardableResult
    func setLeftView(_ float: Float, spaceToText: CGFloat = 0, spaceToView: CGFloat = 0) -> UILabel {
        setLeftView(convertible: float, spaceToText: spaceToText, spaceToView: spaceToView) as! UILabel
    }

    @discardableResult
    func setLeftView(_ double: Double, spaceToText: CGFloat = 0, spaceToView: CGFloat = 0) -> UILabel {
        setLeftView(convertible: double, spaceToText: spaceToText, spaceToView: spaceToView) as! UILabel
    }

    @discardableResult
    func setLeftView(_ image: UIImage, spaceToText: CGFloat = 0, spaceToView: CGFloat = 0) -> UIImageView {
        setLeftView(convertible: image, spaceToText: spaceToText, spaceToView: spaceToView) as! UIImageView
    }

    @discardableResult
    func setLeftView(_ view: UIView, spaceToText: CGFloat = 0, spaceToView: CGFloat = 0) -> UIView {
        setLeftView(convertible: view, spaceToText: spaceToText, spaceToView: spaceToView)
    }

    @discardableResult
    func setRightView(convertible: ViewConvertible, spaceToText: CGFloat = 0, spaceToView: CGFloat = 0) -> UIView {
        let viewPadding = (super.rightView as? ViewPadding) ?? ViewPadding()
        let subview = viewPadding.subviews.first
        viewPadding.removeSubviews()
        let newView = convertible.asView(view: subview)
        viewPadding.addSubview(newView)
        newView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-spaceToView)
            make.left.equalToSuperview().offset(spaceToText)
        }
        super.rightView = viewPadding
        rightViewMode = .always
        return newView
    }

    @discardableResult
    func setRightView(numberStates: Int, spaceToText: CGFloat = 0, spaceToView: CGFloat = 0) -> Button {
        setRightView(convertible: Button(numberStates), spaceToText: spaceToText, spaceToView: spaceToView) as! Button
    }

    @discardableResult
    func setRightView(_ string: String, spaceToText: CGFloat = 0, spaceToView: CGFloat = 0) -> UILabel {
        setRightView(convertible: string, spaceToText: spaceToText, spaceToView: spaceToView) as! UILabel
    }

    @discardableResult
    func setRightView(_ character: Character, spaceToText: CGFloat = 0, spaceToView: CGFloat = 0) -> UILabel {
        setRightView(convertible: character, spaceToText: spaceToText, spaceToView: spaceToView) as! UILabel
    }

    @discardableResult
    func setRightView(_ int: Int, spaceToText: CGFloat = 0, spaceToView: CGFloat = 0) -> UILabel {
        setRightView(convertible: int, spaceToText: spaceToText, spaceToView: spaceToView) as! UILabel
    }

    @discardableResult
    func setRightView(_ float: Float, spaceToText: CGFloat = 0, spaceToView: CGFloat = 0) -> UILabel {
        setRightView(convertible: float, spaceToText: spaceToText, spaceToView: spaceToView) as! UILabel
    }

    @discardableResult
    func setRightView(_ double: Double, spaceToText: CGFloat = 0, spaceToView: CGFloat = 0) -> UILabel {
        setRightView(convertible: double, spaceToText: spaceToText, spaceToView: spaceToView) as! UILabel
    }

    @discardableResult
    func setRightView(_ image: UIImage, spaceToText: CGFloat = 0, spaceToView: CGFloat = 0) -> UIImageView {
        setRightView(convertible: image, spaceToText: spaceToText, spaceToView: spaceToView) as! UIImageView
    }

    @discardableResult
    func setRightView(_ view: UIView, spaceToText: CGFloat = 0, spaceToView: CGFloat = 0) -> UIView {
        setRightView(convertible: view, spaceToText: spaceToText, spaceToView: spaceToView)
    }
}

// MARK: - ViewPadding
class ViewPadding: UIView {}

// MARK: - ViewConvertible
public protocol ViewConvertible {
    func asView(view: UIView?) -> UIView
}

// MARK: - String + ViewConvertible
extension String: ViewConvertible {
    public func asView(view: UIView?) -> UIView {
        let newView = (view as? UILabel) ?? UILabel()
        newView.text = self
        return newView
    }
}

// MARK: - Character + ViewConvertible
extension Character: ViewConvertible {
    public func asView(view: UIView?) -> UIView {
        let newView = (view as? UILabel) ?? UILabel()
        newView.text = self.string
        return newView
    }
}

// MARK: - Int + ViewConvertible
extension Int: ViewConvertible {
    public func asView(view: UIView?) -> UIView {
        let newView = (view as? UILabel) ?? UILabel()
        newView.text = self.string
        return newView
    }
}

// MARK: - Float + ViewConvertible
extension Float: ViewConvertible {
    public func asView(view: UIView?) -> UIView {
        let newView = (view as? UILabel) ?? UILabel()
        newView.text = self.string
        return newView
    }
}

// MARK: - Double + ViewConvertible
extension Double: ViewConvertible {
    public func asView(view: UIView?) -> UIView {
        let newView = (view as? UILabel) ?? UILabel()
        newView.text = self.string
        return newView
    }
}

// MARK: - UIImage + ViewConvertible
extension UIImage: ViewConvertible {
    public func asView(view: UIView?) -> UIView {
        let newView = (view as? UIImageView) ?? UIImageView()
        newView.image = self
        return newView
    }
}

// MARK: - UIView + ViewConvertible
extension UIView: ViewConvertible {
    public func asView(view _: UIView?) -> UIView {
        self
    }
}
