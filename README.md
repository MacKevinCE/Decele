# Decele

A modular Swift library for iOS providing logging, persistent storage, cryptography, networking, contacts, icon fonts, and UI components — all installable independently via CocoaPods subspecs.

[![Version](https://img.shields.io/cocoapods/v/Decele.svg?style=flat)](https://cocoapods.org/pods/Decele)
[![License](https://img.shields.io/cocoapods/l/Decele.svg?style=flat)](https://cocoapods.org/pods/Decele)
[![Platform](https://img.shields.io/cocoapods/p/Decele.svg?style=flat)](https://cocoapods.org/pods/Decele)

## Modules

### Chuck — In-App Debug Console

A logging system with a floating in-app debug viewer. Captures structured logs across multiple categories.

```swift
Chuck.print("User tapped login")
Chuck.debug("Token: \(token)")
Chuck.warning("Cache miss for key: \(key)")
Chuck.error("Failed to decode response", error)

// HTTP request/response logging
Chuck.service(request: urlRequest, response: httpResponse, data: responseData)

// ARC lifecycle tracking
Chuck.classInit(self)  // in init()
Chuck.classDeinit(self) // in deinit
```

**Log levels:** `.print`, `.debug`, `.info`, `.warning`, `.error`
**Log categories:** `.log`, `.service`, `.persistent`, `.arc`, `.custom(name:)`

Configure the floating debug button:

```swift
Chuck.typeOpen(.circle)
Chuck.setBaseURL("https://api.example.com")
Chuck.setEnableType([.log, .service])
```

### Persistent — UserDefaults + Keychain Storage

Property wrappers for transparent persistence with optional encryption.

```swift
// UserDefaults
@PersistentData(key: .userDefaults(key: "username"))
var username: String = "default"

// Keychain
@PersistentOptional(key: .keychain(key: "authToken"))
var token: String?

// With encryption
@PersistentData(key: .userDefaults(
    key: "sensitiveData",
    encrypt: { data, key in Crypto.createSealedBox(data, pass: key) },
    decrypt: { data, key in Crypto.openSealedBox(data, pass: key) }
))
var secret: String = ""

// Clear all
Persistent.removeAllKeysUserDefaults()
Persistent.removeAllKeysKeychainWrapper()
```

### Crypto — AES-GCM + HMAC

Thin wrapper around Apple's CryptoKit. No external dependencies.

```swift
// AES-GCM encryption
let encrypted: Data = try Crypto.createSealedBox(myData, pass: "passphrase")
let decrypted: Data = try Crypto.openSealedBox(encrypted, pass: "passphrase")

// Works with Encodable/Decodable
let sealed: String = try Crypto.createSealedBox(myModel, pass: "key") // Base64 URL-encoded
let model: MyModel = try Crypto.openSealedBox(sealed, pass: "key")

// HMAC-SHA512 signatures
let signature = try Crypto.signatureHMAC(myModel, pass: "secret")
let isValid = try Crypto.isValidSignatureHMAC(signature, value: myModel, pass: "secret")
```

### Repository — Alamofire + Combine Networking

Protocol-based networking with typed responses and built-in token refresh.

```swift
struct GetUsersRequest: RepositoryDecodable {
    typealias Result = [User]
    typealias Failure = APIError

    var dataRequest: DataRequest {
        Session.default
            .request("users", method: .get)
    }
}

// Usage
GetUsersRequest()
    .resolve(showError: true) { completion in
        // handle Subscribers.Completion
    } receiveValue: { users in
        self.users = users
    }
    .store(in: &cancellables)
```

**Response protocols:** `RepositoryDecodable`, `RepositoryData`, `RepositoryString`, `RepositoryVoid`, `RepositoryResponse`

**Built-in features:**
- `TokenInterceptor` — Alamofire `RequestInterceptor` for bearer token injection and refresh
- Request deduplication for parallel calls to the same URL
- Configurable progress indicator and debug logging (prints to Chuck)
- Header helpers: `.basic()`, `.token(_:)`, `.signature(_:)`, `.authorization(username:password:)`

### Contacts — Address Book Wrapper

Generic, type-safe wrapper around `CNContactStore`.

```swift
let manager = BasicContactsManager()
manager.loadLocal { result in
    switch result {
    case .success(let contacts): // [BasicContact]
    case .failure(let error): // handle
    }
}
```

Subclass `ContactsManager<C>` and override `transform(contacts:)` for custom models.

### Fonts — Icon Font System

Load and use icon fonts from four bundled libraries.

```swift
// As UIImage
let icon = FontawesomeFree.heart.image(textColor: .red, size: CGSize(width: 24, height: 24))

// On UIImageView
imageView.image(name: .heart, style: .solid, textColor: .systemBlue)

// As UIFont
let font = BootstrapIcons.house.font(ofSize: 20)
```

**Bundled fonts:** Font Awesome Free, Font Awesome Brands, Bootstrap Icons, Material Icons

### Components

| Component | Description |
|-----------|-------------|
| **Button** | Multi-state `UIButton` with built-in `UIActivityIndicatorView` overlay |
| **TextField** | Animated text field with formatter, validator, max length, and character counter |
| **FloatingPanel** | Pre-configured floating panel from `NibView`, `UIViewController`, or `UIView` |
| **SideMenu** | Slide-in navigation drawer with configurable appearance |
| **NibView** | Base class for XIB-backed reusable views with auto-loading |

## Installation

### CocoaPods

```ruby
# Full library
pod 'Decele'

# Individual modules
pod 'Decele/Chuck'
pod 'Decele/Persistent'
pod 'Decele/Crypto'
pod 'Decele/Repository'
pod 'Decele/Contacts'
pod 'Decele/Fonts'
pod 'Decele/Components'

# Granular components
pod 'Decele/Components/Button'
pod 'Decele/Components/TextField'
pod 'Decele/Components/FloatingPanel'
pod 'Decele/Components/SideMenu'
pod 'Decele/Components/NibView'

# Individual font libraries
pod 'Decele/Fonts/FontawesomeFree'
pod 'Decele/Fonts/FontawesomeBrands'
pod 'Decele/Fonts/BootstrapIcons'
pod 'Decele/Fonts/MaterialIcons'
```

> **Note:** Add `submodules: true` in your Podfile if installing font subspecs, as icon libraries are Git submodules.

## Requirements

- iOS 13.0+
- Swift 5.0+

## Dependencies

| Module | Dependency |
|--------|------------|
| Persistent | `SwiftKeychainWrapper ~> 4.0.1` |
| Repository | `Alamofire` |
| Components/Button | `SnapKit` |
| Components/NibView | `SnapKit` |
| Components/FloatingPanel | `FloatingPanel` |
| Components/SideMenu | `SideMenu` |
| Chuck, Crypto, Contacts, Fonts | None |

## Author

Mac Kevin C. E.

## License

Decele is available under the MIT license. See the [LICENSE](LICENSE) file for details.
