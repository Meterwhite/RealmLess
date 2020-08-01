Pod::Spec.new do |s|
  s.name         = "RealmLess"
  s.version      = "2.0.2"
  s.summary      = "Realm write extension.Prefect solution to reduce realm (objc) tedious write commit coding."
  s.homepage     = "https://github.com/Meterwhite/RealmLess"
  s.license      = "MIT"
  s.author       = { "Meterwhite" => "meterwhite@outlook.com" }
  s.source        = { :git => "https://github.com/Meterwhite/RealmLess.git", :tag => s.version.to_s }
  s.source_files  = "RealmLess/**/*.{h,m}"
  s.requires_arc  = true
  
  s.ios.deployment_target = "7.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  
  s.dependency "Realm"
end
