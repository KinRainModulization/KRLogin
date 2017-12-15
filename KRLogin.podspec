Pod::Spec.new do |s|
s.name         = "KRLogin"
s.version      = "0.0.1"
s.summary      = "KRLogin"
s.description  = <<-DESC
轻雨登录模块私有库
DESC

s.homepage     = "https://github.com/KinRainModulization/KRLogin.git"
# s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
s.license      = "MIT"                #开源协议
s.author       = { "linyi31" => "linyi@jd.com" }

s.prefix_header_file = "KRLogin/Pods/KRPublishLibrary/KRPublishLibrary/KRPublishLibrary/PrefixHeader.pch"

s.source       = { :git => "https://github.com/KinRainModulization/KRLogin.git" }
#s.source      = { :git => "https://github.com/KinRainModulization/KRLogin.git", :tag => s.version.to_s }

s.platform     = :ios, "9.0"
s.requires_arc = true

s.source_files = "KRLogin/KRLogin/Classes/**/*.{h,m}"

s.dependency "KRPublishLibrary"

end
