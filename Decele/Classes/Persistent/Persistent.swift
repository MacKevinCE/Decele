//
//  Decele.swift
//  Decele
//
//  Created by Mac Kevin Cabanillas Encarnacion on 7/15/21.
//

import Foundation
import SwiftKeychainWrapper

// MARK: - Persistent
public enum Persistent {
    public static var cryptUserDefaults: Crypt = .init()
    public static var cryptKeychain: Crypt = .init()

    public static var prefix = Bundle.main.bundleIdentifier ?? .empty

    public static func removeAllKeysUserDefaults() {
        for (key, _) in UserDefaults.standard.dictionaryRepresentation() {
            if key.hasPrefix(prefix) {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }

    public static func removeAllKeysKeychainWrapper() {
        for key in KeychainWrapper.standard.allKeys() {
            if key.hasPrefix(prefix) {
                KeychainWrapper.standard.removeObject(forKey: key)
            }
        }
    }

    public static func removeAllKeys() {
        removeAllKeysUserDefaults()
        removeAllKeysKeychainWrapper()
    }

    // MARK: - EncryptMethod
    public struct Crypt {
        public var encrypt: CryptType
        public var decrypt: CryptType

        public init(
            encrypt: @escaping CryptType = { data, _ in data },
            decrypt: @escaping CryptType = { data, _ in data }
        ) {
            self.encrypt = encrypt
            self.decrypt = decrypt
        }
    }
}
