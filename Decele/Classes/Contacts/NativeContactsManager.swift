//
//  NativeContactsManager.swift
//  Decele
//
//  Created by Mc Kevin on 23/02/23.
//

import Contacts

// MARK: - NativeContactsManager
public class NativeContactsManager: ContactsManager<CNContact> {
    public static let shared = NativeContactsManager(properties: Property.allCases)

    override public func transform(contacts: [CNContact]) -> [CNContact] {
        contacts
    }
}
