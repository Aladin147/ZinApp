import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/features/feed/providers/riverpod/feed_provider.dart';
import 'package:zinapp_v2/features/profile/providers/riverpod/user_profile_provider.dart';
import 'package:zinapp_v2/features/stylist/providers/riverpod/stylist_provider.dart';
import 'package:zinapp_v2/router/app_routes.dart';

/// A screen for testing Riverpod providers and functionality
class RiverpodTestScreen extends ConsumerWidget {
  const RiverpodTestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final profileState = ref.watch(userProfileProviderProvider);
    final feedState = ref.watch(feedProvider);
    final stylistState = ref.watch(stylistProviderProvider);

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Auth Provider',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Authenticated: ${authState.isAuthenticated}'),
                  Text('Loading: ${authState.isLoading}'),
                  Text('Error: ${authState.error ?? "None"}'),
                  if (authState.user != null) ...[
                    const SizedBox(height: 8),
                    // Access UserProfile fields safely
                    Text('User ID: ${authState.user?.id ?? "N/A"}'),
                    Text('Username: ${authState.user?.username ?? "N/A"}'),
                    Text('Email: ${authState.user?.email ?? "N/A"}'),
                    Text('XP: ${authState.user?.xp ?? "N/A"}'),
                    Text('Level: ${authState.user?.level ?? "N/A"}'),
                    Text('Tokens: ${authState.user?.tokens ?? "N/A"}'),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          ref.read(authProvider.notifier).login(
                                email: 'test@example.com',
                                password: 'password123',
                              );
                        },
                        child: const Text('Login'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(authProvider.notifier).logout();
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _buildSection(
              title: 'Profile Provider',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Loading: ${profileState.isLoading}'),
                  Text('Error: ${profileState.error ?? "None"}'),
                  Text('Token History: ${profileState.tokenHistory?.length ?? 0} transactions'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(userProfileProviderProvider.notifier).loadUserProfile();
                    },
                    child: const Text('Load Profile'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(userProfileProviderProvider.notifier).loadTokenHistory();
                    },
                    child: const Text('Load Token History'),
                  ),
                ],
              ),
            ),
            _buildSection(
              title: 'Feed Provider',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Posts: ${feedState.posts.length}'),
                  Text('Loading: ${feedState.isLoading}'),
                  Text('Error: ${feedState.error ?? "None"}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(feedProvider.notifier).loadPosts();
                    },
                    child: const Text('Load Posts'),
                  ),
                ],
              ),
            ),

            _buildSection(
              title: 'Stylist Provider',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Featured Stylists: ${stylistState.featuredStylists.length}'),
                  Text('Available Stylists: ${stylistState.availableStylists.length}'),
                  Text('Loading: ${stylistState.isLoading}'),
                  Text('Error: ${stylistState.error ?? "None"}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(stylistProviderProvider.notifier).loadInitialData();
                    },
                    child: const Text('Load Stylists'),
                  ),
                ],
              ),
            ),
            _buildSection(
              title: 'Navigation',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: () => context.go(AppRoutes.home),
                        child: const Text('Home'),
                      ),
                      ElevatedButton(
                        onPressed: () => context.go(AppRoutes.profile),
                        child: const Text('Profile'),
                      ),
                      ElevatedButton(
                        onPressed: () => context.go(AppRoutes.profileEdit),
                        child: const Text('Edit Profile'),
                      ),
                      ElevatedButton(
                        onPressed: () => context.go(AppRoutes.feed),
                        child: const Text('Feed'),
                      ),
                      ElevatedButton(
                        onPressed: () => context.go(AppRoutes.stylistList),
                        child: const Text('Stylists'),
                      ),
                      ElevatedButton(
                        onPressed: () => context.go(AppRoutes.showcase),
                        child: const Text('Component Showcase'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget content}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            content,
          ],
        ),
      ),
    );
  }
}
