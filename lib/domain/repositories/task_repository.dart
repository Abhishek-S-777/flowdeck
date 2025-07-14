import 'package:flowdeck/data/models/task_model.dart';

abstract class TaskRepository {
  // Local operations
  Future<List<TaskModel>> getTasks({
    String? boardId,
    String? assignedToId,
    TaskStatus? status,
    TaskPriority? priority,
  });

  Future<TaskModel?> getTaskById(String id);

  Future<TaskModel> createTask(TaskModel task);

  Future<TaskModel> updateTask(TaskModel task);

  Future<void> deleteTask(String id);

  Future<List<TaskModel>> searchTasks({
    required String query,
    String? boardId,
    String? assignedToId,
  });

  // Remote sync operations
  Future<void> syncTask(TaskModel task);

  Future<List<TaskModel>> getUnsyncedTasks();

  Future<void> refreshTasksFromRemote();

  Future<void> resolveConflicts();

  Future<void> cleanupOldTasks(DateTime cutoffDate);

  // Real-time operations
  Stream<List<TaskModel>> getTasksStream({
    String? boardId,
    String? assignedToId,
    TaskStatus? status,
    TaskPriority? priority,
  });

  Stream<TaskModel?> getTaskStream(String id);

  // Task management
  Future<TaskModel> updateTaskStatus(String id, TaskStatus status);

  Future<TaskModel> updateTaskPriority(String id, TaskPriority priority);

  Future<TaskModel> assignTask(String id, String? assignedToId);

  Future<TaskModel> updateTaskDueDate(String id, DateTime? dueDate);

  // Analytics
  Future<Map<TaskStatus, int>> getTaskCountByStatus({String? boardId});

  Future<Map<TaskPriority, int>> getTaskCountByPriority({String? boardId});

  Future<List<TaskModel>> getOverdueTasks({String? assignedToId});

  Future<List<TaskModel>> getTasksDueSoon({String? assignedToId});
}
