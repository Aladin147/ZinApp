import 'package:flutter/material.dart';
import 'ui/screens/component_showcase_screen.dart';

/// A simplified version of the main app that directly launches 
/// the component showcase for development and testing.
void main() {
  runApp(const ZinAppComponentShowcase());
}

/// A specialized version of the app that focuses on showcasing
/// and testing UI components in isolation.
class ZinAppComponentShowcase extends StatelessWidget {
  const ZinAppComponentShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZinApp Component Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD2FF4D), 
          brightness: Brightness.light,
        ),
        fontFamily: 'Urbanist',
      ),
      home: const ComponentShowcaseScreen(),
    );
  }
}
