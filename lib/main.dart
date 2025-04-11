import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zinapp_v2/app/router.dart'; // Import the router
import 'package:zinapp_v2/app/theme/zinapp_theme.dart';
import 'package:zinapp_v2/features/auth/providers/auth_provider.dart';
import 'package:zinapp_v2/features/auth/repositories/auth_repository.dart';
import 'package:zinapp_v2/features/auth/services/mock_auth_service.dart';

void main() {
  // Create auth service and repository
  final authService = MockAuthService();
  final authRepository = AuthRepository(authService);

  // Wrap the entire app in a MultiProvider
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(authRepository)),
      ],
      child: const MyApp(),
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
