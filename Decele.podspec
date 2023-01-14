Pod::Spec.new do |s|
  s.name             = 'Decele'
  s.version          = '0.1.2'
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
  s.default_subspecs = 'Persistent', 'Crypto', 'Chuck', 'Repository', 'Components'
  s.requires_arc = true

  # Persistent Extensions
  s.subspec 'Persistent' do |sp|
    sp.source_files  = 'Decele/Classes/Persistent/**/*'
    sp.dependency 'Decele/Shared'
    sp.dependency 'SwiftKeychainWrapper', '~> 4.0.1'
  end
  
  # Crypto Extensions
  s.subspec 'Crypto' do |sp|
    sp.source_files  = 'Decele/Classes/Crypto/**/*'
    sp.dependency 'Decele/Shared'
    sp.ios.frameworks = 'CryptoKit'
  end
  
  # Chuck Extensions
  s.subspec 'Chuck' do |sp|
    sp.source_files  = 'Decele/Classes/Chuck/**/*'
    sp.dependency 'Decele/Shared'
    sp.resource_bundles = {
       'Chuck' => ['Decele/Assets/Chuck/*.xcassets']
    }
  end
  
  # Repository Extensions
  s.subspec 'Repository' do |sp|
    sp.source_files  = 'Decele/Classes/Repository/**/*'
    sp.dependency 'Decele/Shared'
    sp.dependency 'Alamofire', '~> 5.6.4'
    sp.dependency 'PromiseKit', '~> 6.18.1'
  end
  
  # Components Extensions
  s.subspec 'Components' do |sp|
    # FloatingPanel Extensions
    sp.subspec 'FloatingPanel' do |spp|
      spp.source_files  = 'Decele/Classes/Components/FloatingPanel/**/*'
      spp.dependency 'Decele/Shared'
      spp.dependency 'FloatingPanel', '~> 2.5.5'
    end
    
    # SideMenu Extensions
    sp.subspec 'SideMenu' do |spp|
      spp.source_files  = 'Decele/Classes/Components/SideMenu/**/*'
      spp.dependency 'Decele/Shared'
      spp.dependency 'SideMenu', '~> 6.5.0'
    end
    
    # Button Extensions
    sp.subspec 'Button' do |spp|
      spp.source_files  = 'Decele/Classes/Components/Button/**/*'
      spp.dependency 'Decele/Shared'
    end
    
    # TextField Extensions
    sp.subspec 'TextField' do |spp|
      spp.source_files  = 'Decele/Classes/Components/TextField/**/*'
      spp.dependency 'Decele/Shared'
    end
  end

  # Shared Extensions
  s.subspec 'Shared' do |sp|
    sp.source_files  = 'Decele/Classes/Shared/**/*'
  end
  
  s.ios.frameworks = 'UIKit'
  s.frameworks = 'Foundation'
end
