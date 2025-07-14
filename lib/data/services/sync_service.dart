import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:flowdeck/core/config/app_config.dart';
import 'package:flowdeck/core/di/injection_container.dart' as di;
import 'package:flowdeck/domain/repositories/auth_repository.dart';
import 'package:flowdeck/domain/repositories/board_repository.dart';
import 'package:flowdeck/domain/repositories/task_repository.dart';
import 'package:flowdeck/data/services/connectivity_service.dart';

enum SyncStatus {
  idle,
  syncing,
  success,
  error,
}

class SyncResult {
  const SyncResult({
    required this.status,
    this.error,
    this.syncedItems,
  });
  final SyncStatus status;
  final String? error;
  final int? syncedItems;
}

class SyncService {
  SyncService({
    required this.authRepository,
    required this.boardRepository,
    required this.taskRepository,
    required this.connectivityService,
  }) {
    _startPeriodicSync();
    _listenToConnectivityChanges();
  }
  final AuthRepository authRepository;
  final BoardRepository boardRepository;
  final TaskRepository taskRepository;
  final ConnectivityService connectivityService;
  final Logger _logger = Logger();

  final StreamController<SyncResult> _syncController =
      StreamController<SyncResult>.broadcast();

  Stream<SyncResult> get syncStream => _syncController.stream;

  Timer? _periodicSyncTimer;
  bool _isSyncing = false;

  void _startPeriodicSync() {
    _periodicSyncTimer = Timer.periodic(
      AppConfig.syncInterval,
      (_) => syncAll(),
    );
  }

  void _listenToConnectivityChanges() {
    connectivityService.connectionStream.listen((status) {
      if (status == ConnectionStatus.online && !_isSyncing) {
        // Sync when coming back online
        syncAll();
      }
    });
  }

  Future<void> syncAll() async {
    if (_isSyncing || connectivityService.isOffline) {
      return;
    }

    _isSyncing = true;
    _syncController.add(const SyncResult(status: SyncStatus.syncing));

    try {
      _logger.i('Starting sync process...');

      var totalSynced = 0;

      // Sync boards
      final boardsSynced = await _syncBoards();
      totalSynced += boardsSynced;

      // Sync tasks
      final tasksSynced = await _syncTasks();
      totalSynced += tasksSynced;

      _logger.i('Sync completed successfully. Synced $totalSynced items.');
      _syncController.add(SyncResult(
        status: SyncStatus.success,
        syncedItems: totalSynced,
      ),);
    } catch (e, stackTrace) {
      _logger.e('Sync failed', error: e, stackTrace: stackTrace);
      _syncController.add(SyncResult(
        status: SyncStatus.error,
        error: e.toString(),
      ),);
    } finally {
      _isSyncing = false;
    }
  }

  Future<int> _syncBoards() async {
    try {
      final unsyncedBoards = await boardRepository.getUnsyncedBoards();
      _logger.d('Found ${unsyncedBoards.length} unsynced boards');

      var syncedCount = 0;
      for (final board in unsyncedBoards) {
        try {
          await boardRepository.syncBoard(board);
          syncedCount++;
          _logger.d('Synced board: ${board.name}');
        } catch (e) {
          _logger.w('Failed to sync board ${board.id}: $e');
          // Continue with other boards even if one fails
        }
      }

      // Fetch and update with latest data from server
      try {
        final user = await authRepository.getCurrentUser();
        if (user != null) {
          await boardRepository.refreshBoardsFromRemote();
        }
      } catch (e) {
        _logger.w('Failed to refresh boards from remote: $e');
      }

      return syncedCount;
    } catch (e) {
      _logger.e('Board sync failed: $e');
      rethrow;
    }
  }

  Future<int> _syncTasks() async {
    try {
      final unsyncedTasks = await taskRepository.getUnsyncedTasks();
      _logger.d('Found ${unsyncedTasks.length} unsynced tasks');

      var syncedCount = 0;
      for (final task in unsyncedTasks) {
        try {
          await taskRepository.syncTask(task);
          syncedCount++;
          _logger.d('Synced task: ${task.title}');
        } catch (e) {
          _logger.w('Failed to sync task ${task.id}: $e');
          // Continue with other tasks even if one fails
        }
      }

      // Fetch and update with latest data from server
      try {
        final user = await authRepository.getCurrentUser();
        if (user != null) {
          await taskRepository.refreshTasksFromRemote();
        }
      } catch (e) {
        _logger.w('Failed to refresh tasks from remote: $e');
      }

      return syncedCount;
    } catch (e) {
      _logger.e('Task sync failed: $e');
      rethrow;
    }
  }

  Future<void> forceSyncBoard(String boardId) async {
    if (connectivityService.isOffline) {
      throw Exception('Cannot sync while offline');
    }

    try {
      final board = await boardRepository.getBoardById(boardId);
      if (board != null) {
        await boardRepository.syncBoard(board);
        _logger.i('Force synced board: ${board.name}');
      }
    } catch (e) {
      _logger.e('Force sync board failed: $e');
      rethrow;
    }
  }

  Future<void> forceSyncTask(String taskId) async {
    if (connectivityService.isOffline) {
      throw Exception('Cannot sync while offline');
    }

    try {
      final task = await taskRepository.getTaskById(taskId);
      if (task != null) {
        await taskRepository.syncTask(task);
        _logger.i('Force synced task: ${task.title}');
      }
    } catch (e) {
      _logger.e('Force sync task failed: $e');
      rethrow;
    }
  }

  // Handle conflict resolution
  Future<void> resolveConflicts() async {
    try {
      _logger.i('Resolving conflicts...');

      // Simple conflict resolution strategy: last write wins
      // In production, you might want more sophisticated conflict resolution

      await boardRepository.resolveConflicts();
      await taskRepository.resolveConflicts();

      _logger.i('Conflicts resolved successfully');
    } catch (e) {
      _logger.e('Conflict resolution failed: $e');
      rethrow;
    }
  }

  // Cleanup old synced items
  Future<void> cleanupOldData() async {
    try {
      final cutoffDate = DateTime.now().subtract(const Duration(days: 30));

      // Clean up old completed tasks
      await taskRepository.cleanupOldTasks(cutoffDate);

      // Clean up archived boards
      await boardRepository.cleanupArchivedBoards(cutoffDate);

      _logger.i('Cleanup completed');
    } catch (e) {
      _logger.e('Cleanup failed: $e');
      rethrow;
    }
  }

  void dispose() {
    _periodicSyncTimer?.cancel();
    _syncController.close();
  }
}

// Riverpod providers
final syncServiceProvider = Provider<SyncService>((ref) {
  final authRepo = ref.watch(di.authRepositoryProvider);
  final boardRepo = ref.watch(di.boardRepositoryProvider);
  final taskRepo = ref.watch(di.taskRepositoryProvider);
  final connectivity = ref.watch(connectivityServiceProvider);

  final service = SyncService(
    authRepository: authRepo,
    boardRepository: boardRepo,
    taskRepository: taskRepo,
    connectivityService: connectivity,
  );

  ref.onDispose(service.dispose);
  return service;
});

final syncStatusProvider = StreamProvider<SyncResult>((ref) {
  final syncService = ref.watch(syncServiceProvider);
  return syncService.syncStream;
});
