import 'package:flowdeck/data/models/board_model.dart';

abstract class BoardRepository {
  // Local operations
  Future<List<BoardModel>> getBoards({String? userId});

  Future<BoardModel?> getBoardById(String id);

  Future<BoardModel> createBoard(BoardModel board);

  Future<BoardModel> updateBoard(BoardModel board);

  Future<void> deleteBoard(String id);

  Future<List<BoardModel>> searchBoards({
    required String query,
    String? userId,
  });

  // Remote sync operations
  Future<void> syncBoard(BoardModel board);

  Future<List<BoardModel>> getUnsyncedBoards();

  Future<void> refreshBoardsFromRemote();

  Future<void> resolveConflicts();

  Future<void> cleanupArchivedBoards(DateTime cutoffDate);

  // Real-time operations
  Stream<List<BoardModel>> getBoardsStream({String? userId});

  Stream<BoardModel?> getBoardStream(String id);

  // Collaborative operations
  Future<void> addMemberToBoard(String boardId, String userId);

  Future<void> removeMemberFromBoard(String boardId, String userId);

  Future<List<BoardModel>> getBoardsForUser(String userId);
}
