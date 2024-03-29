Pod::Spec.new do |s|
  s.name             = "apploggerSDK"
  s.version          = "0.3.3"
  s.summary          = "Log your app to the web"
  s.homepage         = "http://applogger.io"
  s.documentation_url= 'https://github.com/applogger/applogger-ios-sdk'
  s.license          = 'MIT'
  s.author           = { "io" => "info@applogger.io" }

  s.source   = { :git => 'https://github.com/applogger/applogger-ios-sdk.git',
                 :tag => "#{s.version}", :submodules => true }
  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.requires_arc = true
  s.ios.frameworks     = %w{CFNetwork Security}
  s.osx.frameworks     = %w{CoreServices Security}
  s.osx.compiler_flags = '-Wno-format'
  s.libraries          = "icucore"
  
  s.source_files = 'Classes/iOS/*.{h,m}', "socket.io/*.{h,m}", "socket.io/submodules/socket-rocket/SocketRocket/*.{h,m,c}"

  s.dependency 'CocoaAsyncSocket', '~> 7.3.4'
  s.dependency 'CocoaLumberjack'

  s.prepare_command = <<-CMD
			git submodule update --init --recursive
                  CMD
                  
  s.prefix_header_contents = '#define NSLog(...) internalLog(__VA_ARGS__);
  #ifdef __OBJC__
  #import "ioApploggerHelper.h"
  #endif'
end
