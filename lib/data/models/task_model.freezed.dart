// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskModel {
  String get id;
  String get title;
  String get description;
  String get boardId;
  String? get assignedToId;
  TaskStatus get status;
  TaskPriority get priority;
  DateTime? get dueDate;
  List<String> get tags;
  List<String> get attachments;
  List<String> get comments;
  DateTime? get createdAt;
  DateTime? get updatedAt;
  DateTime? get lastSynced;
  bool get needsSync;

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TaskModelCopyWith<TaskModel> get copyWith =>
      _$TaskModelCopyWithImpl<TaskModel>(this as TaskModel, _$identity);

  /// Serializes this TaskModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TaskModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.boardId, boardId) || other.boardId == boardId) &&
            (identical(other.assignedToId, assignedToId) ||
                other.assignedToId == assignedToId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            const DeepCollectionEquality()
                .equals(other.attachments, attachments) &&
            const DeepCollectionEquality().equals(other.comments, comments) &&
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
      title,
      description,
      boardId,
      assignedToId,
      status,
      priority,
      dueDate,
      const DeepCollectionEquality().hash(tags),
      const DeepCollectionEquality().hash(attachments),
      const DeepCollectionEquality().hash(comments),
      createdAt,
      updatedAt,
      lastSynced,
      needsSync);

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, description: $description, boardId: $boardId, assignedToId: $assignedToId, status: $status, priority: $priority, dueDate: $dueDate, tags: $tags, attachments: $attachments, comments: $comments, createdAt: $createdAt, updatedAt: $updatedAt, lastSynced: $lastSynced, needsSync: $needsSync)';
  }
}

/// @nodoc
abstract mixin class $TaskModelCopyWith<$Res> {
  factory $TaskModelCopyWith(TaskModel value, $Res Function(TaskModel) _then) =
      _$TaskModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String boardId,
      String? assignedToId,
      TaskStatus status,
      TaskPriority priority,
      DateTime? dueDate,
      List<String> tags,
      List<String> attachments,
      List<String> comments,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? lastSynced,
      bool needsSync});
}

/// @nodoc
class _$TaskModelCopyWithImpl<$Res> implements $TaskModelCopyWith<$Res> {
  _$TaskModelCopyWithImpl(this._self, this._then);

