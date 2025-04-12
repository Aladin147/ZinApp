import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zinapp_v2/common/widgets/frosted_glass_container.dart';

void main() {
  group('FrostedGlassContainer', () {
    testWidgets('renders correctly with default properties', (WidgetTester tester) async {
      // Arrange
      const childText = 'Test Child';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FrostedGlassContainer(
              child: const Text(childText),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(childText), findsOneWidget);
      expect(find.byType(FrostedGlassContainer), findsOneWidget);
      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('renders correctly with custom properties', (WidgetTester tester) async {
      // Arrange
      const childText = 'Test Child';
      const blurAmount = 10.0;
      const backgroundColor = Colors.red;
      const backgroundOpacity = 0.5;
      final borderRadius = BorderRadius.circular(20.0);
      const padding = EdgeInsets.all(16.0);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FrostedGlassContainer(
              blurAmount: blurAmount,
              backgroundColor: backgroundColor,
              backgroundOpacity: backgroundOpacity,
              borderRadius: borderRadius,
              padding: padding,
              child: const Text(childText),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(childText), findsOneWidget);
      
      // Verify the BackdropFilter's sigma
      final backdropFilter = tester.widget<BackdropFilter>(find.byType(BackdropFilter));
      expect(backdropFilter.filter, isA<ImageFilter>());
      
      // Verify the Container's decoration
      final container = tester.widget<Container>(find.byType(Container).last);
      expect(container.padding, equals(padding));
      
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.borderRadius, equals(borderRadius));
    });

    testWidgets('renders correctly with light variant', (WidgetTester tester) async {
      // Arrange
      const childText = 'Test Child';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FrostedGlassContainer.light(
              child: const Text(childText),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(childText), findsOneWidget);
      expect(find.byType(FrostedGlassContainer), findsOneWidget);
    });

    testWidgets('renders correctly with dark variant', (WidgetTester tester) async {
      // Arrange
      const childText = 'Test Child';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FrostedGlassContainer.dark(
              child: const Text(childText),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(childText), findsOneWidget);
      expect(find.byType(FrostedGlassContainer), findsOneWidget);
    });

    testWidgets('renders correctly with border', (WidgetTester tester) async {
      // Arrange
      const childText = 'Test Child';
      const border = Border(
        top: BorderSide(color: Colors.white, width: 1.0),
        bottom: BorderSide(color: Colors.white, width: 1.0),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FrostedGlassContainer(
              border: border,
              child: const Text(childText),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(childText), findsOneWidget);
      
      // Verify the Container's decoration
      final container = tester.widget<Container>(find.byType(Container).last);
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.border, equals(border));
    });

    testWidgets('renders correctly with box shadow', (WidgetTester tester) async {
      // Arrange
      const childText = 'Test Child';
      const boxShadow = [
        BoxShadow(
          color: Colors.black,
          blurRadius: 10.0,
          spreadRadius: 2.0,
          offset: Offset(0, 5),
        ),
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FrostedGlassContainer(
              boxShadow: boxShadow,
              child: const Text(childText),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(childText), findsOneWidget);
      
      // Verify the Container's decoration
      final container = tester.widget<Container>(find.byType(Container).last);
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.boxShadow, equals(boxShadow));
    });
  });
}
