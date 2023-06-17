Pod::Spec.new do |s|
    s.name             = 'Decele'
    s.version          = '0.5.0'
    s.summary          = 'The library provides a complete solution for log management, data storage, network requests, and graphical components in iOS applications.'
    s.description      = <<-DESC
    This library provides a complete solution for log management, persistent data storage, network requests, and graphical components in iOS applications. It includes a log visualization system for services and prints, the ability to save data in UserDefaults and Keychain, a system for making requests to endpoints using Alamofire, and a variety of graphical components such as FloatingPanel, SideMenu, Buttons, among others to facilitate the design of views.
                                             DESC
    s.homepage         = 'https://github.com/MacKevinCE/Decele'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Mac Kevin C. E.' => 'mac.kevin.c.e@gmail.com' }
    s.social_media_url = 'https://twitter.com/MacKevinCE'
    # s.screenshot = ''

    s.ios.deployment_target = '13.0'
    s.swift_versions = ['5.0', '5.1', '5.2', '5.3', '5.4', '5.5']

    s.source = {
        :git => "https://github.com/MacKevinCE/#{s.name}.git",
        :tag => s.version.to_s,
        :submodules => true
    }

    #s.default_subspecs = 'Contacts', 'Persistent', 'Crypto', 'Chuck', 'Repository', 'Components'
    s.requires_arc = true

    # Contacts
    s.subspec 'Contacts' do |sp|
        sp.source_files = 'Decele/Classes/Contacts/**/*'
    end

    # Persistent
    s.subspec 'Persistent' do |sp|
        sp.source_files = 'Decele/Classes/Persistent/**/*'
        sp.dependency 'Decele/SwifterSwift/SwiftStdlib/Decodable'
        sp.dependency 'Decele/SwifterSwift/SwiftStdlib/Encodable'
        sp.dependency 'Decele/SwifterSwift/SwiftStdlib/StringProtocol'
        sp.dependency 'SwiftKeychainWrapper', '~> 4.0.1'
    end

    # Crypto
    s.subspec 'Crypto' do |sp|
        sp.source_files = 'Decele/Classes/Crypto/**/*'
        sp.dependency 'Decele/SwifterSwift/SwiftStdlib/Decodable'
        sp.dependency 'Decele/SwifterSwift/SwiftStdlib/Encodable'
        sp.dependency 'Decele/SwifterSwift/SwiftStdlib/String'
        sp.ios.frameworks = 'CryptoKit'
    end

    # Chuck
    s.subspec 'Chuck' do |sp|
        sp.source_files = 'Decele/Classes/Chuck/**/*'
        sp.dependency 'Decele/Components/NameClass'
        sp.dependency 'Decele/SwifterSwift/SwiftStdlib/Array'
        sp.dependency 'Decele/SwifterSwift/SwiftStdlib/String'
        sp.dependency 'Decele/SwifterSwift/SwiftStdlib/Encodable'
        sp.dependency 'Decele/SwifterSwift/SwiftStdlib/StringProtocol'
        sp.dependency 'Decele/SwifterSwift/SwiftStdlib/Optional'
        sp.dependency 'Decele/SwifterSwift/SwiftStdlib/Collection'
        sp.dependency 'Decele/SwifterSwift/Foundation/Bundle'
        sp.dependency 'Decele/SwifterSwift/Foundation/Data'
        sp.dependency 'Decele/SwifterSwift/Foundation/Date'
        sp.dependency 'Decele/SwifterSwift/Foundation/NSAttributedString'
        sp.dependency 'Decele/SwifterSwift/UIKit/UIApplication'
        sp.dependency 'Decele/SwifterSwift/UIKit/UIView'
        sp.dependency 'Decele/SwifterSwift/UIKit/UIButton'
        sp.dependency 'Decele/SwifterSwift/UIKit/UITableView'
        sp.dependency 'SnapKit', '~> 5.6.0'
        sp.resource_bundles = {
            'Chuck' => ['Decele/Assets/Chuck/*.xcassets']
        }
    end

    # Repository
    s.subspec 'Repository' do |sp|
        sp.source_files = 'Decele/Classes/Repository/**/*'
        sp.dependency 'Decele/SwifterSwift/SwiftStdlib/Encodable'
        sp.dependency 'Decele/SwifterSwift/SwiftStdlib/StringProtocol'
        sp.dependency 'Decele/SwifterSwift/Foundation/Data'
        sp.dependency 'Alamofire', '~> 5.6.4'
    end

    # Components
    s.subspec 'Components' do |sp|

        # NameClass
        sp.subspec 'NameClass' do |spp|
            spp.source_files = 'Decele/Classes/Components/NameClass/NameClass.swift'
        end

        # NibView
        sp.subspec 'NibView' do |spp|
            spp.source_files = 'Decele/Classes/Components/NibView/NibView.swift'
            spp.dependency 'Decele/Components/NameClass'
            spp.dependency 'Decele/SwifterSwift/SwiftStdlib/Array'
            spp.dependency 'SnapKit', '~> 5.6.0'
        end

        # FloatingPanel
        sp.subspec 'FloatingPanel' do |spp|
            spp.source_files = 'Decele/Classes/Components/FloatingPanel/**/*'
            spp.dependency 'Decele/Components/NibView'
            spp.dependency 'FloatingPanel', '~> 2.6.2'
        end

        # SideMenu
        sp.subspec 'SideMenu' do |spp|
            spp.source_files = 'Decele/Classes/Components/SideMenu/**/*'
            spp.dependency 'Decele/Components/NameClass'
            spp.dependency 'Decele/SwifterSwift/SwiftStdlib/Array'
            spp.dependency 'Decele/SwifterSwift/SwiftStdlib/Character'
            spp.dependency 'Decele/SwifterSwift/SwiftStdlib/SignedNumeric'
            sp.dependency 'Decele/SwifterSwift/UIKit/UITableView'
            spp.dependency 'SideMenu', '~> 6.5.0'
        end

        # Button
        sp.subspec 'Button' do |spp|
            spp.source_files = 'Decele/Classes/Components/Button/**/*'
            spp.dependency 'SnapKit', '~> 5.6.0'
        end

        # TextField
        sp.subspec 'TextField' do |spp|
            spp.source_files = 'Decele/Classes/Components/TextField/**/*'
            spp.dependency 'Decele/Components/Button'
            spp.dependency 'Decele/Components/NameClass'
            spp.dependency 'Decele/SwifterSwift/SwiftStdlib/Optional'
            spp.dependency 'Decele/SwifterSwift/SwiftStdlib/Character'
            spp.dependency 'Decele/SwifterSwift/SwiftStdlib/SignedNumeric'
            spp.dependency 'Decele/SwifterSwift/UIKit/UIView'
            spp.dependency 'SnapKit', '~> 5.6.0'
        end
    end

    # Fonts
    s.subspec 'Fonts' do |sp|

        # Tools
        sp.subspec 'Tools' do |spp|
            spp.source_files = 'Decele/Classes/Fonts/*.swift'
            spp.dependency 'Decele/SwifterSwift/SwiftStdlib/String'
            spp.preserve_paths = "Decele/Classes/Fonts/FontsTools"
        end

        # BootstrapIcons
        sp.subspec 'BootstrapIcons' do |spp|
            spp.source_files = 'Decele/Classes/Fonts/styles/BootstrapIconsStyle.swift', 'Decele/Classes/Fonts/enums/BootstrapIcons.swift'
            spp.dependency 'Decele/Fonts/Tools'
            spp.resource_bundles = {
                'BootstrapIcons' => ['FontLibraries/BootstrapIcons/font/fonts/*.woff']
            }
        end

        # FontawesomeBrands
        sp.subspec 'FontawesomeBrands' do |spp|
            spp.source_files = 'Decele/Classes/Fonts/styles/FontawesomeBrandsStyle.swift', 'Decele/Classes/Fonts/enums/FontawesomeBrands.swift'
            spp.dependency 'Decele/Fonts/Tools'
            spp.resource_bundles = {
                'FontawesomeBrands' => ['FontLibraries/FontawesomeFree/otfs/Font Awesome 6 Brands-Regular-400.otf']
            }
        end

        # FontawesomeFree
        sp.subspec 'FontawesomeFree' do |spp|
            spp.source_files = 'Decele/Classes/Fonts/styles/FontawesomeFreeStyle.swift', 'Decele/Classes/Fonts/enums/FontawesomeFree.swift'
            spp.dependency 'Decele/Fonts/Tools'
            spp.resource_bundles = {
                'FontawesomeFree' => ['FontLibraries/FontawesomeFree/otfs/Font Awesome 6 Free-Regular-400.otf', 'FontLibraries/FontawesomeFree/otfs/Font Awesome 6 Free-Solid-900.otf']
            }
        end

        # MaterialIcons
        sp.subspec 'MaterialIcons' do |spp|
            spp.source_files = 'Decele/Classes/Fonts/styles/MaterialIconsStyle.swift', 'Decele/Classes/Fonts/enums/MaterialIcons.swift'
            spp.dependency 'Decele/Fonts/Tools'
            spp.resource_bundles = {
                'MaterialIcons' => ['FontLibraries/MaterialIcons/iconfont/*.woff']
            }
        end
    end

    # SwifterSwift
    s.subspec 'SwifterSwift' do |sp|

        # Shared
        sp.subspec 'Shared' do |spp|

            # Color
            spp.subspec 'Color' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/Shared/ColorExtensions.swift'
            end

            # EdgeInsets
            spp.subspec 'EdgeInsets' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/Shared/EdgeInsetsExtensions.swift'
            end

            # Font
            spp.subspec 'Font' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/Shared/FontExtensions.swift'
            end
        end

        # SwiftStdlib Extensions
        sp.subspec 'SwiftStdlib' do |spp|

            # Array
            spp.subspec 'Array' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/ArrayExtensions.swift'
            end

            # BidirectionalCollection
            spp.subspec 'BidirectionalCollection' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/BidirectionalCollectionExtensions.swift'
            end

            # BinaryFloatingPoint
            spp.subspec 'BinaryFloatingPoint' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/BinaryFloatingPointExtensions.swift'
            end

            # BinaryInteger
            spp.subspec 'BinaryInteger' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/BinaryIntegerExtensions.swift'
            end

            # Bool
            spp.subspec 'Bool' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/BoolExtensions.swift'
            end

            # Character
            spp.subspec 'Character' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/CharacterExtensions.swift'
            end

            # Collection
            spp.subspec 'Collection' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/CollectionExtensions.swift'
            end

            # Comparable
            spp.subspec 'Comparable' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/ComparableExtensions.swift'
            end

            # Decodable
            spp.subspec 'Decodable' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/DecodableExtensions.swift'
            end

            # DefaultStringInterpolation
            spp.subspec 'DefaultStringInterpolation' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/DefaultStringInterpolationExtensions.swift'
            end

            # Dictionary
            spp.subspec 'Dictionary' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/DictionaryExtensions.swift'
            end

            # Double
            spp.subspec 'Double' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/DoubleExtensions.swift'
            end

            # Encodable
            spp.subspec 'Encodable' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/EncodableExtensions.swift'
            end

            # Float
            spp.subspec 'Float' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/FloatExtensions.swift'
            end

            # FloatingPoint
            spp.subspec 'FloatingPoint' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/FloatingPointExtensions.swift'
            end

            # Int
            spp.subspec 'Int' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/IntExtensions.swift'
                sppp.dependency 'Decele/SwifterSwift/SwiftStdlib/SignedInteger'
            end

            # KeyedDecodingContainer
            spp.subspec 'KeyedDecodingContainer' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/KeyedDecodingContainerExtensions.swift'
            end

            # MutableCollection
            spp.subspec 'MutableCollection' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/MutableCollectionExtensions.swift'
            end

            # Optional
            spp.subspec 'Optional' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/OptionalExtensions.swift'
            end

            # RangeReplaceableCollection
            spp.subspec 'RangeReplaceableCollection' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/RangeReplaceableCollectionExtensions.swift'
            end

            # Sequence
            spp.subspec 'Sequence' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/SequenceExtensions.swift'
            end

            # SignedInteger
            spp.subspec 'SignedInteger' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/SignedIntegerExtensions.swift'
            end

            # SignedNumeric
            spp.subspec 'SignedNumeric' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/SignedNumericExtensions.swift'
            end

            # String
            spp.subspec 'String' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/StringExtensions.swift'
                sppp.dependency 'Decele/SwifterSwift/Shared/Color'
                sppp.dependency 'Decele/SwifterSwift/Shared/Font'
            end

            # StringProtocol
            spp.subspec 'StringProtocol' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SwiftStdlib/StringProtocolExtensions.swift'
            end
        end

        # Foundation Extensions
        sp.subspec 'Foundation' do |spp|

            # Bundle
            spp.subspec 'Bundle' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/Foundation/BundleExtensions.swift'
            end

            # Calendar
            spp.subspec 'Calendar' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/Foundation/CalendarExtensions.swift'
            end

            # Data
            spp.subspec 'Data' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/Foundation/DataExtensions.swift'
                sppp.dependency 'Decele/SwifterSwift/SwiftStdlib/Decodable'
            end

            # Date
            spp.subspec 'Date' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/Foundation/DateExtensions.swift'
            end

            # FileManager
            spp.subspec 'FileManager' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/Foundation/FileManagerExtensions.swift'
            end

            # Locale
            spp.subspec 'Locale' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/Foundation/LocaleExtensions.swift'
            end

            # Measurement
            spp.subspec 'Measurement' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/Foundation/MeasurementExtensions.swift'
            end

            # NotificationCenter
            spp.subspec 'NotificationCenter' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/Foundation/NotificationCenterExtensions.swift'
            end

            # NSAttributedString
            spp.subspec 'NSAttributedString' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/Foundation/NSAttributedStringExtensions.swift'
                sppp.dependency 'Decele/SwifterSwift/Shared/Color'
                sppp.dependency 'Decele/SwifterSwift/Shared/Font'
            end

            # NSPredicate
            spp.subspec 'NSPredicate' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/Foundation/NSPredicateExtensions.swift'
            end

            # NSRegularExpression
            spp.subspec 'NSRegularExpression' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/Foundation/NSRegularExpressionExtensions.swift'
            end

            # URL
            spp.subspec 'URL' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/Foundation/URLExtensions.swift'
            end

            # URLRequest
            spp.subspec 'URLRequest' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/Foundation/URLRequestExtensions.swift'
            end

            # URLSession
            spp.subspec 'URLSession' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/Foundation/URLSessionExtensions.swift'
            end

            # UserDefaults
            spp.subspec 'UserDefaults' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/Foundation/UserDefaultsExtensions.swift'
            end
        end

        # UIKit Extensions
        sp.subspec 'UIKit' do |spp|

            # UIActivity
            spp.subspec 'UIActivity' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UIActivityExtensions.swift'
            end

            # UIAlertController
            spp.subspec 'UIAlertController' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UIAlertControllerExtensions.swift'
            end

            # UIApplication
            spp.subspec 'UIApplication' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UIApplicationExtensions.swift'
            end

            # UIBarButtonItem
            spp.subspec 'UIBarButtonItem' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UIBarButtonItemExtensions.swift'
            end

            # UIBezierPath
            spp.subspec 'UIBezierPath' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UIBezierPathExtensions.swift'
            end

            # UIButton
            spp.subspec 'UIButton' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UIButtonExtensions.swift'
            end

            # UICollectionView
            spp.subspec 'UICollectionView' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UICollectionViewExtensions.swift'
            end

            # UIColor
            spp.subspec 'UIColor' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UIColorExtensions.swift'
            end

            # UIDatePicker
            spp.subspec 'UIDatePicker' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UIDatePickerExtensions.swift'
            end

            # UIFont
            spp.subspec 'UIFont' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UIFontExtensions.swift'
            end

            # UIGestureRecognizer
            spp.subspec 'UIGestureRecognizer' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UIGestureRecognizerExtensions.swift'
            end

            # UIImage
            spp.subspec 'UIImage' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UIImageExtensions.swift'
            end

            # UIImageView
            spp.subspec 'UIImageView' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UIImageViewExtensions.swift'
            end

            # UILabel
            spp.subspec 'UILabel' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UILabelExtensions.swift'
            end

            # UILayoutPriority
            spp.subspec 'UILayoutPriority' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UILayoutPriorityExtensions.swift'
            end

            # UINavigationBar
            spp.subspec 'UINavigationBar' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UINavigationBarExtensions.swift'
            end

            # UINavigationController
            spp.subspec 'UINavigationController' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UINavigationControllerExtensions.swift'
            end

            # UINavigationItem
            spp.subspec 'UINavigationItem' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UINavigationItemExtensions.swift'
            end

            # UIRefreshControl
            spp.subspec 'UIRefreshControl' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UIRefreshControlExtensions.swift'
            end

            # UIScrollView
            spp.subspec 'UIScrollView' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UIScrollViewExtensions.swift'
            end

            # UISearchBar
            spp.subspec 'UISearchBar' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UISearchBarExtensions.swift'
            end

            # UISegmentedControl
            spp.subspec 'UISegmentedControl' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UISegmentedControlExtensions.swift'
            end

            # UISlider
            spp.subspec 'UISlider' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UISliderExtensions.swift'
            end

            # UIStackView
            spp.subspec 'UIStackView' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UIStackViewExtensions.swift'
            end

            # UIStoryboard
            spp.subspec 'UIStoryboard' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UIStoryboardExtensions.swift'
            end

            # UISwitch
            spp.subspec 'UISwitch' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UISwitchExtensions.swift'
            end

            # UITabBar
            spp.subspec 'UITabBar' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UITabBarExtensions.swift'
            end

            # UITableView
            spp.subspec 'UITableView' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UITableViewExtensions.swift'
            end

            # UITextField
            spp.subspec 'UITextField' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UITextFieldExtensions.swift'
            end

            # UITextView
            spp.subspec 'UITextView' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UITextViewExtensions.swift'
            end

            # UIViewController
            spp.subspec 'UIViewController' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UIViewControllerExtensions.swift'
            end

            # UIView
            spp.subspec 'UIView' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UIViewExtensions.swift'
                spp.dependency 'Decele/SwifterSwift/Shared/Color'
            end

            # UIWindow
            spp.subspec 'UIWindow' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/UIKit/UIWindowExtensions.swift'
            end
        end

        # AppKit Extensions
        sp.subspec 'AppKit' do |spp|

            # NSColor
            spp.subspec 'NSColor' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/AppKit/NSColorExtensions.swift'
            end

            # NSImage
            spp.subspec 'NSImage' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/AppKit/NSImageExtensions.swift'
            end

            # NSView
            spp.subspec 'NSView' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/AppKit/NSViewExtensions.swift'
            end
        end

        # CoreGraphics Extensions
        sp.subspec 'CoreGraphics' do |spp|
            spp.dependency 'Decele/SwifterSwift/Shared/Color'

            # CGAffineTransform
            spp.subspec 'CGAffineTransform' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/CoreGraphics/CGAffineTransformExtensions.swift'
            end

            # CGColor
            spp.subspec 'CGColor' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/CoreGraphics/CGColorExtensions.swift'
            end

            # CGFloat
            spp.subspec 'CGFloat' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/CoreGraphics/CGFloatExtensions.swift'
            end

            # CGPoint
            spp.subspec 'CGPoint' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/CoreGraphics/CGPointExtensions.swift'
            end

            # CGRect
            spp.subspec 'CGRect' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/CoreGraphics/CGRectExtensions.swift'
            end

            # CGSize
            spp.subspec 'CGSize' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/CoreGraphics/CGSizeExtensions.swift'
            end

            # CGVector
            spp.subspec 'CGVector' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/CoreGraphics/CGVectorExtensions.swift'
            end
        end

        # CoreLocation Extensions
        sp.subspec 'CoreLocation' do |spp|
            spp.dependency 'Decele/SwifterSwift/Shared/Color'

            # CLLocationArray
            spp.subspec 'CLLocationArray' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/CoreLocation/CLLocationArrayExtensions.swift'
            end

            # CLLocation
            spp.subspec 'CLLocation' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/CoreLocation/CLLocationExtensions.swift'
            end

            # CLVisit
            spp.subspec 'CLVisit' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/CoreLocation/CLVisitExtensions.swift'
            end
        end

        # CoreAnimation Extensions
        sp.subspec 'CoreAnimation' do |spp|

            # CAGradientLayer
            spp.subspec 'CAGradientLayer' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/CoreAnimation/CAGradientLayerExtensions.swift'
                sppp.dependency 'Decele/SwifterSwift/Shared/Color'
            end

            # CATransform3D
            spp.subspec 'CATransform3D' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/CoreAnimation/CATransform3DExtensions.swift'
            end
        end

        # CryptoKit Extensions
        sp.subspec 'CryptoKit' do |spp|
            spp.source_files = 'SwifterSwift/Sources/SwifterSwift/CryptoKit/*.swift'
        end

        # MapKit Extensions
        sp.subspec 'MapKit' do |spp|

            # MKMapView
            spp.subspec 'MKMapView' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/MapKit/MKMapViewExtensions.swift'
                sppp.dependency 'Decele/SwifterSwift/Shared/EdgeInsets'
            end

            # MKMultiPoint
            spp.subspec 'MKMultiPoint' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/MapKit/MKMultiPointExtensions.swift'
            end

            # MKPolyline
            spp.subspec 'MKPolyline' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/MapKit/MKPolylineExtensions.swift'
            end
        end

        # SpriteKit Extensions
        sp.subspec 'SpriteKit' do |spp|

            # SKNode
            spp.subspec 'SKNode' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SpriteKit/SKNodeExtensions.swift'
            end

            # SKSpriteNode
            spp.subspec 'SKSpriteNode' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SpriteKit/SKSpriteNodeExtensions.swift'
            end
        end

        # SceneKit Extensions
        sp.subspec 'SceneKit' do |spp|

            # SCNBox
            spp.subspec 'SCNBox' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SceneKit/SCNBoxExtensions.swift'
                sppp.dependency 'Decele/SwifterSwift/SceneKit/SCNMaterial'
                sppp.dependency 'Decele/SwifterSwift/Shared/Color'
            end

            # SCNCapsule
            spp.subspec 'SCNCapsule' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SceneKit/SCNCapsuleExtensions.swift'
                sppp.dependency 'Decele/SwifterSwift/SceneKit/SCNMaterial'
                sppp.dependency 'Decele/SwifterSwift/Shared/Color'
            end

            # SCNCone
            spp.subspec 'SCNCone' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SceneKit/SCNConeExtensions.swift'
                sppp.dependency 'Decele/SwifterSwift/SceneKit/SCNMaterial'
                sppp.dependency 'Decele/SwifterSwift/Shared/Color'
            end

            # SCNCylinder
            spp.subspec 'SCNCylinder' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SceneKit/SCNCylinderExtensions.swift'
                sppp.dependency 'Decele/SwifterSwift/SceneKit/SCNMaterial'
                sppp.dependency 'Decele/SwifterSwift/Shared/Color'
            end

            # SCNGeometry
            spp.subspec 'SCNGeometry' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SceneKit/SCNGeometryExtensions.swift'
                sppp.dependency 'Decele/SwifterSwift/SceneKit/SCNVector3'
            end

            # SCNMaterial
            spp.subspec 'SCNMaterial' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SceneKit/SCNMaterialExtensions.swift'
                sppp.dependency 'Decele/SwifterSwift/Shared/Color'
            end

            # SCNPlane
            spp.subspec 'SCNPlane' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SceneKit/SCNPlaneExtensions.swift'
                sppp.dependency 'Decele/SwifterSwift/SceneKit/SCNMaterial'
                sppp.dependency 'Decele/SwifterSwift/Shared/Color'
            end

            # SCNShape
            spp.subspec 'SCNShape' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SceneKit/SCNShapeExtensions.swift'
                sppp.dependency 'Decele/SwifterSwift/SceneKit/SCNMaterial'
                sppp.dependency 'Decele/SwifterSwift/Shared/Color'
            end

            # SCNSphere
            spp.subspec 'SCNSphere' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SceneKit/SCNSphereExtensions.swift'
                sppp.dependency 'Decele/SwifterSwift/SceneKit/SCNMaterial'
                sppp.dependency 'Decele/SwifterSwift/Shared/Color'
            end

            # SCNVector3
            spp.subspec 'SCNVector3' do |sppp|
                sppp.source_files = 'SwifterSwift/Sources/SwifterSwift/SceneKit/SCNVector3Extensions.swift'
            end
        end

        # StoreKit Extensions
        sp.subspec 'StoreKit' do |spp|
            spp.source_files = 'SwifterSwift/Sources/SwifterSwift/StoreKit/*.swift'
        end

        # Dispatch Extensions
        sp.subspec 'Dispatch' do |spp|
            spp.source_files = 'SwifterSwift/Sources/SwifterSwift/Dispatch/*.swift'
        end

        # WebKit Extensions
        sp.subspec 'WebKit' do |spp|
            spp.source_files = 'SwifterSwift/Sources/SwifterSwift/WebKit/*.swift'
        end

        # HealthKit Extensions
        sp.subspec 'HealthKit' do |spp|
            spp.source_files = 'SwifterSwift/Sources/SwifterSwift/HealthKit/*.swift'
        end
    end

    s.ios.frameworks = 'Foundation', 'CFNetwork', 'CryptoKit', 'UIKit'
end
