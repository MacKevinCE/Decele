//
//  ContactsManager.swift
//  Decele
//
//  Created by Mc Kevin on 17/01/23.
//

import Contacts

// MARK: - ContactsManager
open class ContactsManager<C> {
    internal var properties: [Property]

    public init(properties: [Property]) {
        self.properties = properties
    }

    private var retry = false
    private let queue = DispatchQueue(label: "ContactsManager", qos: .background)
    private var store = CNContactStore()
    private var status: CNAuthorizationStatus { type(of: store).authorizationStatus(for: .contacts) }
    private var localContact: [C] = []

    private func request(completion: @escaping (Result<[C], Error>) -> Void) {
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

    private func fetchRequest(completion: @escaping (Result<[C], Error>) -> Void) {
        let request = CNContactFetchRequest(keysToFetch: properties.map(\.asDescriptor))
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

    open func transform(contacts _: [CNContact]) -> [C] {
        []
    }

    public func loadLocal(completion: @escaping (Result<[C], Error>) -> Void) {
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

// MARK: - ContactsError
extension ContactsManager {
    private enum ContactsError: LocalizedError {
        case denied
        case fail
    }
}
