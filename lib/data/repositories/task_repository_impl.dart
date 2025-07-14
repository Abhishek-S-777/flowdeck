import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:drift/drift.dart';

import 'package:flowdeck/domain/repositories/task_repository.dart';
import 'package:flowdeck/data/models/task_model.dart';
import 'package:flowdeck/data/datasources/local/app_database.dart';
import 'package:flowdeck/data/services/firebase_service.dart';

class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl({
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
  Future<List<TaskModel>> getTasks({
    String? boardId,
    String? assignedToId,
    TaskStatus? status,
    TaskPriority? priority,
  }) async {
    try {
      // Try to get from remote first
      final stream = _firebaseService.getTasksStream(
        boardId: boardId,
        assignedToId: assignedToId,
        status: status,
        priority: priority,
      );
      final remoteTasks = await stream.first;

      // Cache locally
      for (final task in remoteTasks) {
        await _database.insertTask(_taskToCompanion(task));
      }

      return remoteTasks;
    } catch (e) {
      _logger.w('Failed to get tasks from remote, falling back to local: $e');

      // Fallback to local data - simplified for now
      return [];
    }
  }

  @override
  Future<TaskModel?> getTaskById(String id) async {
    try {
      // Try remote first
      final remoteTask = await _firebaseService.getTask(id);
      if (remoteTask != null) {
        // Cache locally
        await _database.insertTask(_taskToCompanion(remoteTask));
        return remoteTask;
      }
    } catch (e) {
      _logger.w('Failed to get task from remote: $e');
    }

    // Fallback to local - simplified for now
    return null;
  }

  @override
  Future<TaskModel> createTask(TaskModel task) async {
    try {
      // Create remotely first
      await _firebaseService.createTask(task);

      // Cache locally
      await _database.insertTask(_taskToCompanion(task));

      return task;
    } catch (e) {
      _logger.e('Failed to create task: $e');
      rethrow;
    }
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) async {
    try {
      // Update remotely first
      await _firebaseService.updateTask(task);

      // Update locally
      await _database.updateTask(_taskModelToEntity(task));

      return task;
    } catch (e) {
      _logger.e('Failed to update task remotely: $e');

      // Update locally anyway for offline capability
      await _database.updateTask(_taskModelToEntity(task));
      return task;
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      // Delete remotely first
      await _firebaseService.deleteTask(id);

      // Delete locally
      await _database.deleteTask(id);
    } catch (e) {
      _logger.e('Failed to delete task: $e');

      // Delete locally anyway
      await _database.deleteTask(id);
    }
  }

  @override
  Future<List<TaskModel>> searchTasks({
    required String query,
    String? boardId,
    String? assignedToId,
  }) async {
    try {
      // Try remote search first
      final remoteTasks = await _firebaseService.searchTasks(
        query: query,
        boardId: boardId,
        assignedToId: assignedToId,
      );

      // Cache results locally
      for (final task in remoteTasks) {
        await _database.insertTask(_taskToCompanion(task));
      }

      return remoteTasks;
    } catch (e) {
      _logger.w('Failed to search tasks remotely, falling back to local: $e');

      // Fallback to local search - simplified for now
      return [];
    }
  }

  @override
  Future<void> syncTask(TaskModel task) async {
    try {
      await _firebaseService.updateTask(task);
      await _database.updateTask(_taskModelToEntity(task));
    } catch (e) {
      _logger.e('Failed to sync task: $e');
      rethrow;
    }
  }

  @override
  Future<List<TaskModel>> getUnsyncedTasks() async {
    // Return empty list for now - would need to track sync status in database
    return [];
  }

  @override
  Future<void> refreshTasksFromRemote() async {
    try {
      final stream = _firebaseService.getTasksStream();
      final remoteTasks = await stream.first;

      // Clear local cache and repopulate would go here
      for (final task in remoteTasks) {
        await _database.insertTask(_taskToCompanion(task));
      }
    } catch (e) {
      _logger.e('Failed to refresh tasks from remote: $e');
      rethrow;
    }
  }

  @override
  Future<void> resolveConflicts() async {
    // Implementation for conflict resolution
    final unsyncedTasks = await getUnsyncedTasks();

    for (final task in unsyncedTasks) {
      try {
        await syncTask(task);
      } catch (e) {
        _logger.w('Failed to resolve conflict for task ${task.id}: $e');
      }
    }
  }

  @override
  Future<void> cleanupOldTasks(DateTime cutoffDate) async {
    // Database cleanup would go here
    _logger.i('Cleanup old tasks before $cutoffDate');
  }

  @override
  Stream<List<TaskModel>> getTasksStream({
    String? boardId,
    String? assignedToId,
    TaskStatus? status,
    TaskPriority? priority,
  }) {
    return _firebaseService.getTasksStream(
      boardId: boardId,
      assignedToId: assignedToId,
      status: status,
      priority: priority,
    );
  }

  @override
  Stream<TaskModel?> getTaskStream(String id) {
    // Firebase doesn't have single task stream, so we'll implement with periodic checks
    return Stream.periodic(const Duration(seconds: 30), (_) async {
      return await getTaskById(id);
    }).asyncMap((future) => future);
  }

  @override
  Future<TaskModel> updateTaskStatus(String id, TaskStatus status) async {
    final task = await getTaskById(id);
    if (task != null) {
      final updatedTask = task.copyWith(
        status: status,
        updatedAt: DateTime.now(),
      );
      return await updateTask(updatedTask);
    }
    throw Exception('Task not found: $id');
  }

  @override
  Future<TaskModel> updateTaskPriority(String id, TaskPriority priority) async {
    final task = await getTaskById(id);
    if (task != null) {
      final updatedTask = task.copyWith(
        priority: priority,
        updatedAt: DateTime.now(),
      );
      return await updateTask(updatedTask);
    }
    throw Exception('Task not found: $id');
  }

  @override
  Future<TaskModel> assignTask(String id, String? assignedToId) async {
    final task = await getTaskById(id);
    if (task != null) {
      final updatedTask = task.copyWith(
        assignedToId: assignedToId,
        updatedAt: DateTime.now(),
      );
      return await updateTask(updatedTask);
    }
    throw Exception('Task not found: $id');
  }

  @override
  Future<TaskModel> updateTaskDueDate(String id, DateTime? dueDate) async {
    final task = await getTaskById(id);
    if (task != null) {
      final updatedTask = task.copyWith(
        dueDate: dueDate,
        updatedAt: DateTime.now(),
      );
      return await updateTask(updatedTask);
    }
    throw Exception('Task not found: $id');
  }

  @override
  Future<Map<TaskStatus, int>> getTaskCountByStatus({String? boardId}) async {
    // Would implement with database aggregation
    return {
      TaskStatus.todo: 0,
      TaskStatus.inProgress: 0,
      TaskStatus.done: 0,
    };
  }

  @override
  Future<Map<TaskPriority, int>> getTaskCountByPriority(
      {String? boardId,}) async {
    // Would implement with database aggregation
    return {
      TaskPriority.low: 0,
      TaskPriority.medium: 0,
      TaskPriority.high: 0,
      TaskPriority.urgent: 0,
    };
  }

  @override
  Future<List<TaskModel>> getOverdueTasks({String? assignedToId}) async {
    // Would implement with database query for tasks where dueDate < now
    return [];
  }

  @override
  Future<List<TaskModel>> getTasksDueSoon({String? assignedToId}) async {
    // Would implement with database query for tasks due within next few days
    return [];
  }

  // Helper methods
  TasksCompanion _taskToCompanion(TaskModel task) => TasksCompanion.insert(
        id: task.id,
        boardId: task.boardId,
        title: task.title,
        description: task.description,
        status: Value(task.status.name),
        priority: Value(task.priority.name),
        assignedToId: Value.absentIfNull(task.assignedToId),
        dueDate: Value.absentIfNull(task.dueDate),
        tags: Value(jsonEncode(task.tags)),
        attachments: Value(jsonEncode(task.attachments)),
        comments: Value(jsonEncode(task.comments)),
        createdAt: Value.absentIfNull(task.createdAt),
        updatedAt: Value.absentIfNull(task.updatedAt),
        lastSynced: Value.absentIfNull(task.lastSynced),
        needsSync: Value(task.needsSync),
      );

  Task _taskModelToEntity(TaskModel task) => Task(
        id: task.id,
        boardId: task.boardId,
        title: task.title,
        description: task.description,
        assignedToId: task.assignedToId,
        status: task.status.name,
        priority: task.priority.name,
        dueDate: task.dueDate,
        tags: jsonEncode(task.tags),
        attachments: jsonEncode(task.attachments),
        comments: jsonEncode(task.comments),
        createdAt: task.createdAt,
        updatedAt: task.updatedAt,
        lastSynced: task.lastSynced,
        needsSync: task.needsSync,
      );
}
