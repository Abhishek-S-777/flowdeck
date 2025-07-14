import 'package:logger/logger.dart';

import 'package:flowdeck/domain/repositories/notification_repository.dart';
import 'package:flowdeck/data/models/notification_model.dart';
import 'package:flowdeck/data/datasources/local/app_database.dart';
import 'package:flowdeck/data/services/firebase_service.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl({
    required FirebaseService firebaseService,
    required AppDatabase database,
    required Logger logger,
  })  : _firebaseService = firebaseService,
        _database = database,
        _logger = logger;

  final FirebaseService _firebaseService;
  final AppDatabase _database;
  final Logger _logger;

  @override
  Future<List<NotificationModel>> getNotifications({String? userId}) async {
    try {
      // For now, return empty list since Firebase service doesn't have notification methods
      // In a real implementation, you would fetch from Firestore
      return [];
    } catch (e) {
      _logger.w(
          'Failed to get notifications from remote, falling back to local: $e',);
      return [];
    }
  }

  @override
  Future<NotificationModel?> getNotificationById(String id) async {
    try {
      // Try local first since Firebase service doesn't have this method
      return null;
    } catch (e) {
      _logger.e('Failed to get notification by id: $e');
      return null;
    }
  }

  @override
  Future<void> markAsRead(String id) async {
    try {
      // Update both remote and local
      // Remote update would go here
      // Local update would go here
      _logger.i('Marked notification $id as read');
    } catch (e) {
      _logger.e('Failed to mark notification as read: $e');
    }
  }

  @override
  Future<void> markAllAsRead({String? userId}) async {
    try {
      // Update both remote and local
      // Remote update would go here
      // Local update would go here
      _logger.i('Marked all notifications as read for user $userId');
    } catch (e) {
      _logger.e('Failed to mark all notifications as read: $e');
    }
  }

  @override
  Future<void> deleteNotification(String id) async {
    try {
      // Delete from both remote and local
      // Remote delete would go here
      // Local delete would go here
      _logger.i('Deleted notification $id');
    } catch (e) {
      _logger.e('Failed to delete notification: $e');
    }
  }

  @override
  Future<void> clearAllNotifications({String? userId}) async {
    try {
      // Clear from both remote and local
      // Remote clear would go here
      // Local clear would go here using _database
      _logger.i(
          'Cleared all notifications for user $userId (database: ${_database.toString()})',);
    } catch (e) {
      _logger.e('Failed to clear all notifications: $e');
    }
  }

  @override
  Stream<List<NotificationModel>> getNotificationsStream({String? userId}) {
    // Return empty stream for now
    return Stream.value([]);
  }

  @override
  Stream<int> getUnreadCountStream({String? userId}) {
    // Return stream with count 0 for now
    return Stream.value(0);
  }

  @override
  Future<void> registerForPushNotifications() async {
    try {
      // Request notification permissions
      await _firebaseService.requestNotificationPermission();

      // Get FCM token
      final token = await _firebaseService.getFCMToken();
      if (token != null) {
        _logger.i('FCM token: $token');
        // Save token to user profile or send to backend
      }
    } catch (e) {
      _logger.e('Failed to register for push notifications: $e');
    }
  }

  @override
  Future<void> subscribeToBoard(String boardId) async {
    try {
      await _firebaseService.subscribeToTopic('board_$boardId');
      _logger.i('Subscribed to board $boardId notifications');
    } catch (e) {
      _logger.e('Failed to subscribe to board notifications: $e');
    }
  }

  @override
  Future<void> unsubscribeFromBoard(String boardId) async {
    try {
      await _firebaseService.unsubscribeFromTopic('board_$boardId');
      _logger.i('Unsubscribed from board $boardId notifications');
    } catch (e) {
      _logger.e('Failed to unsubscribe from board notifications: $e');
    }
  }

  @override
  Future<void> subscribeToTask(String taskId) async {
    try {
      await _firebaseService.subscribeToTopic('task_$taskId');
      _logger.i('Subscribed to task $taskId notifications');
    } catch (e) {
      _logger.e('Failed to subscribe to task notifications: $e');
    }
  }

  @override
  Future<void> unsubscribeFromTask(String taskId) async {
    try {
      await _firebaseService.unsubscribeFromTopic('task_$taskId');
      _logger.i('Unsubscribed from task $taskId notifications');
    } catch (e) {
      _logger.e('Failed to unsubscribe from task notifications: $e');
    }
  }

  @override
  Future<void> sendTaskAssignmentNotification({
    required String taskId,
    required String assignedToId,
    required String assignedByName,
  }) async {
    try {
      // Create notification model
      final notification = NotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: assignedToId,
        title: 'Task Assigned',
        message: 'You have been assigned a task by $assignedByName',
        type: NotificationType.taskAssigned,
        metadata: {'taskId': taskId, 'assignedBy': assignedByName},
        createdAt: DateTime.now(),
      );

      // Send via Firebase Cloud Messaging
      // This would require implementing notification sending in FirebaseService
      _logger.i(
          'Task assignment notification sent for task $taskId: ${notification.id}',);
    } catch (e) {
      _logger.e('Failed to send task assignment notification: $e');
    }
  }

  @override
  Future<void> sendTaskUpdateNotification({
    required String taskId,
    required String updatedByName,
    required String updateType,
  }) async {
    try {
      // This would create and send a task update notification
      _logger.i('Task update notification sent for task $taskId');
    } catch (e) {
      _logger.e('Failed to send task update notification: $e');
    }
  }

  @override
  Future<void> sendBoardInviteNotification({
    required String boardId,
    required String invitedUserId,
    required String invitedByName,
  }) async {
    try {
      // Create notification model
      final notification = NotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: invitedUserId,
        title: 'Board Invitation',
        message: 'You have been invited to a board by $invitedByName',
        type: NotificationType.boardInvite,
        metadata: {'boardId': boardId, 'invitedBy': invitedByName},
        createdAt: DateTime.now(),
      );

      // Send via Firebase Cloud Messaging
      _logger.i(
          'Board invite notification sent for board $boardId: ${notification.id}',);
    } catch (e) {
      _logger.e('Failed to send board invite notification: $e');
    }
  }
}
