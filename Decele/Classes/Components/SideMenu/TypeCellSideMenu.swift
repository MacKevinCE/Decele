//
//  TypeCellSideMenu.swift
//  SwiftyComponents
//
//  Created by Mc Kevin on 9/01/23.
//

import Foundation

public enum TypeCellSideMenu {
    case attributed(numberOfLines: Int = 0, backgroundColor: UIColor = .clear)
    case cell(SideMenuTableViewCell.Type)
}
