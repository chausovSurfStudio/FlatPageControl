Pod::Spec.new do |s|

  s.name        = "FlatPageControl"
  s.version     = "0.0.1"
  s.summary     = "Some kind of UIPageControl, which allow you to show endless count if page items and change it with animation"
  s.homepage    = "https://github.com/chausovSurfStudio/FlatPageControl"
  s.license     = "MIT"

  s.author      = { "Александр Чаусов" => "chausov@surfstudio.ru" }
  s.source      = { :git => "https://github.com/chausovSurfStudio/FlatPageControl.git", :tag => s.version }

  s.ios.deployment_target = '10.0'
  s.source_files          = "Source/**/*.swift"
  s.framework             = "UIKit"
  s.swift_version         = '4.2'

end
