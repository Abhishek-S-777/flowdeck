import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_model.freezed.dart';
part 'board_model.g.dart';

@freezed
abstract class BoardModel with _$BoardModel {
  const factory BoardModel({
    required String id,
    required String name,
    required String description,
    required String ownerId,
    @Default([]) List<String> memberIds,
    @Default([]) List<String> taskIds,
    String? color,
    @Default(false) bool isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastSynced,
    @Default(false) bool needsSync,
  }) = _BoardModel;

  factory BoardModel.fromJson(Map<String, dynamic> json) =>
      _$BoardModelFromJson(json);
}

extension BoardModelX on BoardModel {
  bool get isEmpty => taskIds.isEmpty;

  int get taskCount => taskIds.length;

  bool get hasMembers => memberIds.isNotEmpty;

  int get memberCount => memberIds.length;
}
