# Uncomment this line to define a global platform for your project
# platform :

target 'Brownees World' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # Pods for Brownee's World
  pod 'SwiftyJSON'
  pod 'Alamofire'
  pod 'JSSAlertView'
  pod 'paper-onboarding'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = ‘4.0’
    end
  end
end

