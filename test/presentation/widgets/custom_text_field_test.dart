import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowdeck/presentation/widgets/common/custom_text_field.dart';

void main() {
  group('CustomTextField Widget Tests', () {
    testWidgets('should display label and hint text',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              label: 'Email',
              hintText: 'Enter your email',
              onChanged: (value) {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Enter your email'), findsOneWidget);
    });

    testWidgets('should show obscured text when obscureText is true',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              label: 'Password',
              hintText: 'Enter password',
              obscureText: true,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      // Act
      await tester.enterText(find.byType(TextField), 'password123');
      await tester.pump();

      // Assert - text should be obscured (actual text won't be visible)
      expect(find.text('password123'), findsNothing);
    });

    testWidgets('should call onChanged when text is entered',
        (WidgetTester tester) async {
      // Arrange
      String? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              label: 'Test',
              hintText: 'Enter text',
              onChanged: (value) {
                changedValue = value;
              },
            ),
          ),
        ),
      );

      // Act
      await tester.enterText(find.byType(TextField), 'test input');

      // Assert
      expect(changedValue, 'test input');
    });

    testWidgets('should show prefix icon when provided',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              label: 'Email',
              hintText: 'Enter your email',
              prefixIcon: Icons.email,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.email), findsOneWidget);
    });

    testWidgets('should show suffix icon when provided',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              label: 'Password',
              hintText: 'Enter password',
              suffixIcon: IconButton(
                icon: const Icon(Icons.visibility),
                onPressed: () {},
              ),
              onChanged: (value) {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('should handle different keyboard types',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              label: 'Phone',
              hintText: 'Enter phone number',
              keyboardType: TextInputType.phone,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      // Assert
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.keyboardType, TextInputType.phone);
    });
  });
}
