Pod::Spec.new do |s|

  s.name          = "SPStorkController"
  s.version       = "1.8.5"
  s.summary       = "Very similar to the controllers displayed in Apple Music, Podcasts and Mail Apple's applications."
  s.homepage      = "https://github.com/ivanvorobei/SPStorkController"
  s.source        = { :git => "https://github.com/ivanvorobei/SPStorkController.git", :tag => s.version }
  s.license       = { :type => "MIT", :file => "LICENSE" }
  
  s.author        = { "Ivan Vorobei" => "hello@ivanvorobei.by" }
  
  s.platform      = :ios
  s.ios.framework = 'UIKit'
  s.swift_version = ['4.2', '5.0']
  s.ios.deployment_target = "10.0"

  s.source_files  = "Sources/SPStorkController/**/*.swift"

end