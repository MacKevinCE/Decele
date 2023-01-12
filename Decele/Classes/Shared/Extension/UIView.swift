//
//  UIView.swift
//  Chuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

extension UIView {
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }

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
            NSAttributedString.Key.strokeColor: borderColor
        ])

        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let rect = CGRect(x: -8, y: -8, width: 17, height: 17)
        attributedString.draw(in: CGRect(x: 0 + rect.origin.x, y: ((size.height - fontSize) / 2) + rect.origin.y, width: size.width + rect.size.width, height: fontSize + rect.size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    enum AngleUnit {
        case degrees
        case radians
    }

    func rotate(byAngle angle: CGFloat, ofType type: AngleUnit, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        let angleWithType = (type == .degrees) ? .pi * angle / 180.0 : angle
        let aDuration = animated ? duration : 0
        UIView.animate(withDuration: aDuration, delay: 0, options: .curveLinear, animations: { () in
            self.transform = self.transform.rotated(by: angleWithType)
        }, completion: completion)
    }

    var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    func removeSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }

    func makeConstraintsEdgesToSuperview(constant: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: superview.topAnchor, constant: constant),
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: constant),
                leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant),
                rightAnchor.constraint(equalTo: superview.rightAnchor, constant: constant)
            ])
        }
    }

    func makeConstraintsEdgesTo(view: UIView, constant: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: constant)
        ])
    }

    func makeConstraintsCenterXEqualToSuperview(constant: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            NSLayoutConstraint.activate([
                centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: constant)
            ])
        }
    }

    func makeConstraintsCenterYEqualToSuperview(constant: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            NSLayoutConstraint.activate([
                centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: constant)
            ])
        }
    }

    func makeConstraintsWidthEqualTo(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: constant)
        ])
    }

    func makeConstraintsWidthEqualTo(widthView view: UIView, multiplier: CGFloat, constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier, constant: constant)
        ])
    }

    func makeConstraintsHeightEqualTo(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: constant)
        ])
    }

    func makeConstraintsHeightEqualTo(heightView view: UIView, multiplier: CGFloat, constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier, constant: constant)
        ])
    }

    func makeConstraintsTopEqualToSuperview(constant: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: superview.topAnchor, constant: constant)
            ])
        }
    }

    func makeConstraintsTopEqualToSafeArea(constant: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview?.layoutMarginsGuide {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: superview.topAnchor, constant: constant)
            ])
        }
    }

    func makeConstraintsTopEqualTo(topAnchorOfView view: UIView, constant: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
        ])
    }

    func makeConstraintsTopEqualTo(bottomAnchorOfView view: UIView, constant: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
        ])
    }

    func makeConstraintsBottomEqualToSuperview(constant: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            NSLayoutConstraint.activate([
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: constant)
            ])
        }
    }

    func makeConstraintsBottomEqualToSafeArea(constant: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview?.layoutMarginsGuide {
            NSLayoutConstraint.activate([
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: constant)
            ])
        }
    }

    func makeConstraintsBottomEqualTo(bottomAnchorOfView view: UIView, constant: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
        ])
    }

    func makeConstraintsBottomEqualTo(topAnchorOfView view: UIView, constant: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: view.topAnchor, constant: constant)
        ])
    }

    func makeConstraintsLeftEqualToSuperview(constant: CGFloat = .zero) {
        if let superview = superview {
            NSLayoutConstraint.activate([
                leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant)
            ])
        }
    }

    func makeConstraintsLeftEqualToSafeArea(constant: CGFloat = .zero) {
        if let superview = superview?.layoutMarginsGuide {
            NSLayoutConstraint.activate([
                leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant)
            ])
        }
    }

    func makeConstraintsLeftEqualTo(leftAnchorOfView view: UIView, constant: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant)
        ])
    }

    func makeConstraintsLeftEqualTo(rightAnchorOfView view: UIView, constant: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: view.rightAnchor, constant: constant)
        ])
    }

    func makeConstraintsRightEqualToSuperview(constant: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            NSLayoutConstraint.activate([
                rightAnchor.constraint(equalTo: superview.rightAnchor, constant: constant)
            ])
        }
    }

    func makeConstraintsRightEqualToSafeArea(constant: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview?.layoutMarginsGuide {
            NSLayoutConstraint.activate([
                rightAnchor.constraint(equalTo: superview.rightAnchor, constant: constant)
            ])
        }
    }

    func makeConstraintsRightEqualTo(leftAnchorOfView view: UIView, constant: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightAnchor.constraint(equalTo: view.leftAnchor, constant: constant)
        ])
    }

    func makeConstraintsRightEqualTo(rightAnchorOfView view: UIView, constant: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: constant)
        ])
    }
}
