import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flowdeck/presentation/viewmodels/auth_viewmodel.dart';
import 'package:flowdeck/presentation/screens/auth/login_screen.dart';
import 'package:flowdeck/presentation/screens/auth/register_screen.dart';
import 'package:flowdeck/presentation/screens/auth/forgot_password_screen.dart';
import 'package:flowdeck/presentation/screens/boards/boards_screen.dart';
import 'package:flowdeck/presentation/screens/boards/board_detail_screen.dart';
import 'package:flowdeck/presentation/screens/boards/create_board_screen.dart';
import 'package:flowdeck/presentation/screens/tasks/tasks_screen.dart';
import 'package:flowdeck/presentation/screens/tasks/task_detail_screen.dart';
import 'package:flowdeck/presentation/screens/tasks/create_task_screen.dart';
import 'package:flowdeck/presentation/screens/profile/profile_screen.dart';
import 'package:flowdeck/presentation/screens/notifications/notifications_screen.dart';
import 'package:flowdeck/presentation/screens/settings/settings_screen.dart';
import 'package:flowdeck/presentation/screens/main/main_wrapper.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String main = '/';
  static const String boards = '/boards';
  static const String tasks = '/tasks';
  static const String notifications = '/notifications';
  static const String profile = '/profile';

  static const String boardDetail = '/boards/:boardId';
  static const String taskDetail = '/tasks/:taskId';

  static const String createBoard = '/create-board';
  static const String createTask = '/create-task';
  static const String settings = '/settings';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.boards,
    redirect: (context, state) {
      final bool isAuthenticated =
          ref.watch(authViewModelProvider.notifier).isUserAuthenticated();

      final isOnAuthPage = [
        AppRoutes.login,
        AppRoutes.register,
        AppRoutes.forgotPassword,
      ].contains(state.matchedLocation);

      if (!isAuthenticated && !isOnAuthPage) {
        return AppRoutes.login;
      }

      if (isAuthenticated && isOnAuthPage) {
        return AppRoutes.boards;
      }

      return null;
    },
    routes: [
      /// === AUTH ROUTES ===
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      /// === SHELL (BOTTOM NAV) ROUTES ===
      ShellRoute(
        builder: (context, state, child) => MainWrapper(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.boards,
            builder: (context, state) => const BoardsScreen(),
          ),
          GoRoute(
            path: AppRoutes.tasks,
            builder: (context, state) => const TasksScreen(),
          ),
          GoRoute(
            path: AppRoutes.notifications,
            builder: (context, state) => const NotificationsScreen(),
          ),
          GoRoute(
            path: AppRoutes.profile,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),

      /// === OUTSIDE FULL SCREEN ROUTES ===
      GoRoute(
        path: AppRoutes.createBoard,
        builder: (context, state) => const CreateBoardScreen(),
      ),
      GoRoute(
        path: AppRoutes.boardDetail,
        builder: (context, state) {
          final boardId = state.pathParameters['boardId']!;
          return BoardDetailScreen(boardId: boardId);
        },
      ),
      GoRoute(
        path: AppRoutes.createTask,
        builder: (context, state) {
          final boardId = state.uri.queryParameters['boardId'];
          return CreateTaskScreen(boardId: boardId);
        },
      ),
      GoRoute(
        path: AppRoutes.taskDetail,
        builder: (context, state) {
          final taskId = state.pathParameters['taskId']!;
          return TaskDetailScreen(taskId: taskId);
        },
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Page not found',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('The page you are looking for does not exist.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.boards),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});
