import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zinapp_v2/router/app_routes.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/widgets/zin_avatar.dart';

/// Header for the feed screen with user info and actions
class FeedHeader extends StatelessWidget {
  /// The current user
  final UserProfile user;

  /// Callback when the search button is pressed
  final VoidCallback? onSearch;

  /// Callback when the notifications button is pressed
  final VoidCallback? onNotifications;

  /// Callback when the user avatar is pressed
  final VoidCallback? onProfileTap;

  const FeedHeader({
    super.key,
    required this.user,
    this.onSearch,
    this.onNotifications,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // User avatar
          GestureDetector(
            onTap: onProfileTap,
            child: ZinAvatar(
              size: ZinAvatarSize.small,
              imageUrl: user.profilePictureUrl,
              initials: user.username.isNotEmpty ? user.username[0] : '?',
            ),
          ),
          const SizedBox(width: 12),

          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                Text(
                  user.username,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // XP indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryHighlight.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.bolt,
                  color: AppColors.primaryHighlight,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '${user.xp} XP',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: AppColors.primaryHighlight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Action buttons
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: onSearch,
            visualDensity: VisualDensity.compact,
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: onNotifications,
            visualDensity: VisualDensity.compact,
          ),
          // Component showcase button (for development only)
          IconButton(
            icon: const Icon(Icons.widgets_outlined),
            onPressed: () => context.go(AppRoutes.showcase),
            visualDensity: VisualDensity.compact,
            tooltip: 'Component Showcase',
          ),
        ],
      ),
    );
  }
}
