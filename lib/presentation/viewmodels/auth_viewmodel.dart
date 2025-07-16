import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:flowdeck/core/di/injection_container.dart';
import 'package:flowdeck/data/models/auth_state.dart';
import 'package:flowdeck/data/models/user_model.dart';

part 'auth_viewmodel.g.dart';

@riverpod
Stream<firebase_auth.User?> authStateChanges(dynamic ref) {
  return firebase_auth.FirebaseAuth.instance
      .authStateChanges()
      .handleError((error) {
  });
}

@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  Stream<AuthState> build() {
    final authRepository = ref.watch(authRepositoryProvider);
    return authRepository.authStateChanges;
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    try {
      final userCredential =
          await firebase_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      state = AsyncValue.data(
        AuthState(
          user: UserModel(
            id: userCredential.user?.uid ?? '',
            email: userCredential.user?.email ?? '',
            firstName:
                userCredential.user?.displayName?.split(' ').first ?? 'Unknown',
            lastName: userCredential.user?.displayName?.split(' ').last ?? '',
          ),
          isAuthenticated: true,
        ),
      );
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    state = const AsyncValue.loading();

    try {
      final userCredential = await firebase_auth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName('$firstName $lastName');

      state = AsyncValue.data(
        AuthState(
          user: UserModel(
            id: userCredential.user?.uid ?? '',
            email: userCredential.user?.email ?? '',
            firstName: firstName,
            lastName: lastName,
          ),
          isAuthenticated: true,
        ),
      );
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> signOut() async {
    final authRepository = ref.read(authRepositoryProvider);

    try {
      await authRepository.signOut();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    final authRepository = ref.read(authRepositoryProvider);

    try {
      await authRepository.sendPasswordResetEmail(email: email);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> sendEmailVerification() async {
    final authRepository = ref.read(authRepositoryProvider);

    try {
      await authRepository.sendEmailVerification();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> updateUser(UserModel user) async {
    final authRepository = ref.read(authRepositoryProvider);

    try {
      await authRepository.updateUser(user);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> deleteAccount() async {
    final authRepository = ref.read(authRepositoryProvider);

    try {
      await authRepository.deleteAccount();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  bool isUserAuthenticated() {
    final firebaseUser = firebase_auth.FirebaseAuth.instance.currentUser;
    return firebaseUser != null;
  }
}
