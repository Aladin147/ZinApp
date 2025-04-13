import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/navigation/bottom_nav_bar.dart';

/// A layout wrapper that provides the bottom navigation bar
class MainLayout extends ConsumerWidget {
  final Widget child;
  final bool showBottomNav;
  final bool showFloatingActionButton;
  final FloatingActionButton? floatingActionButton;

  const MainLayout({
    super.key,
    required this.child,
    this.showBottomNav = true,
    this.showFloatingActionButton = false,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: child,
      bottomNavigationBar: showBottomNav ? const ZinBottomNavBar() : null,
      floatingActionButton: showFloatingActionButton ? floatingActionButton : null,
    );
  }
}
