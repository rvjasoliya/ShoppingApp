# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ShoppingApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ShoppingApp

  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'MBProgressHUD'
  pod 'SDWebImage'
  pod 'FSPagerView'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
