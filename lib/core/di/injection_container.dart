import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:flowdeck/data/datasources/local/app_database.dart';
import 'package:flowdeck/data/datasources/remote/api_client.dart';
import 'package:flowdeck/data/repositories/auth_repository_impl.dart';
import 'package:flowdeck/data/repositories/board_repository_impl.dart';
import 'package:flowdeck/data/repositories/task_repository_impl.dart';
import 'package:flowdeck/data/repositories/notification_repository_impl.dart';
import 'package:flowdeck/data/services/connectivity_service.dart';
import 'package:flowdeck/data/services/firebase_service.dart';
import 'package:flowdeck/data/services/sync_service.dart';
import 'package:flowdeck/domain/repositories/auth_repository.dart';
import 'package:flowdeck/domain/repositories/board_repository.dart';
import 'package:flowdeck/domain/repositories/task_repository.dart';
import 'package:flowdeck/domain/repositories/notification_repository.dart';

// Core Dependencies
final loggerProvider = Provider<Logger>(
  (ref) => Logger(
    printer: PrettyPrinter(),
  ),
);

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  // Add interceptors
  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    responseHeader: false,
  ),);

  return dio;
});

// Database
final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

// Services
final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiClient(dio);
});

final firebaseServiceProvider =
    Provider<FirebaseService>((ref) => FirebaseService());

final connectivityServiceProvider =
    Provider<ConnectivityService>((ref) => ConnectivityService());

final syncServiceProvider = Provider<SyncService>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  final boardRepo = ref.watch(boardRepositoryProvider);
  final taskRepo = ref.watch(taskRepositoryProvider);
  final connectivity = ref.watch(connectivityServiceProvider);

  return SyncService(
    authRepository: authRepo,
    boardRepository: boardRepo,
    taskRepository: taskRepo,
    connectivityService: connectivity,
  );
});

// Repositories
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseService = ref.watch(firebaseServiceProvider);
  final database = ref.watch(appDatabaseProvider);
  final logger = ref.watch(loggerProvider);

  return AuthRepositoryImpl(
    firebaseService: firebaseService,
    database: database,
    logger: logger,
  );
});

final boardRepositoryProvider = Provider<BoardRepository>((ref) {
  final firebaseService = ref.watch(firebaseServiceProvider);
  final database = ref.watch(appDatabaseProvider);
  final logger = ref.watch(loggerProvider);

  return BoardRepositoryImpl(
    firebaseService: firebaseService,
    database: database,
    logger: logger,
  );
});

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final firebaseService = ref.watch(firebaseServiceProvider);
  final database = ref.watch(appDatabaseProvider);
  final logger = ref.watch(loggerProvider);

  return TaskRepositoryImpl(
    firebaseService: firebaseService,
    database: database,
    logger: logger,
  );
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final firebaseService = ref.watch(firebaseServiceProvider);
  final database = ref.watch(appDatabaseProvider);
  final logger = ref.watch(loggerProvider);

  return NotificationRepositoryImpl(
    firebaseService: firebaseService,
    database: database,
    logger: logger,
  );
});

// Initialize dependencies
Future<void> initializeDependencies() async {
  // Initialize database
  final database = AppDatabase();
  await database.init();

  // Initialize Firebase if needed
  // Firebase is already initialized in main.dart

  // Any other initialization logic can go here
}
