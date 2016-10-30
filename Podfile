# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'Tell Me' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Tell Me
  pod 'SwiftyJSON', :git => 'https://github.com/acegreen/SwiftyJSON.git', :branch => 'swift3'
  pod 'Alamofire', '~> 4.0'
  pod 'Kingfisher', '~> 3.0'
  pod 'Realm', git: 'https://github.com/realm/realm-cocoa.git', branch: 'master', :submodules => true
  pod 'RealmSwift', :git => 'https://github.com/realm/realm-cocoa.git', :branch => 'master', :submodules => true

  target 'Tell MeTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
