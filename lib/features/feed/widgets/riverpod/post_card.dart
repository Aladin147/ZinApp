import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:zinapp_v2/features/feed/providers/riverpod/feed_provider.dart';
import 'package:zinapp_v2/models/post.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/zin_avatar.dart';

class RiverpodPostCard extends ConsumerWidget {
  final Post post;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onUserTap;

  const RiverpodPostCard({
    Key? key,
    required this.post,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onUserTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(feedProvider.notifier).getUserForPost(post.userId);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post header with user info
          _buildPostHeader(context, user, theme),

          // Post content
          if (post.content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Text(
                post.content,
                style: theme.textTheme.bodyMedium,
              ),
            ),

          // Post images
          if (post.imageUrls.isNotEmpty) _buildImageGallery(context),

          // Post tags
          if (post.tags.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: post.tags.map((tag) {
                  return Chip(
                    label: Text(
                      '#$tag',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryHighlight,
                      ),
                    ),
                    backgroundColor: AppColors.primaryHighlight.withOpacity(0.1),
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  );
                }).toList(),
              ),
            ),

          // Post location
          if (post.location != null && post.location!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    post.location!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),

          // Post stats and actions
          _buildPostActions(context, theme),
        ],
      ),
    );
  }

  Widget _buildPostHeader(BuildContext context, UserProfile? user, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // User avatar
          GestureDetector(
            onTap: onUserTap,
            child: ZinAvatar(
              size: ZinAvatarSize.small,
              imageUrl: user?.profilePictureUrl,
              initials: user?.username.isNotEmpty == true ? user!.username[0] : '?',
            ),
          ),
          const SizedBox(width: 12),

          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.username ?? 'Unknown User',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _formatDate(post.createdAt),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),

          // Post menu
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // TODO: Show post options menu
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImageGallery(BuildContext context) {
    if (post.imageUrls.isEmpty) return const SizedBox.shrink();

    // For a single image
    if (post.imageUrls.length == 1) {
      return Container(
        constraints: const BoxConstraints(
          maxHeight: 300,
        ),
        width: double.infinity,
        child: Image.network(
          post.imageUrls.first,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 200,
              color: Colors.grey.shade200,
              child: const Center(
                child: Icon(Icons.broken_image, size: 48, color: Colors.grey),
              ),
            );
          },
        ),
      );
    }

    // For multiple images
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: post.imageUrls.length,
        itemBuilder: (context, index) {
          return Container(
            width: 200,
            margin: EdgeInsets.only(
              left: index == 0 ? 0 : 8,
              right: index == post.imageUrls.length - 1 ? 0 : 0,
            ),
            child: Image.network(
              post.imageUrls[index],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 48, color: Colors.grey),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildPostActions(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // Stats row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Text(
                  '${post.likesCount} likes',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(width: 16),
                Text(
                  '${post.commentsCount} comments',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(width: 16),
                Text(
                  '${post.sharesCount} shares',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),

          const Divider(),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                context,
                Icons.favorite_border,
                'Like',
                onLike,
              ),
              _buildActionButton(
                context,
                Icons.chat_bubble_outline,
                'Comment',
                onComment,
              ),
              _buildActionButton(
                context,
                Icons.share_outlined,
                'Share',
                onShare,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback? onPressed,
  ) {
    final theme = Theme.of(context);
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: TextButton.styleFrom(
        foregroundColor: theme.colorScheme.onSurface.withOpacity(0.8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
