//
//  PreviewInfo.swift
//  Decele
//
//  Created by Mc Kevin on 8/11/22.
//

import Foundation

public enum PreviewInfo {
    case attributed(NSMutableAttributedString, numberOfLines: Int = 4)
    case cell(PreviewTableViewCell.Type, searchText: String)

    var getSearchText: String {
        switch self {
        case let .attributed(attributedString, _):
            return attributedString.string
        case let .cell(_, searchText):
            return searchText
        }
    }
}
