import 'package:flowdeck/data/models/user_model.dart';
import 'package:flowdeck/data/models/auth_state.dart';

abstract class AuthRepository {
  Future<AuthState> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<AuthState> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });

  Future<void> signOut();

  Future<void> sendPasswordResetEmail({required String email});

  Future<void> sendEmailVerification();

  Future<UserModel?> getCurrentUser();

  Stream<AuthState> get authStateChanges;

  Future<void> updateUser(UserModel user);

  Future<void> deleteAccount();
}
