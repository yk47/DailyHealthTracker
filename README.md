# Daily Health Tracker 📱💪

A comprehensive Flutter application built with GetX for state management, featuring Firebase Google Sign-In, health data visualization, activity tracking, awesome notifications, and modern UI animations.

[![Flutter Version](https://img.shields.io/badge/Flutter-3.7.0+-blue.svg)](https://flutter.dev/)
[![Dart Version](https://img.shields.io/badge/Dart-3.0.0+-blue.svg)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## ✨ Features

### 🔑 Authentication & Security
- **Firebase Google Sign-In Integration**: Secure authentication with Google accounts
- **Profile Management**: Display user profile picture, name, and email
- **Demo Mode**: Fallback demo account for testing and development
- **Automatic Session Management**: Persistent login state across app restarts
- **Multi-tier Authentication**: Firebase + Google Sign-In with fallback mechanisms

### 📊 Health Data Visualization
- **Interactive Charts**: 7-day and monthly health data visualization using fl_chart
- **Multiple Metrics**: Steps, calories burned, and active minutes tracking
- **Statistics Overview**: Average calculations and totals with trend analysis
- **Period Selection**: Switch between weekly and monthly views with smooth transitions
- **Responsive Design**: Charts adapt to different screen sizes

### 📝 Activity Logs & API Integration
- **REST API Integration**: Fetches activity data from JSONPlaceholder API
- **Infinite Scroll**: Lazy loading with pagination for seamless browsing
- **Activity Categories**: Different icons and colors for various activity types
- **Detailed View**: Modal bottom sheet with full activity information
- **Real-time Updates**: Pull-to-refresh functionality
- **Error Handling**: Comprehensive error management with user feedback

### ⏰ Timer Functionality
- **10-Minute Countdown**: Activity reminder timer with visual progress
- **Circular Progress Indicator**: Beautiful animated progress display with percentage
- **Timer Controls**: Start, pause, resume, and reset functionality
- **Auto-Refresh**: Automatic reset after completion with notifications
- **Responsive Layout**: Overflow-safe design for all screen sizes

### 🎨 Modern UI & Animations
- **Awesome Notifications**: Top-positioned beautiful snack bars with awesome_snackbar_content
- **Fade-in Animations**: Smooth entrance animations for cards and elements
- **Scale Animations**: Interactive button press effects
- **Staggered Animations**: Sequential loading animations
- **Material Design 3**: Modern and clean interface with proper theming
- **Dark Mode Support**: System-based theme switching
- **Custom Widgets**: Reusable animated components

### 🏗️ Architecture & State Management
- **MVC Pattern**: Clean separation of concerns with proper layering
- **GetX State Management**: Reactive state management and dependency injection
- **GetX Navigation**: Declarative routing system with proper route management
- **Service Layer**: Separate services for API calls, authentication, and data management
- **Error Boundaries**: Comprehensive error handling throughout the app

## 🛠️ Tech Stack

- **Framework**: Flutter 3.7.0+ with Material Design 3
- **State Management**: GetX 4.6.5 (Reactive programming, DI, Navigation)
- **Backend Services**: Firebase Core 2.24.2 + Firebase Auth 4.15.3
- **Authentication**: Google Sign-In 6.2.1 with multi-tier fallback
- **Charts & Visualization**: fl_chart 0.66.2 for interactive graphs
- **HTTP Client**: http 1.2.1 for REST API integration
- **Notifications**: awesome_snackbar_content 0.1.6 for beautiful alerts
- **Date Formatting**: intl 0.19.0 for internationalization
- **Build Tools**: Android Gradle Plugin, Xcode for iOS



### Authentication Flow
- **Login Screen**: Gradient background with Google Sign-In button
- **Profile Management**: User avatar, name, email with authentication badges
- **Demo Mode**: Fallback authentication for development and testing

### Main Features
- **Dashboard**: Welcome card, quick stats, navigation grid
- **Health Graphs**: Interactive line charts with period selection
- **Activity Logs**: Infinite scroll list with category icons
- **Timer Interface**: Circular progress with responsive controls
- **Notifications**: Top-positioned awesome snack bars

### UI Highlights
- **Material Design 3**: Modern card layouts and typography
- **Dark Mode**: System-responsive theme switching
- **Animations**: Smooth transitions and micro-interactions
- **Responsive Design**: Adaptive layouts for all screen sizes

## 📁 Project Structure

```
lib/
├── controllers/          # GetX Controllers for state management
│   ├── auth_controller.dart
│   ├── dashboard_controller.dart
│   ├── graph_controller.dart
│   ├── activity_controller.dart
│   ├── timer_controller.dart
│   └── profile_controller.dart
├── models/              # Data models
│   ├── user.dart
│   ├── activity_log.dart
│   └── health_data.dart
├── services/            # Service layer for API and authentication
│   ├── auth_service.dart
│   ├── api_service.dart
│   └── mock_data_service.dart
├── views/               # UI screens
│   ├── login_view.dart
│   ├── dashboard_view.dart
│   ├── graph_view.dart
│   ├── activity_logs_view.dart
│   ├── timer_view.dart
│   └── profile_view.dart
├── widgets/             # Reusable UI components
│   ├── animated_card.dart
│   ├── animated_button.dart
│   └── loading_widget.dart
├── routes/              # Navigation and routing
│   ├── app_routes.dart
│   └── app_pages.dart
├── utils/               # Utilities and helpers
│   ├── constants.dart
│   └── helpers.dart
└── main.dart           # App entry point
```

## 🚀 Getting Started

### 📋 Prerequisites
- **Flutter SDK**: 3.7.0 or higher ([Install Flutter](https://docs.flutter.dev/get-started/install))
- **Dart SDK**: 3.0.0 or higher (included with Flutter)
- **Development Environment**: Android Studio, VS Code, or IntelliJ IDEA
- **Git**: For version control ([Install Git](https://git-scm.com/downloads))
- **Google Account**: For Firebase and Google Sign-In setup

### 🔧 Installation & Setup

#### 1. Clone the Repository
```bash
git clone https://github.com/yk47/DailyHealthTracker.git
cd DailyHealthTracker
```

#### 2. Install Flutter Dependencies
```bash
# Get all required packages
flutter pub get

# Verify Flutter installation
flutter doctor
```

#### 3. Firebase Configuration (Required for Google Sign-In)

**Step 3.1: Create Firebase Project**
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" and follow the setup wizard
3. Enable Google Analytics (optional but recommended)

**Step 3.2: Configure Android App**
1. Click "Add app" and select Android
2. Enter package name: `com.example.daily_helth_tracker`
3. Download `google-services.json`
4. Place the file in `android/app/` directory

**Step 3.3: Configure Authentication**
1. Go to Authentication → Sign-in method
2. Enable "Google" provider
3. Add your project's OAuth 2.0 client IDs

**Step 3.4: Get SHA-1 Fingerprint (Critical for Android)**
```bash
# Navigate to android folder and get debug SHA-1
cd android
./gradlew signingReport

# Copy the SHA1 fingerprint from the debug key
# Example: SHA1: 12:34:56:78:90:AB:CD:EF:12:34:56:78:90:AB:CD:EF:12:34:56:78
```

**Step 3.5: Add SHA-1 to Firebase**
1. Go to Project Settings → Your Android App
2. Click "Add fingerprint"
3. Paste the SHA-1 fingerprint
4. Download the updated `google-services.json`
5. Replace the old file in `android/app/`

#### 4. iOS Configuration (Optional)
1. In Firebase Console, add iOS app
2. Bundle ID: `com.example.dailyHelthTracker`
3. Download `GoogleService-Info.plist`
4. Add to `ios/Runner/` in Xcode

#### 5. Test the Setup
```bash
# Clean and rebuild
flutter clean
flutter pub get

# Run on device/emulator
flutter run

# For release build
flutter run --release
```

### 🔍 Troubleshooting Common Issues

#### Google Sign-In Error (ApiException: 10)
- **Cause**: Missing or incorrect SHA-1 fingerprint
- **Solution**: Follow Step 3.4 and 3.5 exactly
- **Verification**: Check Firebase Console → Project Settings → SHA fingerprints

#### Build Errors
```bash
# Clean everything and rebuild
flutter clean
cd android && ./gradlew clean && cd ..
flutter pub get
flutter run
```

#### Demo Mode
- If Google Sign-In fails, the app automatically switches to demo mode
- Demo mode allows testing all features without authentication
- Look for "Demo Mode" badge in the profile section



### 🎯 Additional Enhancements

#### User Experience
- **Responsive Design**: Overflow-safe layouts for all screen sizes
- **Loading States**: Comprehensive loading indicators and skeleton screens
- **Error Recovery**: Graceful error handling with user-friendly messages
- **Offline Support**: Demo mode fallback when authentication fails

#### Developer Experience
- **Clean Architecture**: Proper separation of concerns with MVC pattern
- **Type Safety**: Strong typing throughout the application
- **Documentation**: Comprehensive inline comments and README
- **Maintainability**: Modular code structure with reusable components

#### Performance
- **Optimized Builds**: Efficient widget rebuilds with GetX reactive programming
- **Memory Management**: Proper disposal of controllers and resources
- **Network Efficiency**: Cached requests and optimized API calls
- **Animation Performance**: Smooth 60fps animations with proper optimization

## 🧪 Testing

### Manual Testing Checklist
- [ ] **Authentication Flow**: Google Sign-In → Profile Display → Sign Out
- [ ] **Demo Mode**: Fallback authentication when Google Sign-In fails
- [ ] **Navigation**: All routes working with GetX navigation
- [ ] **API Integration**: Activity logs loading with infinite scroll
- [ ] **Charts**: Interactive graphs with period switching
- [ ] **Timer**: Full countdown cycle with notifications
- [ ] **Animations**: Smooth transitions and micro-interactions
- [ ] **Theme Switching**: Dark/Light mode toggle
- [ ] **Notifications**: Awesome snack bars for all user actions
- [ ] **Error Handling**: Network errors, authentication failures

### Device Testing
- **Android**: Minimum API 21 (Android 5.0)
- **iOS**: Minimum iOS 11.0
- **Screen Sizes**: Phone, Tablet, Foldable devices
- **Orientations**: Portrait and Landscape modes

## 🤝 Contributing

### Development Workflow
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Standards
- Follow Flutter/Dart style guidelines
- Use GetX patterns for state management
- Write descriptive commit messages
- Add comments for complex logic
- Ensure responsive design principles



## 🙏 Acknowledgments

- **Flutter Team**: For the amazing framework
- **GetX Package**: For excellent state management
- **Firebase**: For authentication services
- **FL Chart**: For beautiful chart visualizations
- **Awesome SnackBar Content**: For enhanced notifications
- **Material Design**: For design system guidelines

## 📞 Contact & Support

- **Repository**: [DailyHealthTracker](https://github.com/yk47/DailyHealthTracker)
- **Issues**: [GitHub Issues](https://github.com/yk47/DailyHealthTracker/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yk47/DailyHealthTracker/discussions)

---



*This application demonstrates proficiency in Flutter development, state management, API integration, UI/UX design, Firebase services, and modern mobile app architecture patterns.*
