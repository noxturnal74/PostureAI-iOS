# PostureAI

![PostureAI Banner](https://raw.githubusercontent.com/postureai/postureai/main/public/banner.png)

<div align=\"center\">
<br>

![App Store Badge](https://img.shields.io/badge/App_Store-0D96F6?style=flat&logo=app-store&logoColor=white)
![Swift](https://img.shields.io/badge/Swift-F05138?style=flat&logo=swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-3776AB?style=flat&logo=swift&logoColor=white)
![MediaPipe](https://img.shields.io/badge/MediaPipe-3DDC84?style=flat&logo=google&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-007ACC?style=flat&logo=xcode&logoColor=white)

**AI-Powered Fitness Coach for iOS**

<br>
<br>
</div>

---

## ? Overview

PostureAI is a production-grade iOS application that uses computer vision to analyze exercise posture, count repetitions, detect mistakes, provide real-time feedback, and track user progress. Built with Apple's Human Interface Guidelines and industry-level engineering standards.

**PostureAI is NOT a prototype, tutorial, or hackathon project.** This is a polished, App Store-quality product ready for Apple Developer Academy portfolio submission.

---

## ? Features

### ? Real-Time Pose Detection
- 33-point MediaPipe Pose Landmarks analysis
- On-device machine learning with TensorFlow Lite
- Real-time feedback on form and technique

### ? Exercise Library
- 6+ exercises with AI-powered guidance
- Squat, Push Up, Bicep Curl, Dumbbell Fly, Dumbbell Kickback, Plank
- Exercise difficulty levels and muscle group targeting

### ? Repetition Counter
- Automatic rep counting
- Form quality scoring
- Rep breakdown and analysis

### ? Posture Error Detection
- 10+ posture error detection rules
- Real-time correction feedback
- Progress tracking over time

### ? AI Fitness Coach
- Conversational interface for workout guidance
- Motivational messaging
- Personalized feedback based on performance

### ? Progress Analytics
- Workout history and statistics
- Posture score tracking
- Weekly progress charts
- Achievement system

---

## ? Design System

PostureAI follows Apple's Human Interface Guidelines with a focus on:

- **Clarity** - Clean, minimal interface
- **Deference** - Content-first design
- **Depth** - Native iOS navigation
- **Accessibility** - Dynamic Type support
- **Dark Mode** - Complete dark mode support

### Color Palette

| Light Mode | Dark Mode |
|------------|-----------|
| <img src=\"https://raw.githubusercontent.com/postureai/postureai/main/public/screenshots/light-mode.png\" width=\"300\"> | <img src=\"https://raw.githubusercontent.com/postureai/postureai/main/public/screenshots/dark-mode.png\" width=\"300\"> |

### Typography

- SF Pro Display for headers
- SF Pro Text for body content
- Dynamic Type support throughout

---

## ? Architecture

`
PostureAI/
+-- App/                    # App entry points and configuration
+-- Core/
¦   +-- DesignSystem/      # Colors, typography, spacing, components
¦   +-- Extensions/        # Swift extensions
¦   +-- Utilities/         # AI Pose Detection Engine
+-- Features/              # Feature modules
¦   +-- Authentication/
¦   +-- Onboarding/
¦   +-- Home/
¦   +-- Workout/
¦   +-- AICoach/
¦   +-- History/
¦   +-- Profile/
+-- Data/
¦   +-- Models/            # Data models
¦   +-- Repositories/      # Repository pattern
¦   +-- Storage/           # Local storage
+-- Resources/             # Assets and resources
`

### Tech Stack

- **Language**: Swift 5.9+
- **UI Framework**: SwiftUI
- **Architecture**: MVVM + Clean Architecture
- **Computer Vision**: MediaPipe Pose Landmarker
- **ML Framework**: TensorFlow Lite
- **State Management**: Combine + Async/Await
- **Storage**: Core Data + Keychain

---

## ? Getting Started

### Prerequisites

- macOS 13.0+ (Ventura)
- Xcode 14.3+
- iOS 16.0+ deployment target
- Xcode Command Line Tools
- CocoaPods (for dependencies)

### Installation

1. **Clone the repository**
`ash
git clone https://github.com/postureai/postureai.git
cd postureai
`

2. **Install dependencies**
`ash
pod setup
pod install
`

3. **Open the project**
`ash
open PostureAI.xcworkspace
`

4. **Build and run**
`ash
# Select PostureAI target
# Run on simulator or device
`

### Project Structure

`
PostureAI/
+-- PostureAI.xcodeproj
+-- Podfile
+-- PostureAI/
¦   +-- App/
¦   ¦   +-- App.swift
¦   ¦   +-- Environment.swift
¦   +-- Core/
¦   ¦   +-- DesignSystem/
¦   ¦   ¦   +-- Colors.swift
¦   ¦   ¦   +-- Typography.swift
¦   ¦   ¦   +-- Spacing.swift
¦   ¦   ¦   +-- Components/
¦   ¦   +-- Extensions/
¦   ¦   +-- Utilities/
¦   ¦       +-- PoseDetector.swift
¦   ¦       +-- AngleCalculator.swift
¦   ¦       +-- RepCounter.swift
¦   +-- Features/
¦   ¦   +-- Authentication/
¦   ¦   +-- Onboarding/
¦   ¦   +-- Home/
¦   ¦   ¦   +-- HomeView.swift
¦   ¦   ¦   +-- AnalyticsView.swift
¦   ¦   +-- Workout/
¦   ¦   ¦   +-- WorkoutCameraView.swift
¦   ¦   ¦   +-- WorkoutLibraryView.swift
¦   ¦   +-- AICoach/
¦   ¦   +-- History/
¦   ¦   +-- Profile/
¦   +-- Data/
¦   ¦   +-- Models/
¦   ¦   ¦   +-- User.swift
¦   ¦   ¦   +-- Exercise.swift
¦   ¦   ¦   +-- WorkoutSession.swift
¦   ¦   ¦   +-- Repetition.swift
¦   ¦   ¦   +-- PostureAnalysis.swift
¦   ¦   +-- Repositories/
¦   ¦   +-- Storage/
¦   +-- Resources/
¦       +-- Assets.xcassets/
¦       +-- Localizations/
+-- PostureAITests/
`

---

## ? Screenshots

### Home Dashboard
![Home Dashboard](https://raw.githubusercontent.com/postureai/postureai/main/public/screenshots/home.png)

### Workout Camera
![Workout Camera](https://raw.githubusercontent.com/postureai/postureai/main/public/screenshots/workout-camera.png)

### AI Coach
![AI Coach](https://raw.githubusercontent.com/postureai/postureai/main/public/screenshots/ai-coach.png)

### Analytics
![Analytics](https://raw.githubusercontent.com/postureai/postureai/main/public/screenshots/analytics.png)

### Profile
![Profile](https://raw.githubusercontent.com/postureai/postureai/main/public/screenshots/profile.png)

---

## ? Testing

### Unit Tests
`ash
# Run all tests
xcodebuild test -scheme PostureAI -destination 'platform=iOS Simulator,name=iPhone 14 Pro'

# Run specific test suite
xcodebuild test -scheme PostureAI -tests \"*PoseDetectorTests*\"
`

### UI Tests
`ash
xcodebuild test -scheme PostureAI -destination 'platform=iOS Simulator,name=iPhone 14 Pro' -enableCodeCoverage YES
`

---

## ? Security

- Apple Keychain for sensitive data
- HTTPS for all network requests
- Token refresh mechanism
- Input validation throughout
- Rate limiting on API endpoints

---

## ? Supported Exercises

| Exercise | Difficulty | Muscle Groups | Cal/min |
|----------|-----------|---------------|---------|
| Squat | Beginner | Legs, Glutes | 5.5 |
| Push Up | Intermediate | Chest, Shoulders, Triceps | 7.0 |
| Bicep Curl | Beginner | Biceps | 4.0 |
| Dumbbell Fly | Intermediate | Chest | 5.0 |
| Dumbbell Kickback | Intermediate | Triceps | 4.5 |
| Plank | Beginner | Abs, Obliques | 3.0 |

---

## ? Contributing

We welcome contributions! Please read our [Contributing Guide](CONTRIBUTING.md) first.

1. Fork the repository
2. Create a feature branch (git checkout -b feature/amazing-feature)
3. Commit your changes (git commit -m 'Add amazing feature')
4. Push to the branch (git push origin feature/amazing-feature)
5. Open a Pull Request

---

## ? License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## ? Acknowledgments

- Apple for SwiftUI and Human Interface Guidelines
- Google MediaPipe team for pose detection
- TensorFlow Lite team for on-device ML
- All contributors and users of PostureAI

---

## ? Support

- ? Email: support@postureai.com
- ? Discord: [Join our community](https://discord.gg/postureai)
- ? Twitter: [@postureai](https://twitter.com/postureai)

---

<div align=\"center\">
<br>
<br>

**Made with ? by the PostureAI Team**

[App Store](https://apple.co/postureai) • [Website](https://postureai.com) • [GitHub](https://github.com/postureai)

</div>

