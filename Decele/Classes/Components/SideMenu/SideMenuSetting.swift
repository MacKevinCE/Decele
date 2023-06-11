//
//  SideMenuSetting.swift
//  Decele
//
//  Created by Mc Kevin on 9/01/23.
//

import SideMenu

public struct SideMenuSetting {
    public static var shared = SideMenuSetting()

    public var backgroundColor: UIColor
    public var backgroundImage: UIImage?
    public var typeCell: TypeCellSideMenu

    public init(backgroundColor: UIColor = .white, backgroundImage: UIImage? = nil, typeCell: TypeCellSideMenu = .attributed()) {
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.typeCell = .attributed()
    }
}
