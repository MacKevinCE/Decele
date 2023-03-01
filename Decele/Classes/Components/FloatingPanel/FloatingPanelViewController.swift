//
//  FloatingPanelViewController.swift
//  Decele
//
//  Created by Mac Kevin Cabanillas Encarnacion on 7/26/21.
//

import FloatingPanel
import UIKit

// MARK: - FloatingPanelViewController
class FloatingPanelViewController: UIViewController {
    // MARK: - VARIABLES

    var config: ConfigFloatingPanel!

    // MARK: - METHODS

    private func updateCornerRadius(_ fpc: FloatingPanelController) {
        let appearance = fpc.surfaceView.appearance
        let corner: Bool
        let currentHeight = fpc.surfaceLocation.y
        let currentWidth = fpc.surfaceLocation.x

        let mainHeight = UIScreen.main.bounds.height
        let mainWidth = UIScreen.main.bounds.width

        switch position {
        case .top:
            corner = currentHeight < mainHeight - 1
        case .bottom:
            corner = currentHeight > 1
        case .left:
            corner = currentWidth < mainWidth - 1
        case .right:
            corner = currentWidth > 1
        }

        appearance.cornerRadius = corner ? config.cornerRadius : 0
        fpc.surfaceView.appearance = appearance
    }

    private func updateSurfaceLocation(_ fpc: FloatingPanelController) {
        let pointHidden = fpc.surfaceLocation(for: .hidden)
        let pointTip = fpc.surfaceLocation(for: .tip)
        let pointHalf = fpc.surfaceLocation(for: .half)
        let pointFull = fpc.surfaceLocation(for: .full)
        let currentPoint = fpc.surfaceLocation

        switch position {
        case .top:
            let newcurrentHeight = min(fpc.surfaceLocation.y, max(pointHidden.y, pointTip.y, pointHalf.y, pointFull.y))
            fpc.surfaceLocation = CGPoint(x: currentPoint.x, y: newcurrentHeight)
        case .bottom:
            let newcurrentHeight = max(fpc.surfaceLocation.y, min(pointHidden.y, pointTip.y, pointHalf.y, pointFull.y))
            fpc.surfaceLocation = CGPoint(x: currentPoint.x, y: newcurrentHeight)
        case .left:
            let newcurrentWidth = min(fpc.surfaceLocation.x, max(pointHidden.x, pointTip.x, pointHalf.x, pointFull.x))
            fpc.surfaceLocation = CGPoint(x: newcurrentWidth, y: currentPoint.y)
        case .right:
            let newcurrentWidth = max(fpc.surfaceLocation.x, min(pointHidden.x, pointTip.x, pointHalf.x, pointFull.x))
            fpc.surfaceLocation = CGPoint(x: newcurrentWidth, y: currentPoint.y)
        }
    }
}

// MARK: FloatingPanelLayout
extension FloatingPanelViewController: FloatingPanelLayout {
    var position: FloatingPanelPosition { config.position }

    var initialState: FloatingPanelState { config.initialState }

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        config.anchors
    }

    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        0.5
    }
}

// MARK: FloatingPanelControllerDelegate
extension FloatingPanelViewController: FloatingPanelControllerDelegate {
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        self
    }

    func floatingPanelDidMove(_ fpc: FloatingPanelController) {
        updateCornerRadius(fpc)
        updateSurfaceLocation(fpc)
    }

    func floatingPanelDidRemove(_ fpc: FloatingPanelController) {
        fpc.dismiss(animated: true) { [weak self] in
            self?.config.removeCompletion(fpc)
        }
    }

    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        config.changeState(fpc)
        if fpc.state == .hidden, !fpc.isBeingDismissed {
            if fpc.presentingViewController != nil, fpc.parent == nil {
                fpc.delegate?.floatingPanelWillRemove?(fpc)
                fpc.dismiss(animated: true) { [weak fpc] in
                    guard let fpc = fpc else { return }
                    fpc.delegate?.floatingPanelDidRemove?(fpc)
                }
            } else {
                fpc.removePanelFromParent(animated: true)
            }
        }
    }
}
