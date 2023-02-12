//
//  DataExtensions.swift
//  Decele
//
//  Created by Mc Kevin on 27/01/23.
//

import SwifterSwift

public extension Data {
    var prettyPrintedJSONString: String? {
        guard let object = try? jsonObject(),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        else { return nil }

        return prettyPrintedString as String
    }

    func decode<T: Decodable>() -> T? {
        return T(from: self)
    }
}
