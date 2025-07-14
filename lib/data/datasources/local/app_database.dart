import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// Users Table
class Users extends Table {
  TextColumn get id => text()();
  TextColumn get email => text()();
  TextColumn get firstName => text().named('first_name')();
  TextColumn get lastName => text().named('last_name')();
  TextColumn get avatarUrl => text().named('avatar_url').nullable()();
  BoolColumn get isEmailVerified =>
      boolean().named('is_email_verified').withDefault(const Constant(false))();
  TextColumn get boardIds =>
      text().named('board_ids').withDefault(const Constant('[]'))();
  DateTimeColumn get createdAt => dateTime().named('created_at').nullable()();
  DateTimeColumn get updatedAt => dateTime().named('updated_at').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Boards Table
class Boards extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get ownerId => text().named('owner_id')();
  TextColumn get memberIds =>
      text().named('member_ids').withDefault(const Constant('[]'))();
  TextColumn get taskIds =>
      text().named('task_ids').withDefault(const Constant('[]'))();
  TextColumn get color => text().nullable()();
  BoolColumn get isArchived =>
      boolean().named('is_archived').withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().named('created_at').nullable()();
  DateTimeColumn get updatedAt => dateTime().named('updated_at').nullable()();
  DateTimeColumn get lastSynced => dateTime().named('last_synced').nullable()();
  BoolColumn get needsSync =>
      boolean().named('needs_sync').withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

// Tasks Table
class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get boardId => text().named('board_id')();
  TextColumn get assignedToId => text().named('assigned_to_id').nullable()();
  TextColumn get status => text().withDefault(const Constant('todo'))();
  TextColumn get priority => text().withDefault(const Constant('none'))();
  DateTimeColumn get dueDate => dateTime().named('due_date').nullable()();
  TextColumn get tags => text().withDefault(const Constant('[]'))();
  TextColumn get attachments => text().withDefault(const Constant('[]'))();
  TextColumn get comments => text().withDefault(const Constant('[]'))();
  DateTimeColumn get createdAt => dateTime().named('created_at').nullable()();
  DateTimeColumn get updatedAt => dateTime().named('updated_at').nullable()();
  DateTimeColumn get lastSynced => dateTime().named('last_synced').nullable()();
  BoolColumn get needsSync =>
      boolean().named('needs_sync').withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

// Database Class
@DriftDatabase(tables: [Users, Boards, Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Initialize database
  Future<void> init() async {
    // Trigger database creation
    await customSelect('SELECT 1').get();
  }

  // User DAO methods
  Future<List<User>> getAllUsers() => select(users).get();

  Future<User?> getUserById(String id) =>
      (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();

  Future<void> insertUser(UsersCompanion user) =>
      into(users).insert(user, mode: InsertMode.insertOrReplace);

  Future<void> updateUser(User user) => update(users).replace(user);

  Future<void> deleteUser(String id) =>
      (delete(users)..where((u) => u.id.equals(id))).go();

  // Board DAO methods
  Future<List<Board>> getAllBoards() => select(boards).get();

  Future<List<Board>> getBoardsForUser(String userId) => (select(boards)
        ..where((b) => b.ownerId.equals(userId) | b.memberIds.contains(userId)))
      .get();

  Future<Board?> getBoardById(String id) =>
      (select(boards)..where((b) => b.id.equals(id))).getSingleOrNull();

  Future<void> insertBoard(BoardsCompanion board) =>
      into(boards).insert(board, mode: InsertMode.insertOrReplace);

  Future<void> updateBoard(Board board) => update(boards).replace(board);

  Future<void> deleteBoard(String id) =>
      (delete(boards)..where((b) => b.id.equals(id))).go();

  Future<List<Board>> getUnsyncedBoards() =>
      (select(boards)..where((b) => b.needsSync.equals(true))).get();

  // Task DAO methods
  Future<List<Task>> getAllTasks() => select(tasks).get();

  Future<List<Task>> getTasksForBoard(String boardId) =>
      (select(tasks)..where((t) => t.boardId.equals(boardId))).get();

  Future<List<Task>> getTasksForUser(String userId) =>
      (select(tasks)..where((t) => t.assignedToId.equals(userId))).get();

  Future<Task?> getTaskById(String id) =>
      (select(tasks)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> insertTask(TasksCompanion task) =>
      into(tasks).insert(task, mode: InsertMode.insertOrReplace);

  Future<void> updateTask(Task task) => update(tasks).replace(task);

  Future<void> deleteTask(String id) =>
      (delete(tasks)..where((t) => t.id.equals(id))).go();

  Future<List<Task>> getUnsyncedTasks() =>
      (select(tasks)..where((t) => t.needsSync.equals(true))).get();

  Future<List<Task>> searchTasks(String query) => (select(tasks)
        ..where((t) => t.title.contains(query) | t.description.contains(query)))
      .get();

  // Sync methods
  Future<void> markBoardSynced(String id) =>
      (update(boards)..where((b) => b.id.equals(id))).write(BoardsCompanion(
        needsSync: const Value(false),
        lastSynced: Value(DateTime.now()),
      ),);

  Future<void> markTaskSynced(String id) =>
      (update(tasks)..where((t) => t.id.equals(id))).write(TasksCompanion(
        needsSync: const Value(false),
        lastSynced: Value(DateTime.now()),
      ),);

  Future<void> markBoardNeedsSync(String id) =>
      (update(boards)..where((b) => b.id.equals(id)))
          .write(const BoardsCompanion(needsSync: Value(true)));

  Future<void> markTaskNeedsSync(String id) =>
      (update(tasks)..where((t) => t.id.equals(id)))
          .write(const TasksCompanion(needsSync: Value(true)));

  // Additional Board methods
  Future<List<Board>> searchBoards(String query) => (select(boards)
        ..where((b) => b.name.contains(query) | b.description.contains(query)))
      .get();

  Future<void> clearBoards() => delete(boards).go();

  Future<void> cleanupArchivedBoards() =>
      (delete(boards)..where((b) => b.isArchived.equals(true))).go();
}

// Database connection
LazyDatabase _openConnection() => LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'task_manager.db'));
      return NativeDatabase.createInBackground(file);
    });
