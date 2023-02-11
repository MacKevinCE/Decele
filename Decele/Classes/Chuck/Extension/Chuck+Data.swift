//
//  Decele+Data.swift
//  Decele
//
//  Created by Mc Kevin on 9/07/22.
//

extension Data {
    var prettyPrintedJSONString: String? {
        guard let object = try? jsonObject(),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        else { return nil }

        return prettyPrintedString as String
    }
}
