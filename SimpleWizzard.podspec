#
# Be sure to run `pod lib lint SimpleWizzard.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SimpleWizzard'
  s.version          = '0.1.1'
  s.summary          = 'A library that helps the user to build a Stepper for its form or anything it wants.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'A library that helps the user to build a Stepper for its form or anything it wants. Giving it the power to change anything it wants.'

  s.homepage         = 'https://github.com/hborjaille/SimpleWizzard'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hborjaille' => 'higor.borjaille@gmail.com' }
  s.source           = { :git => 'https://github.com/hborjaille/SimpleWizzard.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'SimpleWizzard/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SimpleWizzard' => ['SimpleWizzard/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
