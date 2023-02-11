//
//  ContactsManager.swift
//  Decele
//
//  Created by Mc Kevin on 17/01/23.
//

import Contacts

// MARK: - LocalContacts
struct LocalContacts: Encodable {
    let givenName: String
    let familyName: String
    let phoneNumber: [String]
}

// MARK: - ContactsManager
class ContactsManager {
    static let shared = ContactsManager()
    private var retry = false
    private let queue = DispatchQueue(label: "ContactsManager", qos: .background)
    private var store = CNContactStore()
    private var status: CNAuthorizationStatus { type(of: store).authorizationStatus(for: .contacts) }
    private var localContact: [LocalContacts] = []
}

// MARK: - Property
extension ContactsManager {
    private enum Property: CaseIterable {
        case givenName
        case familyName
        case phoneNumber

        var asDescriptor: CNKeyDescriptor {
            switch self {
            case .givenName: return CNContactGivenNameKey as CNKeyDescriptor
            case .familyName: return CNContactFamilyNameKey as CNKeyDescriptor
            case .phoneNumber: return CNContactPhoneNumbersKey as CNKeyDescriptor
            }
        }
    }
}

// MARK: - ContactsError
extension ContactsManager {
    private enum ContactsError: LocalizedError {
        case denied
        case fail
    }
}

// MARK: - loadLocal
extension ContactsManager {
    private func request(completion: @escaping (Result<[LocalContacts], Error>) -> Void) {
        store.requestAccess(for: .contacts) { [weak self] authorized, error in
            guard let self = self else { return }
            if error != nil || !authorized || self.retry {
                completion(.failure(ContactsError.denied))
            } else {
                self.retry = true
                self.loadLocal(completion: completion)
            }
        }
    }

    private func fetchRequest(completion: @escaping (Result<[LocalContacts], Error>) -> Void) {
        let request = CNContactFetchRequest(keysToFetch: Property.allCases.map(\.asDescriptor))
        queue.async { [weak self] in
            guard let self = self else { return }
            var contacts: [CNContact] = []
            do {
                try self.store.enumerateContacts(with: request) { contact, _ in
                    contacts.append(contact)
                }
                self.localContact = self.transform(contacts: contacts)
                completion(.success(self.localContact))
            } catch {
                completion(.failure(ContactsError.fail))
            }
        }
    }

    private func transform(contacts: [CNContact]) -> [LocalContacts] {
        return contacts.map {
            guard $0.areKeysAvailable(Property.allCases.map(\.asDescriptor)) else { return nil }
            return LocalContacts(
                givenName: $0.givenName,
                familyName: $0.familyName,
                phoneNumber: $0.phoneNumbers.lazy.map { $0.value.stringValue }
            )
        }.compactMap { $0 }
    }

    func loadLocal(completion: @escaping (Result<[LocalContacts], Error>) -> Void) {
        if localContact.isEmpty {
            switch status {
            case .denied, .restricted:
                completion(.failure(ContactsError.denied))
            case .notDetermined:
                request(completion: completion)
            case .authorized:
                fetchRequest(completion: completion)
            @unknown default:
                completion(.failure(ContactsError.fail))
            }
        } else {
            completion(.success(localContact))
        }
    }
}
