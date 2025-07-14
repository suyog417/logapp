# Desk Alerts

Desk-Alert is a comprehensive mobile application designed for student academic management, built using Flutter, Firebase, and Dart. The app serves as a centralized platform that helps students organize their academic life by providing timetable management and announcement systems.

# Desk-Alert

## Tech Stack

### Frontend
- **Flutter** - Cross-platform mobile app development framework
- **Dart** - Programming language for Flutter development

### Backend & Database
- **Firebase** - Backend-as-a-Service platform
  - Firebase Authentication - User authentication and authorization
  - Cloud Firestore - NoSQL database for real-time data storage
  - Firebase Cloud Messaging - Push notifications
  - Firebase Storage - File storage for media content

### Development Tools
- **Android Studio** / **VS Code** - IDE for development
- **Git** - Version control system
- **GitHub** - Code repository and collaboration

### Key Features
- 📅 **Timetable Management** - Organized class scheduling
- 📢 **Announcement System** - Real-time academic updates
- 💬 **Direct Messaging** - Student-faculty communication
- 🔐 **User Authentication** - Secure login system
- 📱 **Cross-platform** - Android and iOS compatibility
- 🚫 **Distraction-free** - Academic-focused interface

## Setup Instructions

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK (comes with Flutter)
- Android Studio or VS Code
- Git
- Firebase account

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/suyogbhoye/desk-alert.git
   cd desk-alert
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a new project in [Firebase Console](https://console.firebase.google.com/)
   - Add Android/iOS app to your Firebase project
   - Download `google-services.json` (Android) and place it in `android/app/`
   - Download `GoogleService-Info.plist` (iOS) and place it in `ios/Runner/`
   - Enable Authentication, Firestore, and Storage in Firebase Console

4. **Configure Firebase Authentication**
   - Go to Firebase Console → Authentication → Sign-in method
   - Enable Email/Password authentication
   - Configure other sign-in providers if needed

5. **Set up Firestore Database**
   - Go to Firebase Console → Firestore Database
   - Create database in production mode
   - Set up security rules as needed

6. **Run the application**
   ```bash
   # Check connected devices
   flutter devices
   
   # Run on connected device/emulator
   flutter run
   ```

7. **Build for production**
   ```bash
   # For Android
   flutter build apk --release
   
   # For iOS
   flutter build ios --release
   ```

### Additional Configuration

- Update `pubspec.yaml` with your app name and version
- Configure app icons using `flutter_launcher_icons` package
- Set up push notifications if using Firebase Cloud Messaging
- Configure app permissions in `android/app/src/main/AndroidManifest.xml`

### Troubleshooting

- Run `flutter doctor` to check for any setup issues
- Ensure all Firebase configuration files are properly placed
- Check Flutter and Dart SDK versions for compatibility
- Clear cache with `flutter clean` if facing build issues
