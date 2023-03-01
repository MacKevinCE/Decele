//
//  TypeKey.swift
//  Decele
//
//  Created by Mc Kevin on 31/12/22.
//

import Foundation
import SwiftKeychainWrapper

public extension Persistent {
    typealias Typecrypt = (Data, String) -> Data?

    enum TypeKey {
        case userDefaults(key: String, encrypt: Typecrypt = Persistent.encryptMethodUserDefaults.encrypt, decrypt: Typecrypt = Persistent.encryptMethodUserDefaults.decrypt)
        case keychain(key: String, encrypt: Typecrypt = Persistent.encryptMethodKeychain.encrypt, decrypt: Typecrypt = Persistent.encryptMethodKeychain.decrypt)

        func getKey() -> String {
            switch self {
            case let .userDefaults(key, _, _), let .keychain(key, _, _):
                return key
            }
        }

        func setData(_ data: Data) {
            _save_key_user_Defauts(self)
            switch self {
            case let .userDefaults(key, encrypt, _):
                guard let sealedBox: Data = encrypt(data, key) else { return }
                UserDefaults.standard.set(sealedBox, forKey: key)
            case let .keychain(key, encrypt, _):
                guard let sealedBox: Data = encrypt(data, key) else { return }
                KeychainWrapper.standard.set(sealedBox, forKey: key)
            }
        }

        func getData() -> Data? {
            switch self {
            case let .userDefaults(key, _, decrypt):
                guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
                return decrypt(data, key)
            case let .keychain(key, _, decrypt):
                guard let data = KeychainWrapper.standard.data(forKey: key) else { return nil }
                return decrypt(data, key)
            }
        }

        func removeObject() {
            _remove_key_user_Defauts(self)
            switch self {
            case let .userDefaults(key, _, _):
                UserDefaults.standard.removeObject(forKey: key)
            case let .keychain(key, _, _):
                KeychainWrapper.standard.removeObject(forKey: key)
            }
        }
    }
}
