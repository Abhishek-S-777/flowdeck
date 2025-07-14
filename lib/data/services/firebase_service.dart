import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flowdeck/core/config/app_config.dart';
import 'package:flowdeck/data/models/user_model.dart';
import 'package:flowdeck/data/models/board_model.dart';
import 'package:flowdeck/data/models/task_model.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // Auth methods
  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

  Future<void> sendPasswordResetEmail({required String email}) =>
      _auth.sendPasswordResetEmail(email: email);

  Future<void> signOut() => _auth.signOut();

  Future<void> sendEmailVerification() =>
      currentUser?.sendEmailVerification() ?? Future.value();

  // Firestore Users
  CollectionReference<Map<String, dynamic>> get usersCollection =>
      _firestore.collection(AppConfig.usersCollection);

  Future<void> createUserDocument(UserModel user) =>
      usersCollection.doc(user.id).set(user.toJson());

  Future<void> updateUserDocument(UserModel user) =>
      usersCollection.doc(user.id).update(user.toJson());

  Future<UserModel?> getUserDocument(String userId) async {
    final doc = await usersCollection.doc(userId).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }

  Stream<UserModel?> userDocumentStream(String userId) =>
      usersCollection.doc(userId).snapshots().map((doc) {
        if (doc.exists) {
          return UserModel.fromJson(doc.data()!);
        }
        return null;
      });

  // Firestore Boards
  CollectionReference<Map<String, dynamic>> get boardsCollection =>
      _firestore.collection(AppConfig.boardsCollection);

  Future<void> createBoard(BoardModel board) =>
      boardsCollection.doc(board.id).set(board.toJson());

  Future<void> updateBoard(BoardModel board) =>
      boardsCollection.doc(board.id).update(board.toJson());

  Future<void> deleteBoard(String boardId) =>
      boardsCollection.doc(boardId).delete();

  Future<BoardModel?> getBoard(String boardId) async {
    final doc = await boardsCollection.doc(boardId).get();
    if (doc.exists) {
      return BoardModel.fromJson(doc.data()!);
    }
    return null;
  }

  Stream<List<BoardModel>> getBoardsStream({String? userId}) {
    Query<Map<String, dynamic>> query = boardsCollection;

    if (userId != null) {
      query = query.where(Filter.or(
        Filter('ownerId', isEqualTo: userId),
        Filter('memberIds', arrayContains: userId),
      ),);
    }

    return query.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => BoardModel.fromJson(doc.data())).toList(),);
  }

  Future<List<BoardModel>> searchBoards({
    required String query,
    String? userId,
    int limit = AppConfig.defaultPageSize,
  }) async {
    Query<Map<String, dynamic>> firestoreQuery = boardsCollection;

    if (userId != null) {
      firestoreQuery = firestoreQuery.where(Filter.or(
        Filter('ownerId', isEqualTo: userId),
        Filter('memberIds', arrayContains: userId),
      ),);
    }

    // Note: Firestore doesn't support full-text search natively
    // In production, you would use Algolia, Elasticsearch, or similar
    firestoreQuery = firestoreQuery
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: '$query\uf8ff')
        .limit(limit);

    final snapshot = await firestoreQuery.get();
    return snapshot.docs.map((doc) => BoardModel.fromJson(doc.data())).toList();
  }

  // Firestore Tasks
  CollectionReference<Map<String, dynamic>> get tasksCollection =>
      _firestore.collection(AppConfig.tasksCollection);

  Future<void> createTask(TaskModel task) =>
      tasksCollection.doc(task.id).set(task.toJson());

  Future<void> updateTask(TaskModel task) =>
      tasksCollection.doc(task.id).update(task.toJson());

  Future<void> deleteTask(String taskId) =>
      tasksCollection.doc(taskId).delete();

  Future<TaskModel?> getTask(String taskId) async {
    final doc = await tasksCollection.doc(taskId).get();
    if (doc.exists) {
      return TaskModel.fromJson(doc.data()!);
    }
    return null;
  }

  Stream<List<TaskModel>> getTasksStream({
    String? boardId,
    String? assignedToId,
    TaskStatus? status,
    TaskPriority? priority,
  }) {
    Query<Map<String, dynamic>> query = tasksCollection;

    if (boardId != null) {
      query = query.where('boardId', isEqualTo: boardId);
    }

    if (assignedToId != null) {
      query = query.where('assignedToId', isEqualTo: assignedToId);
    }

    if (status != null) {
      query = query.where('status', isEqualTo: status.name);
    }

    if (priority != null) {
      query = query.where('priority', isEqualTo: priority.name);
    }

    return query.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => TaskModel.fromJson(doc.data())).toList(),);
  }

  Future<List<TaskModel>> searchTasks({
    required String query,
    String? boardId,
    String? assignedToId,
    int limit = AppConfig.defaultPageSize,
  }) async {
    Query<Map<String, dynamic>> firestoreQuery = tasksCollection;

    if (boardId != null) {
      firestoreQuery = firestoreQuery.where('boardId', isEqualTo: boardId);
    }

    if (assignedToId != null) {
      firestoreQuery =
          firestoreQuery.where('assignedToId', isEqualTo: assignedToId);
    }

    // Note: Full-text search would require external search service
    firestoreQuery = firestoreQuery
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThanOrEqualTo: '$query\uf8ff')
        .limit(limit);

    final snapshot = await firestoreQuery.get();
    return snapshot.docs.map((doc) => TaskModel.fromJson(doc.data())).toList();
  }

  // Firebase Messaging
  Future<String?> getFCMToken() => _messaging.getToken();

  Future<void> subscribeToTopic(String topic) =>
      _messaging.subscribeToTopic(topic);

  Future<void> unsubscribeFromTopic(String topic) =>
      _messaging.unsubscribeFromTopic(topic);

  void onMessage(Function(RemoteMessage) handler) {
    FirebaseMessaging.onMessage.listen(handler);
  }

  void onMessageOpenedApp(Function(RemoteMessage) handler) {
    FirebaseMessaging.onMessageOpenedApp.listen(handler);
  }

  Future<void> requestNotificationPermission() async {
    final settings = await _messaging.requestPermission(
      
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('User granted provisional permission');
      }
    } else {
      if (kDebugMode) {
        print('User declined or has not accepted permission');
      }
    }
  }

  // Batch operations
  WriteBatch batch() => _firestore.batch();

  Future<void> commitBatch(WriteBatch batch) => batch.commit();

  // Transactions
  Future<T> runTransaction<T>(
    TransactionHandler<T> updateFunction, {
    Duration timeout = const Duration(seconds: 30),
  }) =>
      _firestore.runTransaction(updateFunction, timeout: timeout);
}
