//
//  Bundle.swift
//  Decele
//
//  Created by Mc Kevin on 7/11/22.
//

public extension Bundle {
    class func myResourceBundle(for aClass: AnyClass) -> Bundle? {
        let resourceURL = Bundle(for: aClass).resourcePath ?? .empty
        let name = String(describing: aClass)
        let path = "\(resourceURL)/\(name).bundle"
        return Bundle(path: path)
    }
}
