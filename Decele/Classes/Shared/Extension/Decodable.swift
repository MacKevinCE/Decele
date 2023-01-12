//
//  Decodable.swift
//  Decele
//
//  Created by Mc Kevin on 10/01/23.
//

import Foundation

extension Decodable {
    init?(from data: Data, using decoder: JSONDecoder = .init()) {
        guard let parsed = try? decoder.decode(Self.self, from: data) else { return nil }
        self = parsed
    }
}

