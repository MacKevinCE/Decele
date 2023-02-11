Pod::Spec.new do |s|
	s.name             = 'Decele'
	s.version          = '0.2.2'
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

	s.swift_version = ['5.0', '5.1', '5.2', '5.3', '5.4', '5.5']
	s.source = {
			:git => "https://github.com/MacKevinCE/#{s.name}.git",
			:tag => s.version.to_s,
			:submodules => true
		}
	s.default_subspecs = 'Contacts', 'Persistent', 'Crypto', 'Chuck', 'Repository', 'Components'
	s.requires_arc = true

	# Contacts
	s.subspec 'Contacts' do |sp|
		sp.source_files  = 'Decele/Classes/Contacts/**/*'
	end

	# Persistent
	s.subspec 'Persistent' do |sp|
		sp.source_files  = 'Decele/Classes/Persistent/**/*'
		sp.dependency 'Decele/Shared/Foundation'
		sp.dependency 'SwiftKeychainWrapper', '~> 4.0.1'
	end

	# Crypto
	s.subspec 'Crypto' do |sp|
		sp.source_files  = 'Decele/Classes/Crypto/**/*'
		sp.dependency 'Decele/Shared/Foundation'
		sp.ios.frameworks = 'CryptoKit'
	end

	# Chuck
	s.subspec 'Chuck' do |sp|
		sp.source_files  = 'Decele/Classes/Chuck/**/*'
		sp.dependency 'Decele/Shared'
        sp.dependency 'SnapKit', '~> 5.0.1'
		sp.resource_bundles = {
			 'Chuck' => ['Decele/Assets/Chuck/*.xcassets']
		}
	end

	# Repository
	s.subspec 'Repository' do |sp|
		sp.source_files  = 'Decele/Classes/Repository/**/*'
		sp.dependency 'Decele/Shared/Foundation'
		sp.dependency 'Alamofire', '~> 5.6.4'
		sp.dependency 'PromiseKit', '~> 6.18.1'
	end

	# Components
	s.subspec 'Components' do |sp|

		# NibView
		sp.subspec 'NibView' do |spp|
            spp.source_files  = 'Decele/Classes/Components/NibView/NibView.swift'
            spp.dependency 'Decele/Shared/Foundation'
            spp.dependency 'SnapKit', '~> 5.0.1'
		end

		# FloatingPanel
		sp.subspec 'FloatingPanel' do |spp|
			spp.source_files  = 'Decele/Classes/Components/FloatingPanel/**/*'
            spp.dependency 'Decele/Components/NibView'
			spp.dependency 'FloatingPanel', '~> 2.5.5'
		end

		# SideMenu
		sp.subspec 'SideMenu' do |spp|
			spp.source_files  = 'Decele/Classes/Components/SideMenu/**/*'
			spp.dependency 'Decele/Shared/UIKit'
			spp.dependency 'SideMenu', '~> 6.5.0'
		end

		# Button
		sp.subspec 'Button' do |spp|
			spp.source_files  = 'Decele/Classes/Components/Button/**/*'
			spp.dependency 'Decele/Shared/UIKit'
            spp.dependency 'SnapKit', '~> 5.0.1'
		end
	end

	# Shared
	s.subspec 'Shared' do |sp|
        # Foundation
        sp.subspec 'Foundation' do |spp|
            spp.source_files  = 'Decele/Classes/Shared/Foundation/**/*'
            spp.dependency 'Decele/Shared/Private'
            spp.dependency 'SwifterSwift/SwiftStdlib'
            spp.dependency 'SwifterSwift/Dispatch'
        end

        # UIKit
        sp.subspec 'UIKit' do |spp|
            spp.source_files  = 'Decele/Classes/Shared/UIKit/**/*'
            spp.dependency 'Decele/Shared/Private'
            spp.dependency 'SwifterSwift/UIKit'
            spp.dependency 'SnapKit', '~> 5.0.1'
        end
        
        # Private
        sp.subspec 'Private' do |spp|
            spp.source_files  = 'Decele/Classes/Shared/Private/**/*'
            spp.dependency 'SwifterSwift/Foundation'
        end
	end

	s.ios.frameworks = 'UIKit'
	s.frameworks = 'Foundation'
end
