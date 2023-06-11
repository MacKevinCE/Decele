//
//  TypeKey.swift
//  Decele
//
//  Created by Mc Kevin on 31/12/22.
//

import Foundation
import SwiftKeychainWrapper

public extension Persistent {
    typealias CryptType = (Data, String) -> Data?

    enum TypeKey {
        case userDefaults(key: String, encrypt: CryptType = Persistent.cryptUserDefaults.encrypt, decrypt: CryptType = Persistent.cryptUserDefaults.decrypt)
        case keychain(key: String, encrypt: CryptType = Persistent.cryptKeychain.encrypt, decrypt: CryptType = Persistent.cryptKeychain.decrypt)

        func forKey() -> String {
            switch self {
            case let .userDefaults(key, _, _), let .keychain(key, _, _):
                return "\(Persistent.prefix).\(key)"
            }
        }

        func setData(_ data: Data) {
            switch self {
            case let .userDefaults(key, encrypt, _):
                guard let sealedBox: Data = encrypt(data, key) else { return }
                UserDefaults.standard.set(sealedBox, forKey: forKey())
            case let .keychain(key, encrypt, _):
                guard let sealedBox: Data = encrypt(data, key) else { return }
                KeychainWrapper.standard.set(sealedBox, forKey: forKey())
            }
        }

        func getData() -> Data? {
            switch self {
            case let .userDefaults(key, _, decrypt):
                guard let data = UserDefaults.standard.data(forKey: forKey()) else { return nil }
                return decrypt(data, key)
            case let .keychain(key, _, decrypt):
                guard let data = KeychainWrapper.standard.data(forKey: forKey()) else { return nil }
                return decrypt(data, key)
            }
        }

        func removeObject() {
            switch self {
            case .userDefaults:
                UserDefaults.standard.removeObject(forKey: forKey())
            case .keychain:
                KeychainWrapper.standard.removeObject(forKey: forKey())
            }
        }
    }
}
