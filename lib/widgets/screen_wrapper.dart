import 'package:flutter/material.dart';

/// A standard wrapper for application screens.
///
/// Provides consistent background color, safe area handling, and optional padding.
class ScreenWrapper extends StatelessWidget {
  /// The main content of the screen.
  final Widget child;

  /// Optional AppBar for the screen.
  final AppBar? appBar;

  /// Whether to use SafeArea. Defaults to true.
  final bool useSafeArea;

  /// Optional background color. Defaults to theme's scaffoldBackgroundColor.
  final Color? backgroundColor;

  /// Optional padding around the child content. Defaults to horizontal 16.0.
  final EdgeInsetsGeometry? padding;

  const ScreenWrapper({
    super.key,
    required this.child,
    this.appBar,
    this.useSafeArea = true,
    this.backgroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectivePadding = padding ?? const EdgeInsets.symmetric(horizontal: 16.0);

    Widget screenContent = Padding(
      padding: effectivePadding,
      child: child,
    );

    if (useSafeArea) {
      screenContent = SafeArea(child: screenContent);
    }

    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor ?? theme.scaffoldBackgroundColor,
      body: screenContent,
      // Add other common Scaffold elements if needed (e.g., FloatingActionButton)
    );
  }
}

/*
  Example Usage:

  class MyScreen extends StatelessWidget {
    const MyScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return ScreenWrapper(
        appBar: AppBar(title: Text('My Screen')),
        padding: const EdgeInsets.all(20.0), // Custom padding
        child: Column(
          children: [
            Text('Screen Content', style: AppTypography.bodyMedium(context)),
            // ... other widgets
          ],
        ),
      );
    }
  }
*/
