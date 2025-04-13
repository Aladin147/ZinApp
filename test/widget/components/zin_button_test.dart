import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zinapp_v2/ui/components/zin_button.dart'; // Adjust import path if necessary

void main() {
  group('ZinButton Widget Tests', () {
    testWidgets('renders correctly with label and handles tap', (WidgetTester tester) async {
      // Arrange
      bool buttonPressed = false;
      const buttonLabel = 'Test Button';

      await tester.pumpWidget(
        MaterialApp( // Need MaterialApp for theme/directionality
          home: Scaffold(
            body: Center(
              child: ZinButton(
                label: buttonLabel,
                onPressed: () {
                  buttonPressed = true;
                },
              ),
            ),
          ),
        ),
      );

      // Act
      final buttonFinder = find.widgetWithText(ZinButton, buttonLabel);
      
      // Assert: Check if the button is found
      expect(buttonFinder, findsOneWidget);

      // Act: Tap the button
      await tester.tap(buttonFinder);
      await tester.pump(); // Rebuild the widget after the tap

      // Assert: Check if onPressed callback was triggered
      expect(buttonPressed, isTrue);
    });

    testWidgets('renders correctly when disabled', (WidgetTester tester) async {
      // Arrange
      const buttonLabel = 'Disabled Button';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ZinButton(
                label: buttonLabel,
                onPressed: null, // Setting onPressed to null disables the button
              ),
            ),
          ),
        ),
      );

      // Act
      final buttonFinder = find.widgetWithText(ZinButton, buttonLabel);
      final buttonWidget = tester.widget<ZinButton>(buttonFinder);

      // Assert: Check if the button is found and its onPressed is null
      expect(buttonFinder, findsOneWidget);
      expect(buttonWidget.onPressed, isNull);

      // Try to tap - it shouldn't do anything if truly disabled,
      // but we primarily check the state.
      await tester.tap(buttonFinder);
      await tester.pump();
      // No state change expected for onPressed=null
    });

    testWidgets('renders correctly with an icon', (WidgetTester tester) async {
      // Arrange
      const buttonLabel = 'Button With Icon';
      const testIcon = Icons.star;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ZinButton(
                label: buttonLabel,
                icon: testIcon,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      // Act
      final buttonFinder = find.widgetWithText(ZinButton, buttonLabel);
      final iconFinder = find.descendant(
        of: buttonFinder,
        matching: find.byIcon(testIcon),
      );

      // Assert: Check if the button and icon are found
      expect(buttonFinder, findsOneWidget);
      expect(iconFinder, findsOneWidget);
    });

    // Add more tests for different variants (secondary, reward), sizes, fullWidth etc.
  });
}
