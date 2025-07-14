// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    _NotificationModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      title: json['title'] as String,
      message: json['message'] as String,
      relatedItemId: json['relatedItemId'] as String?,
      actionUrl: json['actionUrl'] as String?,
      isRead: json['isRead'] as bool? ?? false,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
    );

Map<String, dynamic> _$NotificationModelToJson(_NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'title': instance.title,
      'message': instance.message,
      'relatedItemId': instance.relatedItemId,
      'actionUrl': instance.actionUrl,
      'isRead': instance.isRead,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt?.toIso8601String(),
      'readAt': instance.readAt?.toIso8601String(),
    };

const _$NotificationTypeEnumMap = {
  NotificationType.taskAssigned: 'task_assigned',
  NotificationType.taskUpdated: 'task_updated',
  NotificationType.taskCompleted: 'task_completed',
  NotificationType.boardInvite: 'board_invite',
  NotificationType.boardUpdated: 'board_updated',
  NotificationType.commentAdded: 'comment_added',
  NotificationType.dueDateApproaching: 'due_date_approaching',
  NotificationType.taskOverdue: 'task_overdue',
};
