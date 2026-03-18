# Mouvema - Event Management & Logistics Platform

A comprehensive mobile application platform built with Flutter, designed for drivers, individuals, and companies engaged in shipping, logistics, and event management. Mouvema streamlines operations with real-time tracking, intelligent dispatch, and user-friendly interfaces.

## Features

### 📱 Core Features
- **User Authentication**: Multi-method authentication (Email/Password, Google Sign-In, Facebook Login)
- **Real-time Mapping**: Interactive maps with marker popup support and geolocation services
- **Event Management**: Timeline-based event tracking and carousel views
- **Search Functionality**: Advanced search capabilities with filters
- **Navigation**: Smooth bottom navigation with animated transitions
- **Offline Support**: Local data storage with Hive
- **Push Notifications**: Firebase Cloud Messaging integration
- **Image Management**: Image picker and Firebase Storage support

### 🚀 Technical Highlights
- **State Management**: BLoC pattern for scalable state management
- **Clean Architecture**: Domain-Driven Design with clear separation of concerns
- **Cloud Integration**: Firebase (Auth, Firestore, Storage, Analytics)
- **Device Preview**: Built-in device preview for UI testing across multiple device sizes
- **Responsive UI**: Optimized for both Android and iOS platforms

## Project Structure

```
lib/
├── main.dart                 # Entry point
├── src/
│   ├── app.dart             # App configuration
│   ├── injector.dart        # Dependency injection setup
│   ├── config/              # App configuration
│   ├── core/                # Core utilities (failures, helpers)
│   ├── data/                # Data layer (models, repositories, data sources)
│   ├── domain/              # Domain layer (entities, use cases)
│   └── presentation/        # Presentation layer (screens, widgets)
```

## Prerequisites

- **Flutter**: 3.0.5 or higher
- **Dart**: 3.0.5 or higher
- **Android Studio** or **Xcode** for mobile development
- **Firebase Project**: Set up a Firebase project with the following services:
  - Authentication (Email, Google, Facebook)
  - Firestore
  - Storage
  - Cloud Messaging

## Installation & Setup

### 1. Clone the Repository
```bash
git clone [repository-url]
cd mouvema
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Configure Firebase
- Download your `google-services.json` (Android) and place it in `android/app/`
- Download your `GoogleService-Info.plist` (iOS) - already configured
- Run code generation for Firebase options:
```bash
flutter pub run build_runner build
```

### 4. Run the Application
```bash
# Development
flutter run

# With device preview enabled
flutter run --device-id windows  # or your device ID

# Release build
flutter build apk       # Android
flutter build ios       # iOS
```

## Key Dependencies

- **firebase_core** ^3.12.1 - Firebase initialization
- **firebase_auth** ^5.5.1 - User authentication
- **cloud_firestore** ^5.6.5 - Real-time database
- **firebase_storage** ^12.4.4 - Cloud file storage
- **flutter_bloc** ^8.1.3 - State management
- **flutter_map** ^5.0.0 - Interactive maps
- **hive_flutter** ^1.1.0 - Local data persistence
- **dartz** ^0.10.1 - Functional programming
- **get_it** ^7.6.0 - Service locator

## Configuration

### Environment Variables
Create a `.env` file in the project root for sensitive configurations (optional):
```
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_API_KEY=your_api_key
```

### Device Preview
Device preview is enabled by default in `main.dart`. To disable:
```dart
DevicePreview(
  enabled: false,  // Set to false for production
  ...
)
```

## Build & Deployment

### Android
```bash
# Build APK
flutter build apk

# Build App Bundle
flutter build appbundle
```

### iOS
```bash
# Build IPA
flutter build ios
```

## Testing

Run tests:
```bash
flutter test
```

## Contributing

1. Create a feature branch: `git checkout -b feature/your-feature`
2. Commit changes: `git commit -m 'Add your feature'`
3. Push to branch: `git push origin feature/your-feature`
4. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For issues, feature requests, or questions, please open an issue on the repository.

## Author

**Mouvema Development Team**

---

**Last Updated**: March 2026

