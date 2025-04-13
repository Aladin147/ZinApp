import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/feed/providers/riverpod/feed_provider.dart';
import 'package:zinapp_v2/features/feed/widgets/comment_input.dart';
import 'package:zinapp_v2/features/feed/widgets/comments_list.dart';
import 'package:zinapp_v2/models/post.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';

/// Screen that displays all comments for a post
class PostCommentsScreen extends ConsumerStatefulWidget {
  final Post post;

  const PostCommentsScreen({
    super.key,
    required this.post,
  });

  @override
  ConsumerState<PostCommentsScreen> createState() => _PostCommentsScreenState();
}

class _PostCommentsScreenState extends ConsumerState<PostCommentsScreen> {
  @override
  void initState() {
    super.initState();
    // Load comments when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(feedProvider.notifier).setActivePost(widget.post.id);
      }
    });
  }

  @override
  void dispose() {
    // Clear active post when screen closes
    if (mounted) {
      try {
        ref.read(feedProvider.notifier).clearActivePost();
      } catch (e) {
        // Ignore errors during disposal
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authProvider).user;
    final theme = Theme.of(context);
    final feedState = ref.watch(feedProvider);
    final commentsCount = widget.post.comments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments ($commentsCount)'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Error message if any
          if (feedState.error != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: theme.colorScheme.error,
              child: Text(
                feedState.error!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onError,
                ),
              ),
            ),

          // Comments list
          Expanded(
            child: CommentsList(
              postId: widget.post.id,
              currentUserId: currentUser?.id ?? '',
            ),
          ),

          // Comment input
          if (currentUser != null)
            CommentInput(
              postId: widget.post.id,
              userId: currentUser.id,
            ),
        ],
      ),
    );
  }
}
