import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/ui/screens/component_showcase_screen.dart';

/// Main entry point for the component showcase version of the app.
/// 
/// This allows developers to run a standalone version of the component
/// showcase without having to toggle from the main app.
void main() {
  // Run the app with Riverpod
  runApp(
    const ProviderScope(
      child: ComponentShowcaseApp(),
    ),
  );
}

/// Root app for the component showcase
class ComponentShowcaseApp extends StatelessWidget {
  const ComponentShowcaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZinApp Component Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD2FF4D), // Primary yellow
          brightness: Brightness.light,
        ),
        fontFamily: 'Urbanist',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD2FF4D), // Primary yellow
          brightness: Brightness.dark,
        ),
        fontFamily: 'Urbanist',
      ),
      themeMode: ThemeMode.dark, // Default to dark theme for showcase
      home: const UIComponentShowcaseScreen(),
    );
  }
}
