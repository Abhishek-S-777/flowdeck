import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryVariant = Color(0xFF4F46E5);
  static const Color secondary = Color(0xFF10B981);
  static const Color secondaryVariant = Color(0xFF059669);

  // Surface Colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF8FAFC);
  static const Color background = Color(0xFFFCFCFC);
  static const Color card = Color(0xFFFFFFFF);

  // Text Colors
  static const Color onSurface = Color(0xFF1F2937);
  static const Color onSurfaceVariant = Color(0xFF6B7280);
  static const Color onBackground = Color(0xFF111827);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Task Priority Colors
  static const Color highPriority = Color(0xFFEF4444);
  static const Color mediumPriority = Color(0xFFF59E0B);
  static const Color lowPriority = Color(0xFF10B981);
  static const Color noPriority = Color(0xFF6B7280);

  // Border Colors
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFE5E7EB);

  // Overlay Colors
  static const Color overlay = Color(0x80000000);
  static const Color shimmer = Color(0xFFE5E7EB);
}

class AppDimensions {
  // Spacing
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  // Border Radius
  static const double radiusXs = 4;
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;

  // Icon Sizes
  static const double iconXs = 16;
  static const double iconSm = 20;
  static const double iconMd = 24;
  static const double iconLg = 32;
  static const double iconXl = 48;

  // Button Heights
  static const double buttonHeightSm = 36;
  static const double buttonHeightMd = 44;
  static const double buttonHeightLg = 52;

  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
}

class AppStrings {
  // App
  static const String appName = 'Collaborative Task Manager';
  static const String appDescription =
      'Manage tasks collaboratively with your team';

  // Authentication
  static const String signIn = 'Sign In';
  static const String signUp = 'Sign Up';
  static const String signOut = 'Sign Out';
  static const String forgotPassword = 'Forgot Password?';
  static const String resetPassword = 'Reset Password';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String firstName = 'First Name';
  static const String lastName = 'Last Name';

  // Navigation
  static const String boards = 'Boards';
  static const String tasks = 'Tasks';
  static const String profile = 'Profile';
  static const String settings = 'Settings';
  static const String notifications = 'Notifications';

  // Board Management
  static const String createBoard = 'Create Board';
  static const String editBoard = 'Edit Board';
  static const String deleteBoard = 'Delete Board';
  static const String boardName = 'Board Name';
  static const String boardDescription = 'Board Description';

  // Task Management
  static const String createTask = 'Create Task';
  static const String editTask = 'Edit Task';
  static const String deleteTask = 'Delete Task';
  static const String taskTitle = 'Task Title';
  static const String taskDescription = 'Task Description';
  static const String assignTo = 'Assign To';
  static const String dueDate = 'Due Date';
  static const String priority = 'Priority';

  // Priority Levels
  static const String highPriority = 'High';
  static const String mediumPriority = 'Medium';
  static const String lowPriority = 'Low';
  static const String noPriority = 'None';

  // Task Status
  static const String todo = 'To Do';
  static const String inProgress = 'In Progress';
  static const String done = 'Done';

  // Common Actions
  static const String save = 'Save';
  static const String cancel = 'Cancel';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String search = 'Search';
  static const String filter = 'Filter';
  static const String sort = 'Sort';
  static const String refresh = 'Refresh';

  // Error Messages
  static const String networkError =
      'Network connection error. Please check your internet connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String authError = 'Authentication error. Please sign in again.';
  static const String validationError =
      'Please check your input and try again.';
  static const String syncError =
      'Failed to sync data. Changes will be synced when connection is restored.';

  // Success Messages
  static const String taskCreated = 'Task created successfully';
  static const String taskUpdated = 'Task updated successfully';
  static const String taskDeleted = 'Task deleted successfully';
  static const String boardCreated = 'Board created successfully';
  static const String boardUpdated = 'Board updated successfully';
  static const String boardDeleted = 'Board deleted successfully';

  // Empty States
  static const String noBoardsFound = 'No boards found';
  static const String noTasksFound = 'No tasks found';
  static const String noSearchResults = 'No search results found';
  static const String noNotifications = 'No notifications';

  // Offline
  static const String offlineMode =
      'You\'re offline. Changes will sync when connection is restored.';
  static const String syncingData = 'Syncing data...';
  static const String syncComplete = 'Data synced successfully';
}
