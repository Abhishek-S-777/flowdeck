import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:logger/logger.dart';
import 'package:drift/drift.dart';

import 'package:flowdeck/domain/repositories/auth_repository.dart';
import 'package:flowdeck/data/models/user_model.dart';
import 'package:flowdeck/data/models/auth_state.dart';
import 'package:flowdeck/data/datasources/local/app_database.dart';
import 'package:flowdeck/data/services/firebase_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.firebaseService,
    required this.database,
    required this.logger,
  });
  final FirebaseService firebaseService;
  final AppDatabase database;
  final Logger logger;

  @override
  Stream<AuthState> get authStateChanges =>
      firebaseService.authStateChanges.asyncMap((user) async {
        if (user == null) {
          return const AuthState();
        }

        try {
          // Get user data from Firestore
          UserModel? userModel =
              await firebaseService.getUserDocument(user.uid);

          if (userModel == null) {
            // Create user document if it doesn't exist
            userModel = UserModel(
              id: user.uid,
              email: user.email ?? '',
              firstName: user.displayName?.split(' ').first ?? '',
              lastName: user.displayName?.split(' ').skip(1).join(' ') ?? '',
              isEmailVerified: user.emailVerified,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            );

            await firebaseService.createUserDocument(userModel);
          }

          // Cache user locally
          await _cacheUserLocally(userModel);

          return AuthState(
            isAuthenticated: true,
            user: userModel,
          );
        } catch (e) {
          logger.e('Error in auth state changes', error: e);
          return AuthState(
            error: e.toString(),
          );
        }
      });

  @override
  Future<AuthState> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        return const AuthState(
          error: 'Sign in failed',
        );
      }

      final userModel = await firebaseService.getUserDocument(user.uid);
      if (userModel != null) {
        await _cacheUserLocally(userModel);
      }

      return AuthState(
        isAuthenticated: true,
        user: userModel,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      logger.e('Sign in error', error: e);
      return AuthState(
        error: _getFirebaseErrorMessage(e),
      );
    } catch (e) {
      logger.e('Sign in error', error: e);
      return const AuthState(
        error: 'An unexpected error occurred',
      );
    }
  }

  @override
  Future<AuthState> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final credential = await firebaseService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        return const AuthState(
          error: 'Account creation failed',
        );
      }

      // Create user document
      final userModel = UserModel(
        id: user.uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        isEmailVerified: user.emailVerified,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await firebaseService.createUserDocument(userModel);
      await _cacheUserLocally(userModel);

      // Send email verification
      await firebaseService.sendEmailVerification();

      return AuthState(
        isAuthenticated: true,
        user: userModel,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      logger.e('Sign up error', error: e);
      return AuthState(
        error: _getFirebaseErrorMessage(e),
      );
    } catch (e) {
      logger.e('Sign up error', error: e);
      return const AuthState(
        error: 'An unexpected error occurred',
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseService.signOut();
      // Clear local cache
      await _clearLocalCache();
    } catch (e) {
      logger.e('Sign out error', error: e);
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await firebaseService.sendPasswordResetEmail(email: email);
    } catch (e) {
      logger.e('Password reset error', error: e);
      rethrow;
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      await firebaseService.sendEmailVerification();
    } catch (e) {
      logger.e('Email verification error', error: e);
      rethrow;
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final firebaseUser = firebaseService.currentUser;
      if (firebaseUser == null) return null;

      // Try to get from local cache first
      final localUser = await database.getUserById(firebaseUser.uid);
      if (localUser != null) {
        return _userFromEntity(localUser);
      }

      // Fetch from remote
      final userModel = await firebaseService.getUserDocument(firebaseUser.uid);
      if (userModel != null) {
        await _cacheUserLocally(userModel);
      }

      return userModel;
    } catch (e) {
      logger.e('Get current user error', error: e);
      return null;
    }
  }

  @override
  Future<void> updateUser(UserModel user) async {
    try {
      final updatedUser = user.copyWith(updatedAt: DateTime.now());

      // Update in Firestore
      await firebaseService.updateUserDocument(updatedUser);

      // Update local cache
      await _cacheUserLocally(updatedUser);
    } catch (e) {
      logger.e('Update user error', error: e);
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = firebaseService.currentUser;
      if (user == null) return;

      // Delete user data from Firestore
      // Note: In production, you might want to anonymize data instead
      await firebaseService.usersCollection.doc(user.uid).delete();

      // Delete from local cache
      await database.deleteUser(user.uid);

      // Delete Firebase Auth account
      await user.delete();
    } catch (e) {
      logger.e('Delete account error', error: e);
      rethrow;
    }
  }

  // Helper methods
  Future<void> _cacheUserLocally(UserModel user) async {
    try {
      await database.insertUser(_userToCompanion(user));
    } catch (e) {
      logger.w('Failed to cache user locally', error: e);
    }
  }

  Future<void> _clearLocalCache() async {
    try {
      final user = firebaseService.currentUser;
      if (user != null) {
        await database.deleteUser(user.uid);
      }
    } catch (e) {
      logger.w('Failed to clear local cache', error: e);
    }
  }

  String _getFirebaseErrorMessage(firebase_auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found with this email address.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return e.message ?? 'An error occurred. Please try again.';
    }
  }

  UserModel _userFromEntity(User entity) => UserModel(
        id: entity.id,
        email: entity.email,
        firstName: entity.firstName,
        lastName: entity.lastName,
        avatarUrl: entity.avatarUrl,
        isEmailVerified: entity.isEmailVerified,
        boardIds:
            entity.boardIds.split(',').where((id) => id.isNotEmpty).toList(),
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

  UsersCompanion _userToCompanion(UserModel user) => UsersCompanion.insert(
        id: user.id,
        email: user.email,
        firstName: user.firstName,
        lastName: user.lastName,
        avatarUrl: Value.absentIfNull(user.avatarUrl),
        isEmailVerified: Value(user.isEmailVerified),
        boardIds: Value(user.boardIds.join(',')),
        createdAt: Value.absentIfNull(user.createdAt),
        updatedAt: Value.absentIfNull(user.updatedAt),
      );
}
