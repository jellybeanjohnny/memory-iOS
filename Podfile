# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

use_frameworks!

def common_pods
  pod 'Alamofire', '~> 4.4'
  pod 'SwiftyJSON'
end

target 'memory-extension' do
  # Pods for memory-extension

end

target 'memory-iOS' do
  # Pods for memory-iOS
  common_pods


end

target 'SharedCode' do  
  # Pods for SharedCode
  common_pods

end

abstract_target 'Tests' do
  target 'SharedCodeTests'

    pod 'Quick'
    pod 'Nimble'
end

