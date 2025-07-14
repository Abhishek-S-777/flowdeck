import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flowdeck/core/di/injection_container.dart';
import 'package:flowdeck/data/models/auth_state.dart';
import 'package:flowdeck/data/models/user_model.dart';

part 'auth_viewmodel.g.dart';

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
    final authRepository = ref.read(authRepositoryProvider);

    state = const AsyncValue.loading();

    try {
      final result = await authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.hasError) {
        state = AsyncValue.error(result.error!, StackTrace.current);
      }
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
    final authRepository = ref.read(authRepositoryProvider);

    state = const AsyncValue.loading();

    try {
      final result = await authRepository.createUserWithEmailAndPassword(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );

      if (result.hasError) {
        state = AsyncValue.error(result.error!, StackTrace.current);
      }
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
}

// Helper providers
@riverpod
UserModel? currentUser(CurrentUserRef ref) {
  final authState = ref.watch(authViewModelProvider);
  return authState.when(
    data: (state) => state.user,
    loading: () => null,
    error: (_, __) => null,
  );
}

@riverpod
bool isAuthenticated(IsAuthenticatedRef ref) {
  final authState = ref.watch(authViewModelProvider);
  return authState.when(
    data: (state) => state.isAuthenticated,
    loading: () => false,
    error: (_, __) => false,
  );
}
