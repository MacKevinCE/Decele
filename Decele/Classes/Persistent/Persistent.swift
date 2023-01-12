//
//  Persistent.swift
//  InglesYa
//
//  Created by Mac Kevin Cabanillas Encarnacion on 7/15/21.
//

import Foundation
import SwiftKeychainWrapper

public enum Persistent {
    static let _user_Defauts_Keys_name = "_user_Defauts_Keys_"
    static var _user_Defauts_Keys_crypt: Typecrypt = { data, _ in data }
    static var _user_Defauts_Keys_ = PersistentData<Set<String>>(
        .userDefaults(
            key: _user_Defauts_Keys_name,
            encrypt: _user_Defauts_Keys_crypt,
            decrypt: _user_Defauts_Keys_crypt
        )
    )

    static func _save_key_user_Defauts(_ key: TypeKey) {
        if case let .userDefaults(key, _, _) = key, key != _user_Defauts_Keys_name {
            Persistent._user_Defauts_Keys_.value.insert(key)
        }
    }

    static func _remove_key_user_Defauts(_ key: TypeKey) {
        if case let .userDefaults(key, _, _) = key, key != _user_Defauts_Keys_name {
            Persistent._user_Defauts_Keys_.value.remove(key)
        }
    }

    public static func removeAllKeysUserDefaults() {
        Persistent._user_Defauts_Keys_.value.forEach { UserDefaults.standard.removeObject(forKey: $0) }
        Persistent._user_Defauts_Keys_.value = []
    }

    public static func removeAllKeysKeychainWrapper() {
        KeychainWrapper.standard.removeAllKeys()
    }

    public static func removeAllKeys() {
        removeAllKeysUserDefaults()
        removeAllKeysKeychainWrapper()
    }
}
