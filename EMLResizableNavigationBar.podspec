Pod::Spec.new do |s|
  s.name             = "EMLResizableNavigationBar"
  s.version          = "1.0"
  s.summary          = "Hides UINavigationBar when scrolling a UIScrollView."
  s.description      = <<-DESC
                       Includes different ways to vanish/shrimp the title and bar buttons.
                       DESC
  s.homepage         = "https://github.com/enricmacias/EMLResizableNavigationBar.git"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "enric.macias.lopez" => "enric.macias.lopez@glpgs.com" }
  s.source           = { :git => "https://github.com/enricmacias/EMLResizableNavigationBar.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'EMLResizableNavigationBar' => ['Pod/Assets/*.png']
  }

  s.frameworks = 'UIKit'
end
