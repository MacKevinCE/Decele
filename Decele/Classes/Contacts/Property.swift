import Contacts

// MARK: - Property
public extension ContactsManager {
    enum Property: CaseIterable {
        case identifier
        case namePrefix
        case givenName
        case middleName
        case familyName
        case previousFamilyName
        case nameSuffix
        case nickname
        case organizationName
        case departmentName
        case jobTitle
        case phoneticGivenName
        case phoneticMiddleName
        case phoneticFamilyName
        case phoneticOrganizationName
        case birthday
        case nonGregorianBirthday
        case note
        case imageData
        case thumbnailImageData
        case imageDataAvailable
        case type
        case phoneNumbers
        case emailAddresses
        case postalAddresses
        case dates
        case urlAddresses
        case relations
        case socialProfiles
        case instantMessageAddresse

        public var asDescriptor: CNKeyDescriptor {
            switch self {
            case .identifier: return CNContactIdentifierKey as CNKeyDescriptor
            case .namePrefix: return CNContactNamePrefixKey as CNKeyDescriptor
            case .givenName: return CNContactGivenNameKey as CNKeyDescriptor
            case .middleName: return CNContactMiddleNameKey as CNKeyDescriptor
            case .familyName: return CNContactFamilyNameKey as CNKeyDescriptor
            case .previousFamilyName: return CNContactPreviousFamilyNameKey as CNKeyDescriptor
            case .nameSuffix: return CNContactNameSuffixKey as CNKeyDescriptor
            case .nickname: return CNContactNicknameKey as CNKeyDescriptor
            case .organizationName: return CNContactOrganizationNameKey as CNKeyDescriptor
            case .departmentName: return CNContactDepartmentNameKey as CNKeyDescriptor
            case .jobTitle: return CNContactJobTitleKey as CNKeyDescriptor
            case .phoneticGivenName: return CNContactPhoneticGivenNameKey as CNKeyDescriptor
            case .phoneticMiddleName: return CNContactPhoneticMiddleNameKey as CNKeyDescriptor
            case .phoneticFamilyName: return CNContactPhoneticFamilyNameKey as CNKeyDescriptor
            case .phoneticOrganizationName: return CNContactPhoneticOrganizationNameKey as CNKeyDescriptor
            case .birthday: return CNContactBirthdayKey as CNKeyDescriptor
            case .nonGregorianBirthday: return CNContactNonGregorianBirthdayKey as CNKeyDescriptor
            case .note: return CNContactNoteKey as CNKeyDescriptor
            case .imageData: return CNContactImageDataKey as CNKeyDescriptor
            case .thumbnailImageData: return CNContactThumbnailImageDataKey as CNKeyDescriptor
            case .imageDataAvailable: return CNContactImageDataAvailableKey as CNKeyDescriptor
            case .type: return CNContactTypeKey as CNKeyDescriptor
            case .phoneNumbers: return CNContactPhoneNumbersKey as CNKeyDescriptor
            case .emailAddresses: return CNContactEmailAddressesKey as CNKeyDescriptor
            case .postalAddresses: return CNContactPostalAddressesKey as CNKeyDescriptor
            case .dates: return CNContactDatesKey as CNKeyDescriptor
            case .urlAddresses: return CNContactUrlAddressesKey as CNKeyDescriptor
            case .relations: return CNContactRelationsKey as CNKeyDescriptor
            case .socialProfiles: return CNContactSocialProfilesKey as CNKeyDescriptor
            case .instantMessageAddresse: return CNContactInstantMessageAddressesKey as CNKeyDescriptor
            }
        }
    }
}
