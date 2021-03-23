#
# Be sure to run `pod lib lint DrunkenBishop.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DrunkenBishop'
  s.version          = '0.2.1'
  s.summary          = 'Visual fingerprinting algorithm for visualizing key fingerprints implemented as a SwiftUI View'
  s.description      = <<-DESC
  The Drunken Bishop algorithm is a visual fingerprinting algorithm originally
implemented by OpenSSH for visualizing key fingerprints. This package implements this visualization as a Swiftui View
                       DESC
  s.homepage         = 'https://github.com/ioioapp/DrunkenBishopSwiftUI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ljcamargo' => 'luis.javier@ioio.mx' }
  s.source           = { :git => 'https://github.com/ioioapp/DrunkenBishopSwiftUI.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ioiomexico'

  s.ios.deployment_target = '13.0'
  s.swift_version = ['5.0', '5.1', '5.2', '5.3', '5.4']
  s.source_files = 'Sources/DrunkenBishop/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DrunkenBishop' => ['DrunkenBishop/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
