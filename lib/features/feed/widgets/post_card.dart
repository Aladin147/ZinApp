import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/common/widgets/frosted_glass_container.dart';
import 'package:zinapp_v2/features/feed/providers/riverpod/feed_provider.dart';
import 'package:zinapp_v2/features/feed/screens/post_comments_screen.dart';
import 'package:zinapp_v2/models/post.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// A card displaying a post in the social feed
class PostCard extends ConsumerWidget {
  final Post post;
  final String username;
  final String? userProfilePictureUrl;
  final VoidCallback? onTap;
  final VoidCallback? onLikeTap;
  final VoidCallback? onCommentTap;
  final VoidCallback? onShareTap;
  final VoidCallback? onUserTap;

  const PostCard({
    super.key,
    required this.post,
    required this.username,
    this.userProfilePictureUrl,
    this.onTap,
    this.onLikeTap,
    this.onCommentTap,
    this.onShareTap,
    this.onUserTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: DarkFrostedGlassContainer(
        margin: const EdgeInsets.only(bottom: 16),
        borderRadius: BorderRadius.circular(16),
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onUserTap,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: userProfilePictureUrl != null
                          ? AssetImage(userProfilePictureUrl!)
                          : null,
                      child: userProfilePictureUrl == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (post.location != null)
                        Text(
                          post.location!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withAlpha(179),
                          ),
                        ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    _formatDate(post.timestamp),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withAlpha(128),
                    ),
                  ),
                ],
              ),
            ),
            // Post content
            if (post.text != null && post.text!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  post.text!,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            // Post images
            if (post.imageUrl != null && post.imageUrl!.isNotEmpty) ...[
              const SizedBox(height: 12),
              SizedBox(
                height: 240,
                child: PageView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Image.network(
                      post.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
            // Tags
            if (post.tags.isNotEmpty) ...[
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Wrap(
                  spacing: 8,
                  children: post.tags.map((tag) {
                    return Text(
                      '#$tag',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryHighlight,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
            // Comment preview (if there are comments)
            if (post.comments > 0)
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PostCommentsScreen(post: post),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chat_bubble_outline,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        post.comments == 1
                            ? 'View 1 comment'
                            : 'View all ${post.comments} comments',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Engagement stats
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  _buildEngagementStat(
                    context,
                    icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
                    count: post.likes,
                    color: post.isLiked ? Colors.red : null,
                    onTap: () {
                      // Toggle like
                      ref.read(feedProvider.notifier).toggleLike(post.id);

                      // Call the onLikeTap callback if provided
                      if (onLikeTap != null) {
                        onLikeTap!();
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  _buildEngagementStat(
                    context,
                    icon: Icons.comment,
                    count: post.comments,
                    onTap: () {
                      // Navigate to comments screen
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PostCommentsScreen(post: post),
                        ),
                      );

                      // Call the onCommentTap callback if provided
                      if (onCommentTap != null) {
                        onCommentTap!();
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  _buildEngagementStat(
                    context,
                    icon: Icons.share,
                    count: post.shares,
                    onTap: onShareTap,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEngagementStat(
    BuildContext context, {
    required IconData icon,
    required int count,
    Color? color,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    final defaultColor = theme.colorScheme.onSurface.withAlpha(179);

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: color ?? defaultColor,
          ),
          const SizedBox(width: 4),
          Text(
            count.toString(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: color ?? defaultColor,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return '${date.day}/${date.month}/${date.year}';
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
