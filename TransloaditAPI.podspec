Pod::Spec.new do |s|
  s.name         = "TransloaditAPI"
  s.version      = "1.0.0"
  s.summary      = "The official iOS SDK for the Transloadit API"
  s.description  = <<-DESC
                    This is the official iOS SDK for the transloadit.com API.

                    It allows you to easily use Transloadit services in your iPhone or iPad applications.
                   DESC
  s.homepage     = "https://transloadit.com"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors             = { "Tim Koschuetzki" => "tim@transloadit.com", "Mark Robert Masterson" => "Mark@Masterson.io"  }
  s.social_media_url   = "https://twitter.com/transloadit"
  s.platform     = :ios
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/transloadit/ios-sdk.git", :tag => "1.0.0" }
  s.source_files  = "TransloaditLib/**/*.{h,m}"
  s.requires_arc = true
end
