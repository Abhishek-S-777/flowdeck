import 'package:flowdeck/data/models/notification_model.dart';

abstract class NotificationRepository {
  // Local operations
  Future<List<NotificationModel>> getNotifications({String? userId});

  Future<NotificationModel?> getNotificationById(String id);

  Future<void> markAsRead(String id);

  Future<void> markAllAsRead({String? userId});

  Future<void> deleteNotification(String id);

  Future<void> clearAllNotifications({String? userId});

  // Real-time operations
  Stream<List<NotificationModel>> getNotificationsStream({String? userId});

  Stream<int> getUnreadCountStream({String? userId});

  // Push notifications
  Future<void> registerForPushNotifications();

  Future<void> subscribeToBoard(String boardId);

  Future<void> unsubscribeFromBoard(String boardId);

  Future<void> subscribeToTask(String taskId);

  Future<void> unsubscribeFromTask(String taskId);

  // Notification creation
  Future<void> sendTaskAssignmentNotification({
    required String taskId,
    required String assignedToId,
    required String assignedByName,
  });

  Future<void> sendTaskUpdateNotification({
    required String taskId,
    required String updatedByName,
    required String updateType,
  });

  Future<void> sendBoardInviteNotification({
    required String boardId,
    required String invitedUserId,
    required String invitedByName,
  });
}
