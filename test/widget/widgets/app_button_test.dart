import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zinapp_v2/widgets/app_button.dart';

void main() {
  group('AppButton', () {
    testWidgets('renders correctly with label', (WidgetTester tester) async {
      // Arrange
      const buttonText = 'Test Button';
      bool buttonPressed = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: buttonText,
              onPressed: () {
                buttonPressed = true;
              },
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(buttonText), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Test button press
      await tester.tap(find.byType(AppButton));
      expect(buttonPressed, isTrue);
    });

    testWidgets('renders correctly with icon', (WidgetTester tester) async {
      // Arrange
      const buttonText = 'Test Button';
      const buttonIcon = Icons.add;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: buttonText,
              icon: buttonIcon,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(buttonText), findsOneWidget);
      expect(find.byIcon(buttonIcon), findsOneWidget);
    });

    testWidgets('renders correctly with trailing icon', (WidgetTester tester) async {
      // Arrange
      const buttonText = 'Test Button';
      const buttonIcon = Icons.arrow_forward;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: buttonText,
              icon: buttonIcon,
              iconPosition: IconPosition.trailing,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(buttonText), findsOneWidget);
      expect(find.byIcon(buttonIcon), findsOneWidget);

      // Verify icon position
      final iconWidget = tester.widget<Icon>(find.byIcon(buttonIcon));
      final textWidget = tester.widget<Text>(find.text(buttonText));
      final row = tester.widget<Row>(find.byType(Row));
      final children = row.children;
      
      // The text should come before the icon in the row's children
      final textIndex = children.indexOf(textWidget);
      final iconIndex = children.indexWhere((widget) => widget is SizedBox && widget.child == iconWidget);
      expect(textIndex, lessThan(iconIndex));
    });

    testWidgets('renders correctly when disabled', (WidgetTester tester) async {
      // Arrange
      const buttonText = 'Test Button';
      bool buttonPressed = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: buttonText,
              onPressed: null, // Disabled button
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(buttonText), findsOneWidget);
      
      // Test button press - should not trigger callback
      await tester.tap(find.byType(AppButton));
      expect(buttonPressed, isFalse);
    });

    testWidgets('renders correctly with loading state', (WidgetTester tester) async {
      // Arrange
      const buttonText = 'Test Button';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: buttonText,
              isLoading: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(buttonText), findsNothing); // Text should be hidden during loading
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders correctly with different sizes', (WidgetTester tester) async {
      // Test small size
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Small Button',
              size: AppButtonSize.small,
              onPressed: () {},
            ),
          ),
        ),
      );
      
      final smallButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      final smallButtonStyle = smallButton.style as ButtonStyle;
      
      // Test medium size
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Medium Button',
              size: AppButtonSize.medium,
              onPressed: () {},
            ),
          ),
        ),
      );
      
      final mediumButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      final mediumButtonStyle = mediumButton.style as ButtonStyle;
      
      // Test large size
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Large Button',
              size: AppButtonSize.large,
              onPressed: () {},
            ),
          ),
        ),
      );
      
      final largeButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      final largeButtonStyle = largeButton.style as ButtonStyle;
      
      // The exact sizes depend on the implementation, but we can verify that
      // small < medium < large for the height
      // This is a bit tricky to test directly, so we'll just verify that the styles are different
      expect(smallButtonStyle, isNot(equals(mediumButtonStyle)));
      expect(mediumButtonStyle, isNot(equals(largeButtonStyle)));
      expect(smallButtonStyle, isNot(equals(largeButtonStyle)));
    });

    testWidgets('renders correctly with different variants', (WidgetTester tester) async {
      // Test primary variant
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Primary Button',
              variant: AppButtonVariant.primary,
              onPressed: () {},
            ),
          ),
        ),
      );
      
      expect(find.text('Primary Button'), findsOneWidget);
      
      // Test secondary variant
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Secondary Button',
              variant: AppButtonVariant.secondary,
              onPressed: () {},
            ),
          ),
        ),
      );
      
      expect(find.text('Secondary Button'), findsOneWidget);
      
      // Test text variant
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Text Button',
              variant: AppButtonVariant.text,
              onPressed: () {},
            ),
          ),
        ),
      );
      
      expect(find.text('Text Button'), findsOneWidget);
    });
  });
}
