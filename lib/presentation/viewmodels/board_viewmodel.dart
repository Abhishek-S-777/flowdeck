import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flowdeck/data/models/board_model.dart';

part 'board_viewmodel.g.dart';

@riverpod
class BoardsViewModel extends _$BoardsViewModel {
  @override
  List<BoardModel> build() {
    return [];
  }

  void addBoard(BoardModel board) {
    state = [...state, board];
  }

  void removeBoard(String id) {
    state = state.where((board) => board.id != id).toList();
  }

  void updateBoard(BoardModel updatedBoard) {
    state = state.map((board) {
      return board.id == updatedBoard.id ? updatedBoard : board;
    }).toList();
  }
}

@riverpod
class BoardSearchQuery extends _$BoardSearchQuery {
  @override
  String build() {
    return '';
  }

  void updateQuery(String query) {
    state = query;
  }
}
