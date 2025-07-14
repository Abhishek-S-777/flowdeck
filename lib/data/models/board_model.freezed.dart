// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BoardModel {
  String get id;
  String get name;
  String get description;
  String get ownerId;
  List<String> get memberIds;
  List<String> get taskIds;
  String? get color;
  bool get isArchived;
  DateTime? get createdAt;
  DateTime? get updatedAt;
  DateTime? get lastSynced;
  bool get needsSync;

  /// Create a copy of BoardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BoardModelCopyWith<BoardModel> get copyWith =>
      _$BoardModelCopyWithImpl<BoardModel>(this as BoardModel, _$identity);

  /// Serializes this BoardModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BoardModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            const DeepCollectionEquality().equals(other.memberIds, memberIds) &&
            const DeepCollectionEquality().equals(other.taskIds, taskIds) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.isArchived, isArchived) ||
                other.isArchived == isArchived) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastSynced, lastSynced) ||
                other.lastSynced == lastSynced) &&
            (identical(other.needsSync, needsSync) ||
                other.needsSync == needsSync));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      ownerId,
      const DeepCollectionEquality().hash(memberIds),
      const DeepCollectionEquality().hash(taskIds),
      color,
      isArchived,
      createdAt,
      updatedAt,
      lastSynced,
      needsSync);

  @override
  String toString() {
    return 'BoardModel(id: $id, name: $name, description: $description, ownerId: $ownerId, memberIds: $memberIds, taskIds: $taskIds, color: $color, isArchived: $isArchived, createdAt: $createdAt, updatedAt: $updatedAt, lastSynced: $lastSynced, needsSync: $needsSync)';
  }
}

/// @nodoc
abstract mixin class $BoardModelCopyWith<$Res> {
  factory $BoardModelCopyWith(
          BoardModel value, $Res Function(BoardModel) _then) =
      _$BoardModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String ownerId,
      List<String> memberIds,
      List<String> taskIds,
      String? color,
      bool isArchived,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? lastSynced,
      bool needsSync});
}

/// @nodoc
class _$BoardModelCopyWithImpl<$Res> implements $BoardModelCopyWith<$Res> {
  _$BoardModelCopyWithImpl(this._self, this._then);

  final BoardModel _self;
  final $Res Function(BoardModel) _then;

