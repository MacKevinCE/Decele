//
//  DeceleDebugView.swift
//  Decele
//
//  Created by Mc Kevin on 7/11/22.
//

import SnapKit
import UIKit

class ChuckDebugView: UIView {
    private var backgroundButton: UIButton!
    private var closeButton: UIButton!

    private let closeImage: UIImage? = .close
    private let radius: CGFloat = 75
    private let radiusClose: CGFloat = 25

    private var owner: UIViewController?
    private var centerXConstraint: NSLayoutConstraint?
    private var centerYConstraint: NSLayoutConstraint?

    private var originDrag: CGPoint = .zero

    public init() {
        super.init(frame: .zero)
        viewDidLoad()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewDidLoad()
    }

    private func setupBackgroundButton() {
        let button = UIButton(frame: .init(origin: .zero, size: CGSize(width: radius, height: radius)))
        button.layer.cornerRadius = radius / 2

        button.addTarget(self, action: #selector(backgroundButtonTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(backgroundButtonTouchUpInside), for: .touchUpInside)
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(buttonDrag(pan:)))
        button.addGestureRecognizer(gesture)

        switch Chuck.iconCircle {
        case let .character(character, backgroundImage):
            if character.isASCII {
                button.setImageForAllStates(button.getImagenWithText(text: character.description))
                button.setBackgroundImageForAllStates(backgroundImage ?? button.getImagenWithText(text: "🟡"))
            } else {
                button.setImageForAllStates(button.getImagenWithText(text: character.description))
                button.setBackgroundImageForAllStates(backgroundImage)
            }
        case let .icon(image):
            button.setBackgroundImageForAllStates(image)
        }

        addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        backgroundButton = button
    }

    private func setupCloseButton() {
        let button = UIButton(frame: .init(origin: .zero, size: CGSize(width: radiusClose, height: radiusClose)))
        button.setBackgroundImageForAllStates(closeImage)
        button.layer.cornerRadius = radiusClose / 2

        button.addTarget(self, action: #selector(closeButtonTouchUpInside), for: .touchUpInside)

        addSubview(button)
        button.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.width.height.equalTo(25)
        }
        closeButton = button
    }

    private func viewDidLoad() {
        setupBackgroundButton()
        setupCloseButton()
        afterOpacity()
    }

    override func hitTest(_ point: CGPoint, with _: UIEvent?) -> UIView? {
        let closePF = closeButton.frame
        let backgroundPF = backgroundButton.frame

        if closePF.contains(point) {
            return closeButton
        } else if backgroundPF.contains(point) {
            return backgroundButton
        }
        return nil
    }

    func addPopUp(owner: UIViewController) {
        self.owner = owner
        owner.view.addSubview(self)
        alpha = 0.95
        translatesAutoresizingMaskIntoConstraints = false

        centerXConstraint = centerXAnchor.constraint(equalTo: owner.view.centerXAnchor)
        centerYConstraint = centerYAnchor.constraint(equalTo: owner.view.centerYAnchor)

        centerXConstraint?.isActive = true
        centerYConstraint?.isActive = true

        let origin: CGPoint
        if Chuck.location == .zero {
            let widthMax = (owner.view.frame.width - radius) / 2
            origin = CGPoint(x: -widthMax, y: 0)
        } else {
            origin = Chuck.location
        }

        newLocation(origin)

        snp.makeConstraints { make in
            make.width.height.equalTo(radius)
        }
        owner.view.layoutIfNeeded()
    }

    private func newPoint(_ originDrag: CGPoint, _ finalDrag: CGPoint, _ actualLocation: CGPoint) -> CGPoint {
        let pointX = actualLocation.x + (finalDrag.x - originDrag.x)
        let pointY = actualLocation.y + (finalDrag.y - originDrag.y)
        return CGPoint(x: pointX, y: pointY)
    }

    private func newLocation(_ point: CGPoint) {
        Chuck.location = point
        centerXConstraint?.constant = point.x
        centerYConstraint?.constant = point.y
    }

    private func currentLocation() -> CGPoint {
        let pointX = centerXConstraint?.constant ?? .zero
        let pointY = centerYConstraint?.constant ?? .zero
        return CGPoint(x: pointX, y: pointY)
    }

    private func animationView() {
        guard let owner = owner else { return }

        let current = currentLocation()

        let widthMax = (owner.view.frame.width - radius) / 2
        let widthUltimo = widthMax * ((current.x > 0) ? 1 : -1)

        let heightMax = (owner.view.frame.height / 2) - radius
        let heightUltimo = max(-heightMax, min(current.y, heightMax))

        let pointFinal = CGPoint(x: widthUltimo, y: heightUltimo)

        owner.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
            self?.newLocation(pointFinal)
            owner.view.layoutIfNeeded()
        }, completion: { [weak self] _ in
            self?.afterOpacity()
        })
    }

    private func afterOpacity(delay: TimeInterval = 4, opacity: Float = 0.25) {
        UIView.animate(withDuration: delay, delay: delay, animations: { [weak self] in
            self?.layer.opacity = opacity
        }, completion: { _ in
        })
    }

    @objc private func buttonDrag(pan: UIPanGestureRecognizer) {
        if pan.state == .began {
            originDrag = pan.location(in: backgroundButton)
        } else if pan.state == .ended {
            animationView()
        } else {
            let finalDrag = pan.location(in: backgroundButton)
            newLocation(newPoint(originDrag, finalDrag, currentLocation()))
        }
    }

    @objc private func backgroundButtonTouchDown(_: Any) {
        layer.opacity = 1
    }

    @objc private func backgroundButtonTouchUpInside(_: Any) {
        Chuck.openChuckDebug()
        afterOpacity()
    }

    @objc private func closeButtonTouchUpInside(_: Any) {
        removeFromSuperview()
    }
}
