//
//  FloatingPanel.swift
//  Decele
//
//  Created by Mc Kevin on 7/01/23.
//

import FloatingPanel

public final class FloatingPanel: FloatingPanelController {
    public convenience init(with content: NibView) {
        self.init(with: content, config: ConfigFloatingPanel(absoluteInset: content.view.frame.height))
    }

    public convenience init(with content: UIViewController) {
        self.init(with: content.view, config: ConfigFloatingPanel(absoluteInset: content.view.frame.height))
    }

    public convenience init(with content: UIView, config: ConfigFloatingPanel = .shared) {
        let view = FloatingPanelViewController()
        view.view = content
        view.config = config
        self.init(delegate: config.delegate ?? view)

        let appearance = SurfaceAppearance()
        appearance.cornerRadius = config.cornerRadius
        appearance.backgroundColor = config.backgroundColor
        backdropView.dismissalTapGestureRecognizer.isEnabled = config.dismissalTapIsEnabled
        surfaceView.appearance = appearance
        surfaceView.grabberHandle.barColor = config.grabberHandleBarColor
        surfaceView.grabberHandle.isHidden = config.grabberHandleIsHidden
        set(contentViewController: view)
    }
}

public extension NibView {
    func buildFloating() -> FloatingPanel {
        return FloatingPanel(with: self)
    }
}
