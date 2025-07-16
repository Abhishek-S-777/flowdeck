import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

enum TaskStatus {
  todo,
  inProgress,
  done,
  archived,
}

enum TaskPriority {
  low,
  medium,
  high,
  urgent,
}

@freezed
abstract class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    required String boardId,
    String? description,
    String? assigneeId,
    @Default(TaskStatus.todo) TaskStatus status,
    @Default(TaskPriority.medium) TaskPriority priority,
    @Default([]) List<String> tags,
    DateTime? dueDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
