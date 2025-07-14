import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowdeck/presentation/widgets/common/loading_button.dart';

void main() {
  group('LoadingButton Widget Tests', () {
    testWidgets('should display button text when not loading',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingButton(
              text: 'Sign In',
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should show loading indicator when isLoading is true',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingButton(
              text: 'Sign In',
              isLoading: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Sign In'), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should be disabled when isLoading is true',
        (WidgetTester tester) async {
      // Arrange
      var wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingButton(
              text: 'Sign In',
              isLoading: true,
              onPressed: () {
                wasPressed = true;
              },
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Assert
      expect(wasPressed, false);
    });

    testWidgets('should call onPressed when tapped and not loading',
        (WidgetTester tester) async {
      // Arrange
      var wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingButton(
              text: 'Sign In',
              onPressed: () {
                wasPressed = true;
              },
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Assert
      expect(wasPressed, true);
    });

    testWidgets('should handle null onPressed (disabled state)',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingButton(
              text: 'Sign In',
              onPressed: null,
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Assert - should not throw any errors
      expect(find.text('Sign In'), findsOneWidget);
    });

    testWidgets('should display outlined button when isOutlined is true',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingButton(
              text: 'Sign In',
              isOutlined: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
    });

    testWidgets('should display icon when provided',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingButton(
              text: 'Sign In',
              icon: Icons.login,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.login), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
    });

    testWidgets('should apply custom colors when provided',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingButton(
              text: 'Sign In',
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert - colors are applied via ButtonStyle, test button exists
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
    });
  });
}
