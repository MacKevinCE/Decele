//
//  DataExtensions.swift
//  Decele
//
//  Created by Mc Kevin on 27/01/23.
//

import SwifterSwift

public extension Data {
    func decode<T: Decodable>() -> T? {
        return T(from: self)
    }
}
