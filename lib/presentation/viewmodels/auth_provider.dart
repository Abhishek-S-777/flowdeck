import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flowdeck/data/models/user.dart' as local_user;
import 'package:flutter/material.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  local_user.User? build() {
    return null; // Initial state - not authenticated
  }

  Future<void> signIn(
    String email,
    String password,
  ) async {
    try {
      // Sign in with Firebase Authentication
      final firebase_auth.UserCredential userCredential =
          await firebase_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update the state with the authenticated user
      state = local_user.User(
        id: userCredential.user?.uid ?? '',
        name: userCredential.user?.displayName ?? 'Unknown',
        email: email,
      );
    } catch (e) {
      // Handle errors (e.g., invalid credentials)
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      // Create user with Firebase Authentication
      final firebase_auth.UserCredential userCredential = await firebase_auth
          .FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update the user's display name
      await userCredential.user?.updateDisplayName(name);

      // Update the state with the authenticated user
      state = local_user.User(
        id: userCredential.user?.uid ?? '',
        name: name,
        email: email,
      );
    } catch (e) {
      // Handle errors (e.g., email already in use, weak password)
      throw Exception('Failed to create user: $e');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    // Simulate password reset
    await Future.delayed(const Duration(seconds: 1));
    // In a real app, this would send an email
  }

  Future<void> signOut() async {
    state = null;
  }
}

@riverpod
Stream<firebase_auth.User?> authStateChanges(AuthStateChangesRef ref) {
  return firebase_auth.FirebaseAuth.instance.authStateChanges();
}

@riverpod
bool isAuthenticated(IsAuthenticatedRef ref) {
  final firebaseUser = ref.watch(authStateChangesProvider).value;
  return firebaseUser != null;
}
