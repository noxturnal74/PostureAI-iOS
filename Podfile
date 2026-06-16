# Podfile for PostureAI

platform :ios, '16.0'
use_frameworks!

target 'PostureAI' do
  # MediaPipe for pose detection
  pod 'MediaPipeiOS/PoseLandmarker', '~> 0.10.10'
  
  # TensorFlow Lite
  pod 'TensorFlowLiteSwift', '~> 2.12.0'
  
  # UI Frameworks
  pod 'SDWebImage', '~> 5.18'
  
  # Utilities
  pod 'KeychainAccess', '~> 4.2'
  
  # Testing
  target 'PostureAITests' do
    inherit! :search_paths
    pod 'Nimble', '~> 9.2'
    pod 'Quick', '~> 5.1'
  end
end
