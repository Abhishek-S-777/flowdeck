import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

enum NotificationType {
  @JsonValue('task_assigned')
  taskAssigned,
  @JsonValue('task_updated')
  taskUpdated,
  @JsonValue('task_completed')
  taskCompleted,
  @JsonValue('board_invite')
  boardInvite,
  @JsonValue('board_updated')
  boardUpdated,
  @JsonValue('comment_added')
  commentAdded,
  @JsonValue('due_date_approaching')
  dueDateApproaching,
  @JsonValue('task_overdue')
  taskOverdue,
}

@freezed
abstract class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String id,
    required String userId,
    required NotificationType type,
    required String title,
    required String message,
    String? relatedItemId, // taskId, boardId, etc.
    String? actionUrl,
    @Default(false) bool isRead,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? readAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}

extension NotificationModelX on NotificationModel {
  bool get isUnread => !isRead;

  String get typeDisplayName {
    switch (type) {
      case NotificationType.taskAssigned:
        return 'Task Assigned';
      case NotificationType.taskUpdated:
        return 'Task Updated';
      case NotificationType.taskCompleted:
        return 'Task Completed';
      case NotificationType.boardInvite:
        return 'Board Invitation';
      case NotificationType.boardUpdated:
        return 'Board Updated';
      case NotificationType.commentAdded:
        return 'New Comment';
      case NotificationType.dueDateApproaching:
        return 'Due Date Approaching';
      case NotificationType.taskOverdue:
        return 'Task Overdue';
    }
  }

  Duration? get timeSinceCreated {
    if (createdAt == null) return null;
    return DateTime.now().difference(createdAt!);
  }

  String get timeAgo {
    final duration = timeSinceCreated;
    if (duration == null) return '';

    if (duration.inDays > 0) {
      return '${duration.inDays}d ago';
    } else if (duration.inHours > 0) {
      return '${duration.inHours}h ago';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
