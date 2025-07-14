import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:drift/drift.dart';

import 'package:flowdeck/domain/repositories/board_repository.dart';
import 'package:flowdeck/data/models/board_model.dart';
import 'package:flowdeck/data/datasources/local/app_database.dart';
import 'package:flowdeck/data/services/firebase_service.dart';

class BoardRepositoryImpl implements BoardRepository {
  BoardRepositoryImpl({
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
  Future<List<BoardModel>> getBoards({String? userId}) async {
    try {
      // Try to get from remote first
      final stream = _firebaseService.getBoardsStream(userId: userId);
      final remoteBoards = await stream.first;

      // Cache locally
      for (final board in remoteBoards) {
        await _database.insertBoard(_boardToCompanion(board));
      }

      return remoteBoards;
    } catch (e) {
      _logger.w('Failed to get boards from remote, falling back to local: $e');

      // Fallback to local data
      final localBoards = await _database.getAllBoards();
      return localBoards.map((board) => _boardFromEntity(board)).toList();
    }
  }

  @override
  Future<BoardModel?> getBoardById(String id) async {
    try {
      // Try remote first
      final remoteBoard = await _firebaseService.getBoard(id);
      if (remoteBoard != null) {
        // Cache locally
        await _database.insertBoard(_boardToCompanion(remoteBoard));
        return remoteBoard;
      }
    } catch (e) {
      _logger.w('Failed to get board from remote: $e');
    }

    // Fallback to local
    final localBoard = await _database.getBoardById(id);
    return localBoard != null ? _boardFromEntity(localBoard) : null;
  }

  @override
  Future<BoardModel> createBoard(BoardModel board) async {
    try {
      // Create remotely first
      await _firebaseService.createBoard(board);

      // Cache locally
      await _database.insertBoard(_boardToCompanion(board));

      return board;
    } catch (e) {
      _logger.e('Failed to create board: $e');
      rethrow;
    }
  }

  @override
  Future<BoardModel> updateBoard(BoardModel board) async {
    try {
      // Update remotely first
      await _firebaseService.updateBoard(board);

      // Update locally
      await _database.updateBoard(_boardModelToEntity(board));

      return board;
    } catch (e) {
      _logger.e('Failed to update board: $e');

      // Update locally anyway for offline capability
      await _database.updateBoard(_boardModelToEntity(board));
      return board;
    }
  }

  @override
  Future<void> deleteBoard(String id) async {
    try {
      // Delete remotely first
      await _firebaseService.deleteBoard(id);

      // Delete locally
      await _database.deleteBoard(id);
    } catch (e) {
      _logger.e('Failed to delete board: $e');

      // Delete locally anyway
      await _database.deleteBoard(id);
    }
  }

  @override
  Future<List<BoardModel>> searchBoards({
    required String query,
    String? userId,
  }) async {
    try {
      // Try remote search first
      final remoteBoards = await _firebaseService.searchBoards(
        query: query,
        userId: userId,
      );

      // Cache results locally
      for (final board in remoteBoards) {
        await _database.insertBoard(_boardToCompanion(board));
      }

      return remoteBoards;
    } catch (e) {
      _logger.w('Failed to search boards remotely, falling back to local: $e');

      // Fallback to local search
      final localBoards = await _database.searchBoards(query);
      return localBoards.map((board) => _boardFromEntity(board)).toList();
    }
  }

  @override
  Future<void> syncBoard(BoardModel board) async {
    try {
      await _firebaseService.updateBoard(board);
      await _database.updateBoard(_boardModelToEntity(board));
    } catch (e) {
      _logger.e('Failed to sync board: $e');
      rethrow;
    }
  }

  @override
  Future<List<BoardModel>> getUnsyncedBoards() async {
    final localBoards = await _database.getUnsyncedBoards();
    return localBoards.map((board) => _boardFromEntity(board)).toList();
  }

  @override
  Future<void> refreshBoardsFromRemote() async {
    try {
      final stream = _firebaseService.getBoardsStream();
      final remoteBoards = await stream.first;

      // Clear local cache and repopulate
      await _database.clearBoards();
      for (final board in remoteBoards) {
        await _database.insertBoard(_boardToCompanion(board));
      }
    } catch (e) {
      _logger.e('Failed to refresh boards from remote: $e');
      rethrow;
    }
  }

  @override
  Future<void> resolveConflicts() async {
    // Implementation for conflict resolution
    final unsyncedBoards = await getUnsyncedBoards();

    for (final board in unsyncedBoards) {
      try {
        await syncBoard(board);
      } catch (e) {
        _logger.w('Failed to resolve conflict for board ${board.id}: $e');
      }
    }
  }

  @override
  Future<void> cleanupArchivedBoards(DateTime cutoffDate) async {
    await _database.cleanupArchivedBoards();
  }

  @override
  Stream<List<BoardModel>> getBoardsStream({String? userId}) {
    return _firebaseService.getBoardsStream(userId: userId);
  }

  @override
  Stream<BoardModel?> getBoardStream(String id) {
    // Firebase doesn't have single board stream, so we'll implement with periodic checks
    return Stream.periodic(const Duration(seconds: 30), (_) async {
      return await getBoardById(id);
    }).asyncMap((future) => future);
  }

  @override
  Future<void> addMemberToBoard(String boardId, String userId) async {
    final board = await getBoardById(boardId);
    if (board != null) {
      final updatedBoard = board.copyWith(
        memberIds: [...board.memberIds, userId],
        updatedAt: DateTime.now(),
      );
      await updateBoard(updatedBoard);
    }
  }

  @override
  Future<void> removeMemberFromBoard(String boardId, String userId) async {
    final board = await getBoardById(boardId);
    if (board != null) {
      final updatedMemberIds =
          board.memberIds.where((id) => id != userId).toList();
      final updatedBoard = board.copyWith(
        memberIds: updatedMemberIds,
        updatedAt: DateTime.now(),
      );
      await updateBoard(updatedBoard);
    }
  }

  @override
  Future<List<BoardModel>> getBoardsForUser(String userId) async {
    return getBoards(userId: userId);
  }

  // Helper methods
  BoardsCompanion _boardToCompanion(BoardModel board) => BoardsCompanion.insert(
        id: board.id,
        name: board.name,
        description: board.description,
        ownerId: board.ownerId,
        memberIds: Value(jsonEncode(board.memberIds)),
        taskIds: Value(jsonEncode(board.taskIds)),
        color: Value.absentIfNull(board.color),
        isArchived: Value(board.isArchived),
        createdAt: Value.absentIfNull(board.createdAt),
        updatedAt: Value.absentIfNull(board.updatedAt),
        lastSynced: Value.absentIfNull(board.lastSynced),
        needsSync: Value(board.needsSync),
      );

  Board _boardModelToEntity(BoardModel board) => Board(
        id: board.id,
        name: board.name,
        description: board.description,
        ownerId: board.ownerId,
        memberIds: jsonEncode(board.memberIds),
        taskIds: jsonEncode(board.taskIds),
        color: board.color,
        isArchived: board.isArchived,
        createdAt: board.createdAt,
        updatedAt: board.updatedAt,
        lastSynced: board.lastSynced,
        needsSync: board.needsSync,
      );

  BoardModel _boardFromEntity(Board board) => BoardModel(
        id: board.id,
        name: board.name,
        description: board.description,
        color: board.color,
        ownerId: board.ownerId,
        memberIds: jsonDecode(board.memberIds).cast<String>(),
        taskIds: jsonDecode(board.taskIds).cast<String>(),
        isArchived: board.isArchived,
        createdAt: board.createdAt,
        updatedAt: board.updatedAt,
        lastSynced: board.lastSynced,
        needsSync: board.needsSync,
      );
}
