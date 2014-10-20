source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '7.0'

pod 'SocketRocket'

post_install do |installer|
   target = installer.project.targets.find { |t| t.to_s == "Pods" }
   if (target)
      target.build_configurations.each do |config|
         s = config.build_settings['FRAMEWORK_SEARCH_PATHS']
         s = [ '$(inherited)' ] if s == nil;
         s.push('$(PLATFORM_DIR)/Developer/Library/Frameworks')
         config.build_settings['FRAMEWORK_SEARCH_PATHS'] = s
      end
      else
      puts "WARNING: Pods target not found"
   end
end
