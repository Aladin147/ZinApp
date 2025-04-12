import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/features/auth/screens/riverpod/auth_screen.dart';
import 'package:zinapp_v2/features/auth/screens/riverpod/login_screen.dart';
import 'package:zinapp_v2/features/auth/screens/riverpod/register_screen.dart';
import 'package:zinapp_v2/features/auth/widgets/riverpod/auth_wrapper.dart';

/// A screen to test Riverpod integration
class RiverpodTestScreen extends ConsumerWidget {
  const RiverpodTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Test'),
        actions: [
          if (authState.isAuthenticated)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                ref.read(authProvider.notifier).logout();
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Auth state info
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade200,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Auth State:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text('Authenticated: ${authState.isAuthenticated}'),
                if (authState.isAuthenticated && authState.user != null) ...[
                  Text('User: ${authState.user!.username}'),
                  Text('Email: ${authState.user!.email}'),
                  Text('XP: ${authState.user!.xp}'),
                  Text('Level: ${authState.user!.level}'),
                  Text('Tokens: ${authState.user!.tokens}'),
                ],
                if (authState.error != null)
                  Text(
                    'Error: ${authState.error}',
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
              ],
            ),
          ),

          // Test buttons
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RiverpodAuthScreen(),
                        ),
                      );
                    },
                    child: const Text('Open Auth Screen'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RiverpodLoginScreen(
                            onRegisterTap: () {},
                          ),
                        ),
                      );
                    },
                    child: const Text('Open Login Screen'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RiverpodRegisterScreen(
                            onLoginTap: () {},
                          ),
                        ),
                      );
                    },
                    child: const Text('Open Register Screen'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RiverpodAuthWrapper(
                            authenticatedChild: Center(
                              child: Text('Authenticated Content'),
                            ),
                            unauthenticatedChild: RiverpodAuthScreen(),
                          ),
                        ),
                      );
                    },
                    child: const Text('Test Auth Wrapper'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(authProvider.notifier).initialize();
                    },
                    child: const Text('Initialize Auth'),
                  ),
                  if (authState.isAuthenticated)
                    ElevatedButton(
                      onPressed: () {
                        ref.read(authProvider.notifier).logout();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Logout'),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
