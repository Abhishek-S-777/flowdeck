// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BoardModel _$BoardModelFromJson(Map<String, dynamic> json) => _BoardModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      ownerId: json['ownerId'] as String,
      memberIds: (json['memberIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      taskIds: (json['taskIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      color: json['color'] as String?,
      isArchived: json['isArchived'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      lastSynced: json['lastSynced'] == null
          ? null
          : DateTime.parse(json['lastSynced'] as String),
      needsSync: json['needsSync'] as bool? ?? false,
    );

Map<String, dynamic> _$BoardModelToJson(_BoardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'ownerId': instance.ownerId,
      'memberIds': instance.memberIds,
      'taskIds': instance.taskIds,
      'color': instance.color,
      'isArchived': instance.isArchived,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'lastSynced': instance.lastSynced?.toIso8601String(),
      'needsSync': instance.needsSync,
    };
