Pod::Spec.new do |s|
  s.name             = "T8VoiceRecordButton"
  s.version          = "1.0.1"
  s.summary          = "A voice button used on iOS."
  s.description      = <<-DESC
                       It is a voice button used on iOS, which implement by Objective-C.
                       DESC
  s.homepage         = "https://github.com/zhangqippp/T8VoiceRecordButton"
  # s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "zhangqippp" => "zhangqi@t8.io" }
  s.source           = { :git => "https://github.com/zhangqippp/T8VoiceRecordButton.git", :tag => s.version.to_s }
  # s.social_media_url = "https://twitter.com/NAME"

  s.platform     = :ios, "7.0"
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  s.requires_arc = true

  s.source_files = "T8VoiceRecordButton/*"
  # s.resources = "T8VoiceRecordButton/*"

  # s.ios.exclude_files = "Classes/osx"
  # s.osx.exclude_files = "Classes/ios"
  s.public_header_files = "Classes/**/*.h"
  s.frameworks = "Foundation", "CoreGraphics", "UIKit"
end