  final TaskModel _self;
  final $Res Function(TaskModel) _then;

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? boardId = null,
    Object? assignedToId = freezed,
    Object? status = null,
    Object? priority = null,
    Object? dueDate = freezed,
    Object? tags = null,
    Object? attachments = null,
    Object? comments = null,
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
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      boardId: null == boardId
          ? _self.boardId
          : boardId // ignore: cast_nullable_to_non_nullable
              as String,
      assignedToId: freezed == assignedToId
          ? _self.assignedToId
          : assignedToId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as TaskStatus,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TaskPriority,
      dueDate: freezed == dueDate
          ? _self.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tags: null == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      attachments: null == attachments
          ? _self.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      comments: null == comments
          ? _self.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<String>,
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

/// Adds pattern-matching-related methods to [TaskModel].
extension TaskModelPatterns on TaskModel {
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
    TResult Function(_TaskModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TaskModel() when $default != null:
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
    TResult Function(_TaskModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TaskModel():
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
    TResult? Function(_TaskModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TaskModel() when $default != null:
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
            String title,
            String description,
            String boardId,
            String? assignedToId,
            TaskStatus status,
            TaskPriority priority,
            DateTime? dueDate,
            List<String> tags,
            List<String> attachments,
            List<String> comments,
            DateTime? createdAt,
            DateTime? updatedAt,
            DateTime? lastSynced,
            bool needsSync)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TaskModel() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.description,
            _that.boardId,
            _that.assignedToId,
            _that.status,
            _that.priority,
            _that.dueDate,
            _that.tags,
            _that.attachments,
            _that.comments,
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
            String title,
            String description,
            String boardId,
            String? assignedToId,
            TaskStatus status,
            TaskPriority priority,
            DateTime? dueDate,
            List<String> tags,
            List<String> attachments,
            List<String> comments,
            DateTime? createdAt,
            DateTime? updatedAt,
            DateTime? lastSynced,
            bool needsSync)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TaskModel():
        return $default(
            _that.id,
            _that.title,
            _that.description,
            _that.boardId,
            _that.assignedToId,
            _that.status,
            _that.priority,
            _that.dueDate,
            _that.tags,
            _that.attachments,
            _that.comments,
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
            String title,
            String description,
            String boardId,
            String? assignedToId,
            TaskStatus status,
            TaskPriority priority,
            DateTime? dueDate,
            List<String> tags,
            List<String> attachments,
            List<String> comments,
            DateTime? createdAt,
            DateTime? updatedAt,
            DateTime? lastSynced,
            bool needsSync)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TaskModel() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.description,
            _that.boardId,
            _that.assignedToId,
            _that.status,
            _that.priority,
            _that.dueDate,
            _that.tags,
            _that.attachments,
            _that.comments,
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
class _TaskModel implements TaskModel {
  const _TaskModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.boardId,
      this.assignedToId,
      this.status = TaskStatus.todo,
      this.priority = TaskPriority.none,
      this.dueDate,
      final List<String> tags = const [],
      final List<String> attachments = const [],
      final List<String> comments = const [],
      this.createdAt,
      this.updatedAt,
      this.lastSynced,
      this.needsSync = false})
      : _tags = tags,
        _attachments = attachments,
        _comments = comments;
  factory _TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String boardId;
  @override
  final String? assignedToId;
  @override
  @JsonKey()
  final TaskStatus status;
  @override
  @JsonKey()
  final TaskPriority priority;
  @override
  final DateTime? dueDate;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<String> _attachments;
  @override
  @JsonKey()
  List<String> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  final List<String> _comments;
  @override
  @JsonKey()
  List<String> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? lastSynced;
  @override
  @JsonKey()
  final bool needsSync;

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TaskModelCopyWith<_TaskModel> get copyWith =>
      __$TaskModelCopyWithImpl<_TaskModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TaskModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TaskModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.boardId, boardId) || other.boardId == boardId) &&
            (identical(other.assignedToId, assignedToId) ||
                other.assignedToId == assignedToId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            const DeepCollectionEquality().equals(other._comments, _comments) &&
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
      title,
      description,
      boardId,
      assignedToId,
      status,
      priority,
      dueDate,
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_attachments),
      const DeepCollectionEquality().hash(_comments),
      createdAt,
      updatedAt,
      lastSynced,
      needsSync);

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, description: $description, boardId: $boardId, assignedToId: $assignedToId, status: $status, priority: $priority, dueDate: $dueDate, tags: $tags, attachments: $attachments, comments: $comments, createdAt: $createdAt, updatedAt: $updatedAt, lastSynced: $lastSynced, needsSync: $needsSync)';
  }
}

/// @nodoc
abstract mixin class _$TaskModelCopyWith<$Res>
    implements $TaskModelCopyWith<$Res> {
  factory _$TaskModelCopyWith(
          _TaskModel value, $Res Function(_TaskModel) _then) =
      __$TaskModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String boardId,
      String? assignedToId,
      TaskStatus status,
      TaskPriority priority,
      DateTime? dueDate,
      List<String> tags,
      List<String> attachments,
      List<String> comments,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? lastSynced,
      bool needsSync});
}

/// @nodoc
class __$TaskModelCopyWithImpl<$Res> implements _$TaskModelCopyWith<$Res> {
  __$TaskModelCopyWithImpl(this._self, this._then);

  final _TaskModel _self;
  final $Res Function(_TaskModel) _then;

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? boardId = null,
    Object? assignedToId = freezed,
    Object? status = null,
    Object? priority = null,
    Object? dueDate = freezed,
    Object? tags = null,
    Object? attachments = null,
    Object? comments = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastSynced = freezed,
    Object? needsSync = null,
  }) {
    return _then(_TaskModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      boardId: null == boardId
          ? _self.boardId
          : boardId // ignore: cast_nullable_to_non_nullable
              as String,
      assignedToId: freezed == assignedToId
          ? _self.assignedToId
          : assignedToId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as TaskStatus,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TaskPriority,
      dueDate: freezed == dueDate
          ? _self.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tags: null == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      attachments: null == attachments
          ? _self._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      comments: null == comments
          ? _self._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
