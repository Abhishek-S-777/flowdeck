# Collaborative Task Manager

A powerful Flutter application for collaborative task management with real-time synchronization, offline-first architecture, and Material 3 design.

## Features

### 🚀 Core Functionality
- **User Authentication** - Firebase Auth with email/password
- **Board Management** - Create, edit, and organize project boards
- **Task Management** - Full CRUD operations for tasks with status tracking
- **Real-time Collaboration** - Live updates across team members
- **Offline-first** - Works seamlessly without internet connection
- **Search & Filter** - Advanced search and filtering capabilities

### 🎨 UI/UX
- **Material 3 Design** - Modern, beautiful interface
- **Dark/Light Theme** - Automatic theme switching
- **Responsive Layout** - Works on all screen sizes
- **Smooth Animations** - Delightful user interactions
- **Empty States** - Intuitive placeholder content

### ⚡ Technical Features
- **MVVM Architecture** - Clean, maintainable code structure
- **Riverpod State Management** - Reactive state management
- **Offline Sync** - SQLite local storage with cloud sync
- **Type Safety** - Full Dart type safety with Freezed models
- **Error Handling** - Comprehensive error management
- **Testing Ready** - Unit and widget test infrastructure

## Architecture

### 📁 Project Structure
```
lib/
├── core/                    # Core app configuration
│   ├── config/             # App configuration
│   ├── constants/          # App-wide constants
│   ├── di/                 # Dependency injection
│   ├── routing/            # Navigation setup
│   └── theme/              # Theme configuration
├── data/                   # Data layer
│   ├── datasources/        # Local & remote data sources
│   ├── models/             # Data models (Freezed)
│   ├── repositories/       # Repository implementations
│   └── services/           # External services
├── domain/                 # Domain layer
│   └── repositories/       # Repository interfaces
└── presentation/           # Presentation layer
    ├── screens/            # UI screens
    ├── viewmodels/         # ViewModels (Riverpod)
    └── widgets/            # Reusable widgets
```

### 🏗️ Tech Stack
- **Flutter** - Cross-platform framework
- **Riverpod** - State management with providers
- **Drift** - Type-safe SQLite database
- **Firebase** - Backend services (Auth, Firestore, Messaging)
- **Freezed** - Immutable data classes
- **GoRouter** - Declarative routing
- **Dio** - HTTP client for REST APIs

## Setup Instructions

### Prerequisites
- Flutter SDK (>=3.10.0)
- Dart SDK (>=3.0.0)
- Firebase project setup
- Android Studio or VS Code

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/collaborative-task-manager.git
cd collaborative-task-manager
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Firebase Setup

#### Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project named `collaborative-task-manager`
3. Enable Authentication, Firestore, and Cloud Messaging

#### Add Firebase to Flutter
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase for your project
flutterfire configure
```

#### Update Firebase Configuration
Replace the placeholder values in `lib/firebase_options.dart` with your actual Firebase configuration.

#### Enable Firebase Services
1. **Authentication**: Enable Email/Password provider
2. **Firestore**: Create database in production mode
3. **Cloud Messaging**: Configure for push notifications

### 4. Firestore Database Structure

Create the following collections in Firestore:

#### Users Collection (`users`)
```javascript
{
  "id": "user123",
  "email": "user@example.com",
  "firstName": "John",
  "lastName": "Doe",
  "avatarUrl": null,
  "isEmailVerified": true,
  "boardIds": ["board1", "board2"],
  "created_at": "2024-01-01T00:00:00Z",
  "updated_at": "2024-01-01T00:00:00Z"
}
```

#### Boards Collection (`boards`)
```javascript
{
  "id": "board123",
  "name": "Project Alpha",
  "description": "Main project board",
  "ownerId": "user123",
  "memberIds": ["user123", "user456"],
  "taskIds": ["task1", "task2"],
  "color": "#6366F1",
  "isArchived": false,
  "created_at": "2024-01-01T00:00:00Z",
  "updated_at": "2024-01-01T00:00:00Z",
  "last_synced": "2024-01-01T00:00:00Z",
  "needsSync": false
}
```

#### Tasks Collection (`tasks`)
```javascript
{
  "id": "task123",
  "title": "Implement login feature",
  "description": "Create user authentication flow",
  "boardId": "board123",
  "assignedToId": "user456",
  "status": "in_progress",
  "priority": "high",
  "dueDate": "2024-01-15T00:00:00Z",
  "tags": ["frontend", "auth"],
  "attachments": [],
  "comments": [],
  "created_at": "2024-01-01T00:00:00Z",
  "updated_at": "2024-01-01T00:00:00Z",
  "last_synced": "2024-01-01T00:00:00Z",
  "needsSync": false
}
```

### 5. Environment Configuration
Update the `.env` file with your configuration:
```env
# Firebase Configuration
FIREBASE_API_KEY=your_actual_api_key
FIREBASE_APP_ID=your_actual_app_id
FIREBASE_MESSAGING_SENDER_ID=your_actual_sender_id
FIREBASE_PROJECT_ID=your_actual_project_id

