class AppConfig {
  static const String appName = 'Collaborative Task Manager';
  static const String appVersion = '1.0.0';

  // API Configuration
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Local Storage
  static const String databaseName = 'task_manager.db';
  static const int databaseVersion = 1;

  // Firebase Collections
  static const String usersCollection = 'users';
  static const String boardsCollection = 'boards';
  static const String tasksCollection = 'tasks';
  static const String notificationsCollection = 'notifications';

  // Cache Configuration
  static const Duration cacheExpiration = Duration(hours: 24);
  static const Duration syncInterval = Duration(minutes: 5);

  // UI Configuration
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration debounceDelay = Duration(milliseconds: 500);
  static const Duration searchDebounceDelay = Duration(milliseconds: 800);
}
