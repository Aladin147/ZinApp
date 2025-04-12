import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/router/riverpod_router.dart';
import 'package:zinapp_v2/theme/zinapp_theme.dart';

/// The main application widget using Riverpod for state management
class RiverpodApp extends ConsumerWidget {
  const RiverpodApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(riverpodRouterProvider);

    return MaterialApp.router(
      title: 'ZinApp V2',
      theme: zinappTheme, // Apply the custom theme
      debugShowCheckedModeBanner: false,
      // Provide the router configuration
      routerConfig: router,
    );
  }
}
