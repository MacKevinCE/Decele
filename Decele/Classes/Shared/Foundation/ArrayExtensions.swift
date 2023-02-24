//
//  ArrayExtensions.swift
//  Decele
//
//  Created by Mc Kevin on 27/01/23.
//

public extension Array {
    func firstType<T>() -> T? {
        first(where: { ($0 as? T) != nil }) as? T
    }
}