  /// Create a copy of BoardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? ownerId = null,
    Object? memberIds = null,
    Object? taskIds = null,
    Object? color = freezed,
    Object? isArchived = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastSynced = freezed,
    Object? needsSync = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _self.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      memberIds: null == memberIds
          ? _self.memberIds
          : memberIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      taskIds: null == taskIds
          ? _self.taskIds
          : taskIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      color: freezed == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      isArchived: null == isArchived
          ? _self.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSynced: freezed == lastSynced
          ? _self.lastSynced
          : lastSynced // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      needsSync: null == needsSync
          ? _self.needsSync
          : needsSync // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [BoardModel].
extension BoardModelPatterns on BoardModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_BoardModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BoardModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_BoardModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BoardModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_BoardModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BoardModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            String description,
            String ownerId,
            List<String> memberIds,
            List<String> taskIds,
            String? color,
            bool isArchived,
            DateTime? createdAt,
            DateTime? updatedAt,
            DateTime? lastSynced,
            bool needsSync)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BoardModel() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.ownerId,
            _that.memberIds,
            _that.taskIds,
            _that.color,
            _that.isArchived,
            _that.createdAt,
            _that.updatedAt,
            _that.lastSynced,
            _that.needsSync);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            String description,
            String ownerId,
            List<String> memberIds,
            List<String> taskIds,
            String? color,
            bool isArchived,
            DateTime? createdAt,
            DateTime? updatedAt,
            DateTime? lastSynced,
            bool needsSync)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BoardModel():
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.ownerId,
            _that.memberIds,
            _that.taskIds,
            _that.color,
            _that.isArchived,
            _that.createdAt,
            _that.updatedAt,
            _that.lastSynced,
            _that.needsSync);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String name,
            String description,
            String ownerId,
            List<String> memberIds,
            List<String> taskIds,
            String? color,
            bool isArchived,
            DateTime? createdAt,
            DateTime? updatedAt,
            DateTime? lastSynced,
            bool needsSync)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BoardModel() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.ownerId,
            _that.memberIds,
            _that.taskIds,
            _that.color,
            _that.isArchived,
            _that.createdAt,
            _that.updatedAt,
            _that.lastSynced,
            _that.needsSync);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BoardModel implements BoardModel {
  const _BoardModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.ownerId,
      final List<String> memberIds = const [],
      final List<String> taskIds = const [],
      this.color,
      this.isArchived = false,
      this.createdAt,
      this.updatedAt,
      this.lastSynced,
      this.needsSync = false})
      : _memberIds = memberIds,
        _taskIds = taskIds;
  factory _BoardModel.fromJson(Map<String, dynamic> json) =>
      _$BoardModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String ownerId;
  final List<String> _memberIds;
  @override
  @JsonKey()
  List<String> get memberIds {
    if (_memberIds is EqualUnmodifiableListView) return _memberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memberIds);
  }

  final List<String> _taskIds;
  @override
  @JsonKey()
  List<String> get taskIds {
    if (_taskIds is EqualUnmodifiableListView) return _taskIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taskIds);
  }

  @override
  final String? color;
  @override
  @JsonKey()
  final bool isArchived;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? lastSynced;
  @override
  @JsonKey()
  final bool needsSync;

  /// Create a copy of BoardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BoardModelCopyWith<_BoardModel> get copyWith =>
      __$BoardModelCopyWithImpl<_BoardModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BoardModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BoardModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            const DeepCollectionEquality()
                .equals(other._memberIds, _memberIds) &&
            const DeepCollectionEquality().equals(other._taskIds, _taskIds) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.isArchived, isArchived) ||
                other.isArchived == isArchived) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastSynced, lastSynced) ||
                other.lastSynced == lastSynced) &&
            (identical(other.needsSync, needsSync) ||
                other.needsSync == needsSync));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      ownerId,
      const DeepCollectionEquality().hash(_memberIds),
      const DeepCollectionEquality().hash(_taskIds),
      color,
      isArchived,
      createdAt,
      updatedAt,
      lastSynced,
      needsSync);

  @override
  String toString() {
    return 'BoardModel(id: $id, name: $name, description: $description, ownerId: $ownerId, memberIds: $memberIds, taskIds: $taskIds, color: $color, isArchived: $isArchived, createdAt: $createdAt, updatedAt: $updatedAt, lastSynced: $lastSynced, needsSync: $needsSync)';
  }
}

/// @nodoc
abstract mixin class _$BoardModelCopyWith<$Res>
    implements $BoardModelCopyWith<$Res> {
  factory _$BoardModelCopyWith(
          _BoardModel value, $Res Function(_BoardModel) _then) =
      __$BoardModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String ownerId,
      List<String> memberIds,
      List<String> taskIds,
      String? color,
      bool isArchived,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? lastSynced,
      bool needsSync});
}

/// @nodoc
class __$BoardModelCopyWithImpl<$Res> implements _$BoardModelCopyWith<$Res> {
  __$BoardModelCopyWithImpl(this._self, this._then);

  final _BoardModel _self;
  final $Res Function(_BoardModel) _then;

  /// Create a copy of BoardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? ownerId = null,
    Object? memberIds = null,
    Object? taskIds = null,
    Object? color = freezed,
    Object? isArchived = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastSynced = freezed,
    Object? needsSync = null,
  }) {
    return _then(_BoardModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _self.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      memberIds: null == memberIds
          ? _self._memberIds
          : memberIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      taskIds: null == taskIds
          ? _self._taskIds
          : taskIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      color: freezed == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      isArchived: null == isArchived
          ? _self.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSynced: freezed == lastSynced
          ? _self.lastSynced
          : lastSynced // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      needsSync: null == needsSync
          ? _self.needsSync
          : needsSync // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
