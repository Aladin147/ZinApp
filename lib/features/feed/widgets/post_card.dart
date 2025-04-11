import 'package:flutter/material.dart';
import 'package:zinapp_v2/app/theme/color_scheme.dart';
import 'package:zinapp_v2/models/post.dart';
import 'package:zinapp_v2/models/stylist.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/widgets/zin_avatar.dart';

/// A card that displays a post in the feed
class PostCard extends StatefulWidget {
  /// The post to display
  final Post post;

  /// The user who created the post (null if created by a stylist)
  final UserProfile? user;

  /// The stylist who created the post (null if created by a user)
  final Stylist? stylist;

  /// The current user viewing the post
  final UserProfile currentUser;

  /// Callback when the like button is pressed
  final Function(Post post)? onLike;

  /// Callback when the comment button is pressed
  final Function(Post post)? onComment;

  /// Callback when the share button is pressed
  final Function(Post post)? onShare;

  /// Callback when the post is tapped
  final Function(Post post)? onTap;

  /// Callback when the user avatar is tapped
  final Function(UserProfile user)? onUserTap;

  /// Callback when the stylist avatar is tapped
  final Function(Stylist stylist)? onStylistTap;

  const PostCard({
    super.key,
    required this.post,
    this.user,
    this.stylist,
    required this.currentUser,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onTap,
    this.onUserTap,
    this.onStylistTap,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> with SingleTickerProviderStateMixin {
  late AnimationController _likeAnimationController;
  late Animation<double> _likeAnimation;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.post.isLikedBy(widget.currentUser.userId);

    // Setup like animation
    _likeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _likeAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.3)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.3, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_likeAnimationController);
  }

  @override
  void dispose() {
    _likeAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PostCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update like state if the post changes
    if (oldWidget.post.postId != widget.post.postId ||
        oldWidget.post.likes != widget.post.likes) {
      _isLiked = widget.post.isLikedBy(widget.currentUser.userId);
    }
  }

  void _handleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });

    // Play animation
    _likeAnimationController.forward(from: 0.0);

    // Call callback
    if (widget.onLike != null) {
      widget.onLike!(widget.post);
    }
  }

  String _getTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(widget.post.timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'Just now';
    }
  }

  String _getPostTypeLabel() {
    switch (widget.post.type) {
      case PostType.checkIn:
        return 'Check-in';
      case PostType.showcase:
        return 'Showcase';
      case PostType.general:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayName = widget.user?.username ?? widget.stylist?.name ?? 'Unknown';
    final avatarUrl = widget.user?.profilePictureUrl ?? widget.stylist?.profilePictureUrl ?? '';
    final postTypeLabel = _getPostTypeLabel();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: widget.onTap != null ? () => widget.onTap!(widget.post) : null,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with avatar and user info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Avatar
                GestureDetector(
                  onTap: () {
                    if (widget.user != null && widget.onUserTap != null) {
                      widget.onUserTap!(widget.user!);
                    } else if (widget.stylist != null && widget.onStylistTap != null) {
                      widget.onStylistTap!(widget.stylist!);
                    }
                  },
                  child: ZinAvatar(
                    size: ZinAvatarSize.small,
                    imageUrl: avatarUrl,
                    initials: displayName.isNotEmpty ? displayName[0] : '?',
                  ),
                ),
                const SizedBox(width: 12),

                // User info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            displayName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (postTypeLabel.isNotEmpty) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryHighlight.withAlpha(51), // 20% opacity
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                postTypeLabel,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: AppColors.primaryHighlight,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _getTimeAgo(),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withAlpha(153), // 60% opacity
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Image
          // Post image (using placeholder for now)
          AspectRatio(
            aspectRatio: 4 / 3,
            child: Container(
              color: theme.colorScheme.surfaceContainerHighest,
              child: Center(
                child: Icon(
                  Icons.image,
                  color: theme.colorScheme.onSurfaceVariant,
                  size: 48,
                ),
              ),
            ),
          ),

          // Caption
          if (widget.post.caption.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.post.caption,
                style: theme.textTheme.bodyMedium,
              ),
            ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // Like button
                AnimatedBuilder(
                  animation: _likeAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _isLiked ? _likeAnimation.value : 1.0,
                      child: child,
                    );
                  },
                  child: IconButton(
                    icon: Icon(
                      _isLiked ? Icons.favorite : Icons.favorite_border,
                      color: _isLiked ? AppColors.primaryHighlight : null,
                    ),
                    onPressed: _handleLike,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                Text(
                  widget.post.likeCount.toString(),
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(width: 16),

                // Comment button
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline),
                  onPressed: widget.onComment != null
                      ? () => widget.onComment!(widget.post)
                      : null,
                  visualDensity: VisualDensity.compact,
                ),
                Text(
                  widget.post.commentCount.toString(),
                  style: theme.textTheme.bodySmall,
                ),
                const Spacer(),

                // Share button
                IconButton(
                  icon: const Icon(Icons.share_outlined),
                  onPressed: widget.onShare != null
                      ? () => widget.onShare!(widget.post)
                      : null,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),

          // Comments preview (first comment only)
          if (widget.post.comments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sofia',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.post.comments.first.text,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  if (widget.post.comments.length > 1)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: GestureDetector(
                        onTap: widget.onComment != null
                            ? () => widget.onComment!(widget.post)
                            : null,
                        child: Text(
                          'View all ${widget.post.comments.length} comments',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withAlpha(153), // 60% opacity
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    ),
    );
  }
}
