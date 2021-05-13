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
  spec.source           = { :git => 'https://github.com/4bill/4bill-ios-sdk.git', :tag => spec.version.to_s }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  # spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  # spec.exclude_files = "Classes/Exclude"

  # spec.source_files = "pay-api-ios-sdk/**/*.swift", "pay-api-ios-sdk/**/**/*.swift", "pay-api-ios-sdk/**/**/**/*.swift", "pay-api-ios-sdk/**/**/**/**/*.swift", "pay-api-ios-sdk/**/**/**/**/**/*.swift"
  # spec.source_files = "pay-api-ios-sdk/**/*"
  
  spec.dependency 'Alamofire'
  spec.dependency 'QuickLayout'
  spec.dependency 'Marshal'
  spec.dependency 'Promises'
  spec.dependency 'Bindy'

  spec.source_files = "pay-api-ios-sdk/**/*.{swift}"
  spec.xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

end
