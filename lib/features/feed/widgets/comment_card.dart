import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:zinapp_v2/features/feed/providers/riverpod/feed_provider.dart';
import 'package:zinapp_v2/models/comment.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/widgets/zin_avatar.dart';

/// A card displaying a comment on a post
class CommentCard extends ConsumerWidget {
  final Comment comment;
  final VoidCallback? onDelete;
  final bool isCurrentUser;

  const CommentCard({
    super.key,
    required this.comment,
    this.onDelete,
    this.isCurrentUser = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(feedProvider).postUsers[comment.userId];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outline.withAlpha(40),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info and timestamp
            Row(
              children: [
                // User avatar
                ZinAvatar(
                  imageUrl: user?.profilePictureUrl,
                  size: ZinAvatarSize.small,
                ),
                const SizedBox(width: 8),

                // Username and timestamp
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.username ?? 'Unknown User',
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        _formatDate(comment.timestamp),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withAlpha(128),
                        ),
                      ),
                    ],
                  ),
                ),

                // Delete button for current user
                if (isCurrentUser)
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    onPressed: onDelete,
                    tooltip: 'Delete comment',
                    color: theme.colorScheme.error,
                  ),
              ],
            ),

            const SizedBox(height: 8),

            // Comment text
            Text(
              comment.text,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return DateFormat('MMM d, yyyy').format(date);
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
