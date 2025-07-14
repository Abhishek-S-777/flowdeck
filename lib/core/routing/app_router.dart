import 'package:flowdeck/presentation/screens/boards/boards_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flowdeck/presentation/screens/auth/login_screen.dart';
import 'package:flowdeck/presentation/screens/auth/register_screen.dart';
import 'package:flowdeck/presentation/screens/auth/forgot_password_screen.dart';
import 'package:flowdeck/presentation/screens/main/main_wrapper.dart';
import 'package:flowdeck/presentation/screens/boards/board_detail_screen.dart';
import 'package:flowdeck/presentation/screens/boards/create_board_screen.dart';
import 'package:flowdeck/presentation/screens/tasks/task_detail_screen.dart';
import 'package:flowdeck/presentation/screens/tasks/create_task_screen.dart';
import 'package:flowdeck/presentation/screens/profile/profile_screen.dart';
import 'package:flowdeck/presentation/screens/settings/settings_screen.dart';
import 'package:flowdeck/presentation/viewmodels/auth_provider.dart';

// Route names
class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String main = '/';
  static const String boards = '/boards';
  static const String boardDetail = '/boards/:boardId';
  static const String createBoard = '/boards/create';
  static const String tasks = '/tasks';
  static const String taskDetail = '/tasks/:taskId';
  static const String createTask = '/tasks/create';
  static const String profile = '/profile';
  static const String settings = '/settings';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.main,
    redirect: (context, state) {
      final isAuthenticated = ref.read(isAuthenticatedProvider);

      final isOnAuthPages = [
        AppRoutes.login,
        AppRoutes.register,
        AppRoutes.forgotPassword,
      ].contains(state.matchedLocation);

      // Redirect to login if not authenticated and not on auth pages
      if (!isAuthenticated && !isOnAuthPages) {
        return AppRoutes.login;
      }

      // Redirect to main if authenticated and on auth pages
      if (isAuthenticated && isOnAuthPages) {
        return AppRoutes.main;
      }

      return null;
    },
    routes: [
      // Auth Routes
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // Main App Routes
      ShellRoute(
        builder: (context, state, child) => MainWrapper(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.main,
            name: 'main',
            builder: (context, state) => const SizedBox.shrink(),
          ),

          // Board Routes
          GoRoute(
            path: AppRoutes.boards,
            name: 'boards',
            builder: (context, state) => const BoardsScreen(),
          ),
          GoRoute(
            path: AppRoutes.createBoard,
            name: 'create-board',
            builder: (context, state) => const CreateBoardScreen(),
          ),
          GoRoute(
            path: AppRoutes.boardDetail,
            name: 'board-detail',
            builder: (context, state) {
              final boardId = state.pathParameters['boardId']!;
              return BoardDetailScreen(boardId: boardId);
            },
          ),

          // Task Routes
          GoRoute(
            path: AppRoutes.createTask,
            name: 'create-task',
            builder: (context, state) {
              final boardId = state.uri.queryParameters['boardId'];
              return CreateTaskScreen(boardId: boardId);
            },
          ),
          GoRoute(
            path: AppRoutes.taskDetail,
            name: 'task-detail',
            builder: (context, state) {
              final taskId = state.pathParameters['taskId']!;
              return TaskDetailScreen(taskId: taskId);
            },
          ),

          // Profile & Settings Routes
          GoRoute(
            path: AppRoutes.profile,
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: AppRoutes.settings,
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.main),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});
