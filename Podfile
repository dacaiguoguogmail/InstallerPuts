# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'InstallerPuts' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  use_frameworks!
  pod 'AFNetworking'
  pod 'SDWebImage'
  require 'json'
  # Pods for InstallerPuts
  post_install do |installer|
    # puts installer.podfile.to_hash.to_json
    installer.aggregate_targets.each { |e| puts e.name }
    puts installer.pod_targets.last.name
    puts installer.presence.class
    # installer.to_yaml_properties.each { |e| puts e.methods }
  end
end
