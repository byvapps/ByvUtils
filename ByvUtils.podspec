#
# Be sure to run `pod lib lint ByvUtils.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ByvUtils'
  s.version          = '1.0.3'
  s.summary          = 'Utils for B&V Apps.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Help methods and extensions for iOS development
                       DESC

    s.homepage         = 'https://github.com/byvapps/ByvUtils'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Adrian' => 'adrian@byvapps.com' }
    s.source           = { :git => 'https://github.com/byvapps/ByvUtils.git', :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/byvapps'

    s.ios.deployment_target = '8.0'

    s.source_files = 'ByvUtils/Classes/**/*'
    s.requires_arc = true
end
