#
#  Be sure to run `pod spec lint PayApiIosSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "PayApiIosSDK"
  spec.version      = "0.0.1"
  spec.summary      = "PayApiIosSDK is a framework which provides 4billio payment services implementation to be used in mobile apps"

  spec.description  = "PayApiIosSDK is a framework which provides 4billio payment services implementation to be used in mobile apps"

  spec.homepage     = "https://docs.4bill.io/"
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  spec.author       = { "Yelyzaveta" => "kartcevayelyzaveta@gmail.com" }
  spec.platform     = :ios, "13.0"
  spec.swift_version = "5.0"

  #  When using multiple platforms
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  # spec.source       = { :http => 'file:' + __dir__ + "/" }
  spec.source           = { :git => 'https://github.com/4bill/4bill-ios-sdk', :tag => s.version.to_s }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  # spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  # spec.exclude_files = "Classes/Exclude"

  # spec.source_files = "pay-api-ios-sdk/**/*.swift", "pay-api-ios-sdk/**/**/*.swift", "pay-api-ios-sdk/**/**/**/*.swift", "pay-api-ios-sdk/**/**/**/**/*.swift", "pay-api-ios-sdk/**/**/**/**/**/*.swift"
  # spec.source_files = "pay-api-ios-sdk/**/*"
  spec.source_files = "pay-api-ios-sdk/**/*.{swift}"
  # spec.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # s.resource_bundles = {
  #    'Touchcard' => ['pay-api-ios-sdk/Assets/**/*']
  
  #  }
  # spec.resources = "pay-api-ios-sdk/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
  # spec.resources = ['pay-api-ios-sdk/UI/Screens/**/*.storyboard', 'pay-api-ios-sdk/UI/Views/**/*.xib', 'pay-api-ios-sdk/UI/Screens/Pay/Views/**/*.xib']
  # spec.resources = ['pay-api-ios-sdk/Resources/Fonts/**/*.tff', 'pay-api-ios-sdk/Resources/Fonts/**/*.otf', 'pay-api-ios-sdk/UI/Screens/**/*.storyboard', 'pay-api-ios-sdk/UI/Views/**/*.xib', 'pay-api-ios-sdk/UI/Screens/Pay/Views/**/*.xib']
  # s.resources = ['pay-api-ios-sdk/Resources/Fonts/**/*.storyboard', 'pay-api-ios-sdk/**/*.xib', 'pay-api-ios-sdk/Assets/**/*']


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
