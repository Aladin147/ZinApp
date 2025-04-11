import 'package:flutter/material.dart';

/// A widget for displaying user or stylist avatars.
/// Handles circular shape and potential placeholder/loading states.
class Avatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final String? initials; // Displayed if imageUrl is null or fails to load
  final Color? backgroundColor; // Placeholder background
  final Color? foregroundColor; // Placeholder text color

  const Avatar({
    super.key,
    this.imageUrl,
    this.radius = 24.0, // Default size
    this.initials,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBgColor = backgroundColor ?? theme.colorScheme.surfaceVariant;
    final effectiveFgColor = foregroundColor ?? theme.colorScheme.onSurfaceVariant;

    // Determine initials if not provided and name is available (future enhancement)
    final displayInitials = initials ?? '?'; // Simple placeholder

    // TODO: Implement actual image loading with error handling/placeholder
    // Using NetworkImage or CachedNetworkImage package

    Widget placeholder = Center(
      child: Text(
        displayInitials.isNotEmpty ? displayInitials[0].toUpperCase() : '?',
        style: theme.textTheme.titleMedium?.copyWith(
          color: effectiveFgColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    // For now, just show placeholder
    Widget avatarContent = placeholder;

    // Example using NetworkImage (needs error handling)
    // if (imageUrl != null && imageUrl!.isNotEmpty) {
    //   avatarContent = CircleAvatar(
    //     radius: radius,
    //     backgroundImage: NetworkImage(imageUrl!),
    //     backgroundColor: effectiveBgColor, // Show bg while loading
    //     onBackgroundImageError: (exception, stackTrace) {
    //       // Optionally log error
    //     },
    //     child: Builder( // Use Builder to show placeholder only if image fails
    //       builder: (context) {
    //         final imageProvider = NetworkImage(imageUrl!);
    //         // This check isn't perfect for detecting load failures in CircleAvatar
    //         // A better approach uses Image.network with errorBuilder
    //         return placeholder; // Simplified: always show placeholder for now
    //       }
    //     ),
    //   );
    // } else {
    //   avatarContent = CircleAvatar(
    //     radius: radius,
    //     backgroundColor: effectiveBgColor,
    //     child: placeholder,
    //   );
    // }

    // Using ClipOval for better control with Image.network (recommended)
    ImageProvider? imageProvider;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
       // Basic check for asset vs network - refine later
      if (imageUrl!.startsWith('assets/')) {
         imageProvider = AssetImage(imageUrl!);
      } else {
         imageProvider = NetworkImage(imageUrl!);
      }
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: effectiveBgColor,
      // Use foregroundImage for better error handling than backgroundImage
      foregroundImage: imageProvider,
      onForegroundImageError: (exception, stackTrace) {
         // Log error if needed
         print('Error loading avatar image: $exception');
      },
      // Child is displayed if foregroundImage fails or is null
      child: placeholder,
    );
  }
}

/*
  Example Usage:

  Avatar(
    radius: 30,
    imageUrl: 'assets/images/avatars/hassan.png', // Example asset
    initials: 'HA',
  )

  Avatar(
    radius: 20,
    imageUrl: 'https://example.com/user.jpg', // Example network image
    initials: 'SJ',
  )

  Avatar(
    radius: 25,
    initials: 'AK', // No image URL provided
  )
*/
