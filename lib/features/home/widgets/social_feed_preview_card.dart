import 'package:flutter/material.dart';
import 'package:zinapp_v2/features/home/models/dashboard_post.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/dashboard/expandable_dashboard_card.dart';
import 'package:zinapp_v2/widgets/zin_avatar.dart';

/// A card that displays a preview of the social feed
class SocialFeedPreviewCard extends StatelessWidget {
  /// List of posts to display
  final List<DashboardPost> posts;

  /// Callback when a post is tapped
  final Function(DashboardPost)? onPostTap;

  /// Callback when the view all button is tapped
  final VoidCallback? onViewAllTap;

  /// Callback when the create post button is tapped
  final VoidCallback? onCreatePostTap;

  /// Initial state of the card
  final DashboardCardState initialState;

  /// Creates a social feed preview card
  const SocialFeedPreviewCard({
    super.key,
    required this.posts,
    this.onPostTap,
    this.onViewAllTap,
    this.onCreatePostTap,
    this.initialState = DashboardCardState.collapsed,
  });

  @override
  Widget build(BuildContext context) {

    return ExpandableDashboardCard(
      title: 'Social Feed',
      subtitle: 'Latest from your community',
      icon: Icons.dynamic_feed,
      accentColor: Colors.purple,
      initialState: initialState,
      onViewAllTap: onViewAllTap,

      // Collapsed view - preview of latest post
      collapsedChild: posts.isEmpty
          ? _buildEmptyState(context)
          : _buildPostPreview(context, posts.first),

      // Expanded view - list of recent posts
      expandedChild: posts.isEmpty
          ? _buildEmptyState(context)
          : Column(
              children: [
                // Create post button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onCreatePostTap,
                    icon: const Icon(Icons.add_photo_alternate),
                    label: const Text('Create New Post'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Post list
                ...posts.take(3).map((post) => _buildPostItem(
                  context,
                  post: post,
                  onTap: () => onPostTap?.call(post),
                ),),

                if (posts.length > 3) ...[
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton.icon(
                      onPressed: onViewAllTap,
                      icon: const Icon(Icons.dynamic_feed),
                      label: Text('View All ${posts.length} Posts'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.purple,
                      ),
                    ),
                  ),
                ],
              ],
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.dynamic_feed,
            color: Colors.white.withAlpha(128),
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            'No posts in your feed yet',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withAlpha(179),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onCreatePostTap,
            icon: const Icon(Icons.add_photo_alternate),
            label: const Text('Create First Post'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostPreview(BuildContext context, DashboardPost post) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => onPostTap?.call(post),
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post header
          Row(
            children: [
              // User avatar
              const ZinAvatar(
                size: ZinAvatarSize.small,
                imageUrl: null, // We don't have author profile picture in this model
                initials: 'U',
              ),

              const SizedBox(width: 8),

              // Author info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User', // We don't have author name in this model
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _formatTimestamp(post.timestamp),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white.withAlpha(128),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Post content
          if (post.text != null && post.text!.isNotEmpty) ...[
            Text(
              post.text!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
          ],

          // Post image
          if (post.imageUrl != null && post.imageUrl!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                post.imageUrl!,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 150,
                    color: Colors.grey.withAlpha(51),
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.white.withAlpha(128),
                      ),
                    ),
                  );
                },
              ),
            ),

          const SizedBox(height: 8),

          // Post stats
          Row(
            children: [
              _buildPostStat(
                context,
                icon: Icons.favorite,
                count: post.likes,
                color: Colors.red,
              ),
              const SizedBox(width: 16),
              _buildPostStat(
                context,
                icon: Icons.comment,
                count: post.comments,
                color: Colors.blue,
              ),
              const SizedBox(width: 16),
              _buildPostStat(
                context,
                icon: Icons.share,
                count: post.shares,
                color: Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPostItem(
    BuildContext context, {
    required DashboardPost post,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.baseDarkAccent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Post header
              Row(
                children: [
                  // User avatar
                  const ZinAvatar(
                    size: ZinAvatarSize.small,
                    imageUrl: null,
                    initials: 'U',
                  ),

                  const SizedBox(width: 8),

                  // Author info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _formatTimestamp(post.timestamp),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white.withAlpha(128),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Post content
              if (post.text != null && post.text!.isNotEmpty) ...[
                Text(
                  post.text!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
              ],

              // Post image (thumbnail)
              if (post.imageUrl != null && post.imageUrl!.isNotEmpty)
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        post.imageUrl!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey.withAlpha(51),
                            child: Center(
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.white.withAlpha(128),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Tap to view full post',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withAlpha(179),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 8),

              // Post stats
              Row(
                children: [
                  _buildPostStat(
                    context,
                    icon: Icons.favorite,
                    count: post.likes,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 16),
                  _buildPostStat(
                    context,
                    icon: Icons.comment,
                    count: post.comments,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 16),
                  _buildPostStat(
                    context,
                    icon: Icons.share,
                    count: post.shares,
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostStat(
    BuildContext context, {
    required IconData icon,
    required int count,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          count.toString(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white.withAlpha(179),
          ),
        ),
      ],
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${timestamp.month}/${timestamp.day}/${timestamp.year}';
    }
  }


}
