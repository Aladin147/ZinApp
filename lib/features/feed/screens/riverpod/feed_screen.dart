import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/features/feed/providers/riverpod/feed_provider.dart';
import 'package:zinapp_v2/features/feed/widgets/riverpod/post_card.dart';
import 'package:zinapp_v2/models/post.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

class RiverpodFeedScreen extends ConsumerStatefulWidget {
  const RiverpodFeedScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RiverpodFeedScreen> createState() => _RiverpodFeedScreenState();
}

class _RiverpodFeedScreenState extends ConsumerState<RiverpodFeedScreen> {
  @override
  void initState() {
    super.initState();
    // Load posts when screen initializes
    Future.microtask(() => ref.read(feedProvider.notifier).loadPosts());
  }

  @override
  Widget build(BuildContext context) {
    final feedState = ref.watch(feedProvider);
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(feedProvider.notifier).loadPosts(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(feedProvider.notifier).loadPosts();
        },
        child: feedState.isLoading && feedState.posts.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : feedState.posts.isEmpty
                ? _buildEmptyState(context)
                : _buildPostsList(context, feedState.posts),
      ),
      floatingActionButton: authState.isAuthenticated
          ? FloatingActionButton(
              onPressed: () {
                // TODO: Navigate to create post screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Create post functionality coming soon!'),
                  ),
                );
              },
              backgroundColor: AppColors.primaryHighlight,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.feed_outlined,
            size: 64,
            color: theme.colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No posts yet',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Be the first to share something!',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPostsList(BuildContext context, List<Post> posts) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: posts.length + 1, // +1 for loading indicator
      itemBuilder: (context, index) {
        // Show loading indicator at the bottom when loading more posts
        if (index == posts.length) {
          return ref.watch(feedProvider).isLoading
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox.shrink();
        }

        final post = posts[index];
        return RiverpodPostCard(
          post: post,
          onLike: () => ref.read(feedProvider.notifier).likePost(post.id),
        );
      },
    );
  }
}
