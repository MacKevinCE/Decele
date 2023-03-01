//
//  TotalContactsManager.swift
//  Decele
//
//  Created by Mc Kevin on 23/02/23.
//

import Contacts

// MARK: - AllContact
public struct AllContact {
    var identifier: String = ""
    var namePrefix: String = ""
    var givenName: String = ""
    var middleName: String = ""
    var familyName: String = ""
    var previousFamilyName: String = ""
    var nameSuffix: String = ""
    var nickname: String = ""
    var organizationName: String = ""
    var departmentName: String = ""
    var jobTitle: String = ""
    var phoneticGivenName: String = ""
    var phoneticMiddleName: String = ""
    var phoneticFamilyName: String = ""
    var phoneticOrganizationName: String = ""
    var birthday: DateComponents? = nil
    var nonGregorianBirthday: DateComponents? = nil
    var note: String = ""
    var imageData: Data? = nil
    var thumbnailImageData: Data? = nil
    var imageDataAvailable: Bool = false
    var type: CNContactType = .person
    var phoneNumbers: [CNPhoneNumber] = []
    var emailAddresses: [NSString] = []
    var postalAddresses: [CNPostalAddress] = []
    var dates: [NSDateComponents] = []
    var urlAddresses: [NSString] = []
    var relations: [CNContactRelation] = []
    var socialProfiles: [CNSocialProfile] = []
    var instantMessageAddresse: [CNInstantMessageAddress] = []
}

// MARK: - AllContactManager
public class AllContactManager: ContactsManager<AllContact> {
    public static let shared = AllContactManager(properties: Property.allCases)

    override public func transform(contacts: [CNContact]) -> [AllContact] {
        contacts.map { contact in
            var localContacts = AllContact()

            for property in properties {
                guard contact.areKeysAvailable([property.asDescriptor]) else { continue }
                switch property {
                case .identifier: localContacts.identifier = contact.identifier
                case .namePrefix: localContacts.namePrefix = contact.namePrefix
                case .givenName: localContacts.givenName = contact.givenName
                case .middleName: localContacts.middleName = contact.middleName
                case .familyName: localContacts.familyName = contact.familyName
                case .previousFamilyName: localContacts.previousFamilyName = contact.previousFamilyName
                case .nameSuffix: localContacts.nameSuffix = contact.nameSuffix
                case .nickname: localContacts.nickname = contact.nickname
                case .organizationName: localContacts.organizationName = contact.organizationName
                case .departmentName: localContacts.departmentName = contact.departmentName
                case .jobTitle: localContacts.jobTitle = contact.jobTitle
                case .phoneticGivenName: localContacts.phoneticGivenName = contact.phoneticGivenName
                case .phoneticMiddleName: localContacts.phoneticMiddleName = contact.phoneticMiddleName
                case .phoneticFamilyName: localContacts.phoneticFamilyName = contact.phoneticFamilyName
                case .phoneticOrganizationName: localContacts.phoneticOrganizationName = contact.phoneticOrganizationName
                case .birthday: localContacts.birthday = contact.birthday
                case .nonGregorianBirthday: localContacts.nonGregorianBirthday = contact.nonGregorianBirthday
                case .note: localContacts.note = contact.note
                case .imageData: localContacts.imageData = contact.imageData
                case .thumbnailImageData: localContacts.thumbnailImageData = contact.thumbnailImageData
                case .imageDataAvailable: localContacts.imageDataAvailable = contact.imageDataAvailable
                case .type: localContacts.type = contact.contactType
                case .phoneNumbers: localContacts.phoneNumbers = contact.phoneNumbers.lazy.map(\.value)
                case .emailAddresses: localContacts.emailAddresses = contact.emailAddresses.lazy.map(\.value)
                case .postalAddresses: localContacts.postalAddresses = contact.postalAddresses.lazy.map(\.value)
                case .dates: localContacts.dates = contact.dates.lazy.map(\.value)
                case .urlAddresses: localContacts.urlAddresses = contact.urlAddresses.lazy.map(\.value)
                case .relations: localContacts.relations = contact.contactRelations.lazy.map(\.value)
                case .socialProfiles: localContacts.socialProfiles = contact.socialProfiles.lazy.map(\.value)
                case .instantMessageAddresse: localContacts.instantMessageAddresse = contact.instantMessageAddresses.lazy.map(\.value)
                }
            }
            return localContacts
        }.compactMap { $0 }
    }
}