# API Configuration (if using REST API)
API_BASE_URL=https://your-api-domain.com

# Debug Configuration
DEBUG_MODE=true
```

### 6. Generate Code
```bash
# Generate Freezed and JSON serialization code
flutter packages pub run build_runner build

# Or watch for changes during development
flutter packages pub run build_runner watch
```

### 7. Run the Application
```bash
# Debug mode
flutter run

# Release mode
flutter run --release
```

## Firebase Security Rules

### Firestore Rules
Add these security rules to your Firestore database:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only read/write their own user document
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Board access rules
    match /boards/{boardId} {
      allow read, write: if request.auth != null && 
        (resource.data.ownerId == request.auth.uid || 
         request.auth.uid in resource.data.memberIds);
      allow create: if request.auth != null;
    }
    
    // Task access rules  
    match /tasks/{taskId} {
      allow read, write: if request.auth != null && 
        exists(/databases/$(database)/documents/boards/$(resource.data.boardId)) &&
        (get(/databases/$(database)/documents/boards/$(resource.data.boardId)).data.ownerId == request.auth.uid ||
         request.auth.uid in get(/databases/$(database)/documents/boards/$(resource.data.boardId)).data.memberIds);
      allow create: if request.auth != null;
    }
    
    // Notifications
    match /notifications/{notificationId} {
      allow read, write: if request.auth != null && 
        resource.data.userId == request.auth.uid;
    }
  }
}
```

## Testing

### Run Tests
```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/

# Widget tests with coverage
flutter test --coverage
```

### Test Structure
```
test/
├── unit/                   # Unit tests
│   ├── viewmodels/        # ViewModel tests
│   └── repositories/      # Repository tests
├── widget/                # Widget tests
│   └── screens/           # Screen widget tests
└── integration_test/      # Integration tests
    └── app_test.dart      # End-to-end tests
```

## Development Workflow

### Code Generation
The app uses code generation for:
- **Freezed**: Data classes and union types
- **json_annotation**: JSON serialization
- **Riverpod**: Provider generation

Run code generation during development:
```bash
flutter packages pub run build_runner watch --delete-conflicting-outputs
```

### State Management Patterns
- Use `@riverpod` annotation for providers
- Implement ViewModels with `AsyncNotifier`
- Handle loading, error, and success states
- Use provider overrides for testing

### Best Practices
- Follow MVVM architecture
- Use const constructors where possible
- Implement proper error handling
- Write comprehensive tests
- Use TypeScript-style naming conventions
- Add documentation comments

## Deployment

### Android
```bash
# Build APK
flutter build apk --release

# Build App Bundle
flutter build appbundle --release
```

### iOS
```bash
# Build iOS
flutter build ios --release
```

### Web
```bash
# Build web
flutter build web --release
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support and questions:
- Create an issue on GitHub
- Email: support@taskmanager.com
- Documentation: [docs.taskmanager.com](https://docs.taskmanager.com)

---

## 🎯 Next Steps for Production

1. **Enhanced Security**
   - Implement proper authentication tokens
   - Add rate limiting
   - Enable Firebase App Check

2. **Performance Optimization**
   - Add image optimization
   - Implement lazy loading
   - Add caching strategies

3. **Advanced Features**
   - Push notifications
   - File attachments
   - Advanced search with Algolia
   - Real-time commenting
   - Task dependencies

4. **Monitoring & Analytics**
   - Firebase Analytics
   - Crashlytics
   - Performance monitoring

Happy coding! 🚀
