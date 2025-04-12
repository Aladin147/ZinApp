import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zinapp_v2/features/auth/providers/auth_provider.dart';
import 'package:zinapp_v2/features/feed/providers/feed_provider.dart';
import 'package:zinapp_v2/features/stylist/providers/stylist_provider.dart';
import 'package:zinapp_v2/features/profile/providers/user_profile_provider.dart';

/// Setup providers for the application
class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Authentication provider
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),

        // User profile provider (depends on auth provider)
        ChangeNotifierProxyProvider<AuthProvider, UserProfileProvider>(
          create: (context) => UserProfileProvider(
            Provider.of<AuthProvider>(context, listen: false),
          ),
          update: (context, auth, previous) =>
              previous ?? UserProfileProvider(auth),
        ),

        // Stylist provider
        ChangeNotifierProvider(
          create: (_) => StylistProvider(),
        ),

        // Feed provider
        ChangeNotifierProvider(
          create: (_) => FeedProvider(),
        ),

        // Add other providers here
      ],
      child: child,
    );
  }
}
