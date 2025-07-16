import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

enum TaskStatus {
  @JsonValue('todo')
  todo,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('done')
  done,
}

enum TaskPriority {
  @JsonValue('none')
  none,
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('urgent')
  urgent,
}

@freezed
abstract class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required String title,
    required String description,
    required String boardId,
    String? assignedToId,
    @Default(TaskStatus.todo) TaskStatus status,
    @Default(TaskPriority.none) TaskPriority priority,
    DateTime? dueDate,
    @Default([]) List<String> tags,
    @Default([]) List<String> attachments,
    @Default([]) List<String> comments,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastSynced,
    @Default(false) bool needsSync,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}

extension TaskModelX on TaskModel {
  bool get isOverdue {
    if (dueDate == null) return false;
    return DateTime.now().isAfter(dueDate!) && status != TaskStatus.done;
  }

  bool get isDueSoon {
    if (dueDate == null) return false;
    final now = DateTime.now();
    final daysDiff = dueDate!.difference(now).inDays;
    return daysDiff <= 3 && daysDiff >= 0 && status != TaskStatus.done;
  }

  bool get hasAssignee => assignedToId != null;

  bool get hasComments => comments.isNotEmpty;

  bool get hasAttachments => attachments.isNotEmpty;

  String get statusDisplayName {
    switch (status) {
      case TaskStatus.todo:
        return 'To Do';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.done:
        return 'Done';
    }
  }

  String get priorityDisplayName {
    switch (priority) {
      case TaskPriority.none:
        return 'None';
      case TaskPriority.low:
        return 'Low';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.high:
        return 'High';
      case TaskPriority.urgent:
        return 'Urgent';
    }
  }
}
