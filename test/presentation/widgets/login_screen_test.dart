import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flowdeck/presentation/screens/auth/login_screen.dart';
import 'package:flowdeck/presentation/widgets/common/custom_text_field.dart';
import 'package:flowdeck/presentation/widgets/common/loading_button.dart';

void main() {
  group('LoginScreen Widget Tests', () {
    testWidgets('should display login form elements',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Assert
      expect(find.text('Welcome Back'), findsOneWidget);
      expect(
          find.text('Sign in to continue to your workspace'), findsOneWidget,);
      expect(
          find.byType(CustomTextField), findsNWidgets(2),); // Email and password
      expect(find.byType(LoadingButton), findsOneWidget);
      expect(find.text('Forgot Password?'), findsOneWidget);
      expect(find.text('Don\'t have an account?'), findsOneWidget);
    });

    testWidgets('should show validation errors for empty fields',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(LoadingButton));
      await tester.pump();

      // Assert
      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);
    });

    testWidgets('should validate email format', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Act
      await tester.enterText(
          find.byType(CustomTextField).first, 'invalid-email',);
      await tester.tap(find.byType(LoadingButton));
      await tester.pump();

      // Assert
      expect(find.text('Enter a valid email'), findsOneWidget);
    });

    testWidgets('should toggle password visibility',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Find password field and visibility toggle
      final passwordField = find.byType(CustomTextField).last;
      final visibilityToggle = find.byIcon(Icons.visibility_outlined);

      // Act
      await tester.enterText(passwordField, 'password123');
      await tester.pump();

      // Initially password should be obscured
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);

      // Tap visibility toggle
      await tester.tap(visibilityToggle);
      await tester.pump();

      // Assert
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });
  });
}
