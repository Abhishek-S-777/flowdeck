# Copilot Instructions for Collaborative Task Manager

<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

## Project Overview

This is a Flutter Collaborative Task Manager application built with:

- **Architecture**: MVVM pattern with clean architecture
- **State Management**: Riverpod with providers and notifiers
- **Database**: Drift (SQLite) for local storage
- **Backend**: Firebase (Auth, Firestore, Messaging)
- **UI**: Material 3 design system
- **Navigation**: GoRouter with Riverpod integration
- **Code Generation**: Freezed for data models, Riverpod generators

## Coding Guidelines

### State Management
- Use `@riverpod` annotation for all providers
- Implement ViewModels using `AsyncNotifier` or `Notifier`
- Handle loading, error, and success states properly
- Use provider overrides for testing

### Models and Data
- Use Freezed for all data models with `@freezed` annotation
- Include `toJson`/`fromJson` methods for serialization
- Add helpful extension methods for computed properties
- Use proper null safety throughout

### UI Components
- Follow Material 3 design guidelines
- Use constants from `app_constants.dart` for spacing, colors, etc.
- Create reusable widgets in the `widgets` directory
- Implement proper error states and loading indicators

### Repository Pattern
- Implement repository interfaces in the domain layer
- Create concrete implementations in the data layer
- Handle both local (SQLite) and remote (Firebase/API) data sources
- Implement proper offline-first sync logic

### Navigation
- Use GoRouter with proper route definitions
- Implement authentication-based route guards
- Use type-safe navigation with route parameters

### Testing
- Write unit tests for ViewModels and repositories
- Use `mocktail` for mocking dependencies
- Utilize Riverpod's override capabilities for testing
- Create widget tests for complex UI components

## File Organization

```
lib/
├── core/                 # App-wide configuration
├── data/                # Data layer (models, repositories, services)
├── domain/              # Domain layer (interfaces, entities)
├── presentation/        # UI layer (screens, widgets, viewmodels)
└── main.dart           # App entry point
```

## Best Practices

1. **Dependency Injection**: Use Riverpod providers for DI
2. **Error Handling**: Implement comprehensive error handling with user-friendly messages
3. **Offline Support**: Ensure app works offline with proper sync mechanisms
4. **Performance**: Use const constructors, avoid unnecessary rebuilds
5. **Type Safety**: Leverage Dart's type system and null safety
6. **Code Generation**: Run `flutter packages pub run build_runner build` after model changes

## Common Patterns

### ViewModel Pattern
```dart
@riverpod
class ExampleViewModel extends _$ExampleViewModel {
  @override
  Future<ExampleState> build() async {
    // Initialize state
  }
  
  Future<void> performAction() async {
    state = const AsyncValue.loading();
    try {
      // Perform action
      state = AsyncValue.data(newState);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
```

### Repository Implementation
```dart
class ExampleRepositoryImpl implements ExampleRepository {
  final FirebaseService firebaseService;
  final AppDatabase database;
  
  // Implement offline-first pattern
  @override
  Future<List<Example>> getExamples() async {
    try {
      // Try remote first if online
      final remote = await firebaseService.getExamples();
      await _cacheLocally(remote);
      return remote;
    } catch (e) {
      // Fallback to local data
      return await database.getExamples();
    }
  }
}
```

When suggesting code, prioritize:
1. Type safety and null safety
2. Proper error handling
3. Offline-first approach
4. Material 3 design compliance
5. Performance optimizations
6. Code reusability and maintainability
