Pod::Spec.new do |s|
  s.name         = "Realm--"
  s.version      = "1.0.3"
  s.summary      = "Realm write extension.Prefect solution to reduce realm (objc) tedious write commit coding."
  s.homepage     = "https://github.com/Meterwhite/Realm--"
  s.license      = "MIT"
  s.author       = { "Meterwhite" => "meterwhite@outlook.com" }
  s.source        = { :git => "https://github.com/Meterwhite/Realm--.git", :tag => s.version.to_s }
  s.source_files  = "Realm--/**/*.{h,m}"
  s.requires_arc  = true
  
  s.ios.deployment_target = "7.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  
  s.dependency "Realm"
end
