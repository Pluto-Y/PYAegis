Pod::Spec.new do |s|
  s.name                = "PYAegis"
  s.version             = "0.0.1"
  s.summary             = "A daemon framework to protect some crash of Cocoa."
  s.homepage            = "https://github.com/Pluto-Y/PYAegis"
  s.license             = { :type => "MIT", :file => 'LICENSE.md' }
  s.author              = { "PlutoY" => "kuaileainits@163.com" }
  s.platform            = :ios, "8.0"
  s.source              = { :git => "https://github.com/Pluto-Y/PYAegis.git", :tag => s.version}
  s.source_files        = "PYAegis/**/*.{h,m}"
  s.requires_arc        = true
  s.frameworks          = 'UIKit'

end
