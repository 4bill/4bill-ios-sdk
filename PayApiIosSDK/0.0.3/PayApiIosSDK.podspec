
Pod::Spec.new do |spec|

  spec.name               = "PayApiIosSDK"
  spec.version            = "0.0.3"
  spec.summary            = "PayApiIosSDK is a framework which provides 4billio payment services implementation to be used in mobile apps"

  spec.description        = "PayApiIosSDK is a framework which provides 4billio payment services implementation to be used in mobile apps"

  spec.homepage           = "https://docs.4bill.io/"
  spec.license            = { :type => "MIT", :file => "FILE_LICENSE" }
  spec.author             = { "Yelyzaveta" => "kartcevayelyzaveta@gmail.com" }
  spec.platform           = :ios, "13.0"
  spec.swift_version      = "5.0"
  spec.source             = { :git => 'https://github.com/4bill/4bill-ios-sdk.git', :tag => spec.version.to_s }

  spec.source_files = "pay-api-ios-sdk/**/*.{swift}"
  spec.resource_bundles = {
    'pay-api-ios-sdk' => ['pay-api-ios-sdk/**/*.{storyboard}', 'pay-api-ios-sdk/UI/Xibs/*.{xib}', 'pay-api-ios-sdk/*.xcassets', 'pay-api-ios-sdk/Resources/Fonts/**/*.otf', 'pay-api-ios-sdk/Resources/Fonts/**/*.ttf']
  }
  
  spec.dependency 'Alamofire'
  spec.dependency 'QuickLayout'
  spec.dependency 'Marshal'
  spec.dependency 'Promises'

  
  spec.xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

end
