import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/providers.dart';
import 'package:zinapp_v2/router.dart'; // Import the router
import 'package:zinapp_v2/theme/zinapp_theme.dart';

void main() {
  // Run the app with providers wrapped in ProviderScope for Riverpod
  runApp(
    ProviderScope(
      child: AppProviders(
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Use MaterialApp.router to integrate go_router
    return MaterialApp.router(
      title: 'ZinApp V2',
      theme: zinappTheme, // Apply the custom theme
      debugShowCheckedModeBanner: false,
      // Provide the router configuration
      routerConfig: router,
    );
  }
}
