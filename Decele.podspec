Pod::Spec.new do |s|
  s.name             = 'Decele'
  s.version          = '0.1.0'
  s.summary          = 'The library provides a complete solution for log management, data storage, network requests, and graphical components in iOS applications.'
  s.description      = <<-DESC
  This library provides a complete solution for log management, persistent data storage, network requests, and graphical components in iOS applications. It includes a log visualization system for services and prints, the ability to save data in UserDefaults and Keychain, a system for making requests to endpoints using Alamofire, and a variety of graphical components such as FloatingPanel, SideMenu, Buttons, among others to facilitate the design of views.
                       DESC
  s.homepage         = 'https://github.com/MacKevinCE/Decele'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mac Kevin C. E.' => 'mac.kevin.c.e@gmail.com' }
  s.social_media_url = 'https://twitter.com/MacKevinCE'
  s.screenshot = ''

  s.ios.deployment_target = '13.0'

  s.swift_version = '5'
  s.requires_arc = true
  s.source = { :git => 'https://github.com/MacKevinCE/Decele.git', :tag => s.version.to_s }
  s.source_files = 'Decele/Classes/**/*'
  
  # Persistent Extensions
  s.subspec 'Persistent' do |sp|
    sp.source_files  = 'Decele/Classes/Persistent/**/*', 'Decele/Classes/Shared/**/*'
    sp.dependency 'SwiftKeychainWrapper', '~> 4.0.1'
  end
  
  # Crypto Extensions
  s.subspec 'Crypto' do |sp|
    sp.source_files  = 'Decele/Classes/Crypto/**/*', 'Decele/Classes/Shared/**/*'
    sp.frameworks = 'CryptoKit'
  end
  
  # Chuck Extensions
  s.subspec 'Chuck' do |sp|
    sp.source_files  = 'Decele/Classes/Chuck/**/*', 'Decele/Classes/Shared/**/*'
    sp.resource_bundles = {
       'Chuck' => ['Decele/Assets/Chuck/*.xcassets']
    }
  end
  
  # Repository Extensions
  s.subspec 'Repository' do |sp|
    sp.source_files  = 'Decele/Classes/Repository/**/*', 'Decele/Classes/Shared/**/*'
    sp.dependency 'Alamofire', '~> 5.6.4'
    sp.dependency 'PromiseKit', '~> 6.18.1'
  end
  
  # Components Extensions
  s.subspec 'Components' do |sp|
    sp.source_files  = 'Decele/Classes/Components/**/*', 'Decele/Classes/Shared/**/*'
    
    # FloatingPanel Extensions
    sp.subspec 'FloatingPanel' do |spp|
      spp.source_files  = 'Decele/Classes/Components/FloatingPanel/**/*', 'Decele/Classes/Shared/**/*'
      spp.dependency 'FloatingPanel', '~> 2.5.5'
    end
    
    # SideMenu Extensions
    sp.subspec 'SideMenu' do |spp|
      spp.source_files  = 'Decele/Classes/Components/SideMenu/**/*', 'Decele/Classes/Shared/**/*'
      spp.dependency 'SideMenu', '~> 6.5.0'
    end
    
    # TextField Extensions
    sp.subspec 'TextField' do |spp|
      spp.source_files  = 'Decele/Classes/Components/TextField/**/*', 'Decele/Classes/Shared/**/*'
    end
    
    # TextField Extensions
    sp.subspec 'TextField' do |spp|
      spp.source_files  = 'Decele/Classes/Components/TextField/**/*', 'Decele/Classes/Shared/**/*'
    end
  end

  s.frameworks = 'UIKit'
end
