#
# Be sure to run `pod lib lint StaticLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'StaticLib'
  s.version          = '0.1.0'
  s.summary          = 'StaticLib is library for project.'
  s.description      = 'StaticLib is base library for projects'
  s.homepage         = 'https://github.com/novacom34/StaticLib'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Roma Novakov' => 'novacom34@gmail.com' }
  s.source           = { :git => 'https://github.com/novacom34/StaticLib.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'

  s.source_files = 'StaticLib/Classes/**/*'
  
  # s.resource_bundles = {
  #   'StaticLib' => ['StaticLib/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
