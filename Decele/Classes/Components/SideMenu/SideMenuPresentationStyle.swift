//
//  SideMenuPresentationStyle.swift
//  SwiftyComponents
//
//  Created by Mc Kevin on 9/01/23.
//

import SideMenu

public extension SideMenuPresentationStyle {
    static var ssss: SideMenuPresentationStyle {
        let style: SideMenuPresentationStyle = .menuSlideIn
        style.presentingEndAlpha = 0.5
        style.onTopShadowOpacity = 0.5
        style.presentingTranslateFactor = 0.5
        style.presentingScaleFactor = 0.9
        return style
    }
}
