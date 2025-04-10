import 'package:flutter/material.dart';
// Assuming theme file is correctly located and named
import 'package:zinapp_v2/app/theme/zinapp_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZinApp V2', // Updated title
      theme: zinappTheme, // Apply the custom theme
      debugShowCheckedModeBanner: false, // Optional: hide debug banner
      // TODO: Replace with actual initial screen/router later
      home: Scaffold(
        body: Center(
          // Use Theme.of(context) to access theme properties
          child: Text(
            'ZinApp V2 Initial Setup',
            // Example of using defined TextTheme style
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}

// Removed default MyHomePage and _MyHomePageState classes
