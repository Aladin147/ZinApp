import 'package:flutter/material.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// Avatar sizes following the ZinApp V2 design system
enum ZinAvatarSize {
  /// Small avatar (32px)
  small,

  /// Medium avatar (48px)
  medium,

  /// Large avatar (64px)
  large,

  /// Extra large avatar (96px)
  extraLarge
}

/// Status indicators for avatars
enum ZinAvatarStatus {
  /// No status indicator
  none,

  /// Online/available status (green)
  online,

  /// Busy/unavailable status (red)
  busy,

  /// Away/idle status (amber)
  away
}

/// A standardized avatar component for the ZinApp V2 application.
///
/// ZinAvatar provides consistent styling and behavior for all user avatars
/// in the application, following the ZinApp V2 design system.
///
/// Features:
/// - Multiple sizes: small, medium, large, extraLarge
/// - Support for images, initials, and placeholders
/// - Status indicator
/// - Border customization
///
/// Example usage:
/// ```dart
/// ZinAvatar(
///   imageUrl: 'https://example.com/avatar.jpg',
///   size: ZinAvatarSize.medium,
///   status: ZinAvatarStatus.online,
/// );
/// ```
class ZinAvatar extends StatelessWidget {
  /// URL of the avatar image
  final String? imageUrl;

  /// Initials to display when no image is available
  final String? initials;

  /// Size of the avatar
  final ZinAvatarSize size;

  /// Status indicator to display
  final ZinAvatarStatus status;

  /// Optional border color
  final Color? borderColor;

  /// Optional border width
  final double? borderWidth;

  /// Optional background color (used for initials or placeholder)
  final Color? backgroundColor;

  /// Optional foreground color (used for initials)
  final Color? foregroundColor;

  /// Optional callback when the avatar is tapped
  final VoidCallback? onTap;

  const ZinAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = ZinAvatarSize.medium,
    this.status = ZinAvatarStatus.none,
    this.borderColor,
    this.borderWidth,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double avatarSize = _getAvatarSize(size);
    final double statusSize = avatarSize * 0.3;
    final double effectiveBorderWidth = borderWidth ?? (status != ZinAvatarStatus.none ? 2.0 : 0.0);

    // Build the avatar
    Widget avatar = Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? _getDefaultBackgroundColor(),
        border: effectiveBorderWidth > 0
            ? Border.all(
                color: borderColor ?? AppColors.baseDark,
                width: effectiveBorderWidth,
              )
            : null,
      ),
      child: ClipOval(
        child: _buildAvatarContent(avatarSize),
      ),
    );

    // Add status indicator if needed
    if (status != ZinAvatarStatus.none) {
      avatar = Stack(
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: statusSize,
              height: statusSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getStatusColor(status),
                border: Border.all(
                  color: AppColors.baseDark,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Add tap behavior if needed
    if (onTap != null) {
      avatar = GestureDetector(
        onTap: onTap,
        child: avatar,
      );
    }

    return avatar;
  }

  /// Builds the content of the avatar (image, initials, or placeholder)
  Widget _buildAvatarContent(double size) {
    // If image URL is provided, try to load the image
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // Fall back to initials or placeholder on error
          return _buildFallbackContent(size);
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          // Show a loading indicator while the image is loading
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
              strokeWidth: 2.0,
              color: AppColors.primaryHighlight,
            ),
          );
        },
      );
    }

    // If no image, use fallback content
    return _buildFallbackContent(size);
  }

  /// Builds fallback content (initials or placeholder)
  Widget _buildFallbackContent(double size) {
    // If initials are provided, show them
    if (initials != null && initials!.isNotEmpty) {
      return Center(
        child: Text(
          initials!.length > 2 ? initials!.substring(0, 2) : initials!,
          style: TextStyle(
            color: foregroundColor ?? AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: size * 0.4,
          ),
        ),
      );
    }

    // Otherwise, show a placeholder icon
    return Icon(
      Icons.person,
      size: size * 0.5,
      color: foregroundColor ?? AppColors.textSecondary,
    );
  }

  /// Gets the appropriate avatar size in pixels
  double _getAvatarSize(ZinAvatarSize size) {
    switch (size) {
      case ZinAvatarSize.small:
        return 32.0;
      case ZinAvatarSize.medium:
        return 48.0;
      case ZinAvatarSize.large:
        return 64.0;
      case ZinAvatarSize.extraLarge:
        return 96.0;
    }
  }

  /// Gets the default background color for the avatar
  Color _getDefaultBackgroundColor() {
    // Generate a consistent color based on initials if available
    if (initials != null && initials!.isNotEmpty) {
      // Simple hash function to generate a consistent color
      final int hash = initials!.codeUnits.fold(0, (prev, element) => prev + element);
      final List<Color> colors = [
        AppColors.coolBlue,
        AppColors.coral,
        AppColors.jadeLight,
        AppColors.primaryHighlight,
      ];
      return colors[hash % colors.length];
    }

    // Default background color
    return AppColors.baseDark.withOpacity(0.8);
  }

  /// Gets the appropriate status indicator color
  Color _getStatusColor(ZinAvatarStatus status) {
    switch (status) {
      case ZinAvatarStatus.none:
        return Colors.transparent;
      case ZinAvatarStatus.online:
        return const Color(0xFF4CAF50); // Green
      case ZinAvatarStatus.busy:
        return const Color(0xFFF44336); // Red
      case ZinAvatarStatus.away:
        return const Color(0xFFFFB300); // Amber
    }
  }
}
