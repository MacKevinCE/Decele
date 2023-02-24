//
//  BasicContactsManager.swift
//  Decele
//
//  Created by Mc Kevin on 23/02/23.
//

import Contacts

// MARK: - BasicContact
public struct BasicContact {
    let givenName: String
    let phoneNumber: [String]
}

// MARK: - BasicContactsManager
public class BasicContactsManager: ContactsManager<BasicContact> {
    public static let shared = BasicContactsManager(properties: [.givenName, .phoneNumbers])

    override public func transform(contacts: [CNContact]) -> [BasicContact] {
        return contacts.map { contact in
            guard contact.areKeysAvailable(properties.map(\.asDescriptor)) else { return nil }
            return BasicContact(
                givenName: contact.givenName,
                phoneNumber: contact.phoneNumbers.lazy.map { $0.value.stringValue }
            )
        }.compactMap { $0 }
    }
}
