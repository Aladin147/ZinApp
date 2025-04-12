import 'package:flutter/material.dart';
import 'package:zinapp_v2/models/post.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// A card displaying a post in the social feed
class PostCard extends StatelessWidget {
  final Post post;
  final String username;
  final String? userProfilePictureUrl;
  final VoidCallback? onTap;
  final VoidCallback? onLikeTap;
  final VoidCallback? onCommentTap;
  final VoidCallback? onShareTap;
  final VoidCallback? onUserTap;

  const PostCard({
    Key? key,
    required this.post,
    required this.username,
    this.userProfilePictureUrl,
    this.onTap,
    this.onLikeTap,
    this.onCommentTap,
    this.onShareTap,
    this.onUserTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
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
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    _formatDate(post.createdAt),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
            // Post content
            if (post.content.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  post.content,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            // Post images
            if (post.imageUrls.isNotEmpty) ...[
              const SizedBox(height: 12),
              SizedBox(
                height: 240,
                child: PageView.builder(
                  itemCount: post.imageUrls.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      post.imageUrls[index],
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
            // Engagement stats
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  _buildEngagementStat(
                    context,
                    icon: Icons.favorite,
                    count: post.likesCount,
                    onTap: onLikeTap,
                  ),
                  const SizedBox(width: 16),
                  _buildEngagementStat(
                    context,
                    icon: Icons.comment,
                    count: post.commentsCount,
                    onTap: onCommentTap,
                  ),
                  const SizedBox(width: 16),
                  _buildEngagementStat(
                    context,
                    icon: Icons.share,
                    count: post.sharesCount,
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
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
          const SizedBox(width: 4),
          Text(
            count.toString(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
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
