#
# Be sure to run `pod lib lint BillboardSwiftLibrary.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BillboardSwiftLibrary'
  s.version          = '0.1.2'
  s.summary          = 'Swift API for downloading Billboard charts'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'BillboardSwiftLibrary is a Swift API for accessing music charts from Billboard.com.'

  s.homepage         = 'https://github.com/Fitzafful/BillboardSwiftLibrary'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Fitzafful' => 'fitzafful@gmail.com' }
  s.source           = { :git => 'https://github.com/Fitzafful/BillboardSwiftLibrary.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Bra_Gerald'

  s.swift_version = '4.0'
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'

  s.source_files = 'Sources/**/*.{h,m,swift}'
  
  # s.resource_bundles = {
  #   'BillboardSwiftLibrary' => ['BillboardSwiftLibrary/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SwiftSoup', '~> 1.7.4'
end
