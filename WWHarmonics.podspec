#
# Be sure to run `pod lib lint WWHarmonics.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "WWHarmonics"
  s.version          = "0.1.0"
  s.summary          = "A library used to simply the calulations for musical notation"
  s.description      = <<-DESC
                       This library gives the user the ability to create musical scales, notes, and other constructs using a simple API.
                       DESC
  s.homepage         = "https://github.com/willseward/WWHarmonics.git"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'GPAL GNU v3'
  s.author           = { "Wills Ward" => "wward@warddevelopment.co" }
  s.source           = { :git => "https://github.com/willseward/WWHarmonics.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'WWHarmonics' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
