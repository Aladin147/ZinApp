import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/router/app_routes.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/containers/organic_container.dart';
import 'package:zinapp_v2/widgets/shapes/wave_clipper.dart';
import 'package:zinapp_v2/widgets/zin_avatar.dart';

/// A header widget for the profile screen
/// Displays user avatar, name, level, and quick actions
class ProfileHeaderWidget extends StatelessWidget {
  /// The user profile to display
  final UserProfile user;
  
  /// Whether to show the edit button
  final bool showEditButton;
  
  /// Whether to show the settings button
  final bool showSettingsButton;
  
  /// Callback when the edit button is tapped
  final VoidCallback? onEditTap;
  
  /// Callback when the settings button is tapped
  final VoidCallback? onSettingsTap;

  /// Creates a profile header widget
  const ProfileHeaderWidget({
    super.key,
    required this.user,
    this.showEditButton = true,
    this.showSettingsButton = true,
    this.onEditTap,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ClipPath(
      clipper: WaveBottomClipper(
        amplitude: 15.0,
        frequency: 1.2,
      ),
      child: OrganicContainer(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        color: AppColors.baseDark,
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.baseDark,
            AppColors.baseDarkDeeper,
          ],
        ),
        elevation: 4,
        borderRadius: 0, // No border radius at top since it's at screen edge
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: AppColors.primaryHighlight.withAlpha(15),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
        shape: OrganicShape.rounded, // We're using ClipPath instead of the built-in shapes
        child: Column(
          children: [
            // Top row with back button and actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                
                // Action buttons
                Row(
                  children: [
                    if (showEditButton)
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: onEditTap ?? () {
                          context.go(AppRoutes.profileEdit);
                        },
                      ),
                    if (showSettingsButton)
                      IconButton(
                        icon: const Icon(Icons.settings, color: Colors.white),
                        onPressed: onSettingsTap ?? () {
                          // TODO: Navigate to settings
                        },
                      ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Avatar and user info
            Column(
              children: [
                // Avatar with level badge
                Stack(
                  children: [
                    // Avatar
                    ZinAvatar(
                      size: ZinAvatarSize.extraLarge,
                      imageUrl: user.profilePictureUrl,
                      initials: user.username.isNotEmpty ? user.username[0] : '?',
                    ),
                    
                    // Level badge
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryHighlight,
                              AppColors.primaryHighlight.withAlpha(200),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryHighlight.withAlpha(100),
                              blurRadius: 8,
                              spreadRadius: -2,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Lvl ${user.level}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Username and rank
                Text(
                  user.username,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                Text(
                  user.rank,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Bio (if available)
                if (user.bio != null && user.bio!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      user.bio!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                
                const SizedBox(height: 16),
                
                // XP progress bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'XP Progress',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryHighlight.withAlpha(51), // 0.2 opacity
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${user.xp % 1000} / 1000 XP',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // Progress bar
                      Stack(
                        children: [
                          // Base progress bar background with glow
                          Container(
                            height: 12,
                            decoration: BoxDecoration(
                              color: AppColors.baseDarkAccent,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryHighlight.withAlpha(15),
                                  blurRadius: 8,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                          ),
                          
                          // Progress fill
                          FractionallySizedBox(
                            widthFactor: (user.xp % 1000) / 1000,
                            child: Container(
                              height: 12,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    AppColors.primaryHighlight,
                                    Color(0xFFA0FF00), // Slightly different shade for gradient effect
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryHighlight.withAlpha(100),
                                    blurRadius: 12,
                                    spreadRadius: -2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
