import 'package:flutter/material.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// A card that displays an achievement with its icon, title, and locked/unlocked state.
class AchievementCard extends StatelessWidget {
  final String title;
  final IconData iconData;
  final bool isUnlocked;
  final String rarity;
  final VoidCallback? onTap;

  const AchievementCard({
    super.key,
    required this.title,
    required this.iconData,
    required this.isUnlocked,
    required this.rarity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Determine colors based on rarity and unlock status
    Color backgroundColor;
    Color iconColor;
    Color borderColor;
    
    if (!isUnlocked) {
      backgroundColor = Colors.grey.withAlpha(26); // 0.1 opacity
      iconColor = Colors.grey.withAlpha(128); // 0.5 opacity
      borderColor = Colors.grey.withAlpha(77); // 0.3 opacity
    } else {
      switch (rarity.toLowerCase()) {
        case 'common':
          backgroundColor = Colors.blue.withAlpha(51); // 0.2 opacity
          iconColor = Colors.blue;
          borderColor = Colors.blue.withAlpha(77); // 0.3 opacity
          break;
        case 'uncommon':
          backgroundColor = Colors.green.withAlpha(51); // 0.2 opacity
          iconColor = Colors.green;
          borderColor = Colors.green.withAlpha(77); // 0.3 opacity
          break;
        case 'rare':
          backgroundColor = Colors.purple.withAlpha(51); // 0.2 opacity
          iconColor = Colors.purple;
          borderColor = Colors.purple.withAlpha(77); // 0.3 opacity
          break;
        case 'epic':
          backgroundColor = Colors.orange.withAlpha(51); // 0.2 opacity
          iconColor = Colors.orange;
          borderColor = Colors.orange.withAlpha(77); // 0.3 opacity
          break;
        case 'legendary':
          backgroundColor = AppColors.primaryHighlight.withAlpha(51); // 0.2 opacity
          iconColor = AppColors.primaryHighlight;
          borderColor = AppColors.primaryHighlight.withAlpha(77); // 0.3 opacity
          break;
        default:
          backgroundColor = Colors.blue.withAlpha(51); // 0.2 opacity
          iconColor = Colors.blue;
          borderColor = Colors.blue.withAlpha(77); // 0.3 opacity
      }
    }
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
          boxShadow: isUnlocked ? [
            BoxShadow(
              color: borderColor.withAlpha(77), // 0.3 opacity
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ] : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isUnlocked ? backgroundColor.withAlpha(128) : backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                color: iconColor,
                size: 32,
              ),
            ),
            const SizedBox(height: 8),
            
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: isUnlocked ? FontWeight.bold : FontWeight.normal,
                  color: isUnlocked ? theme.colorScheme.onSurface : theme.colorScheme.onSurface.withAlpha(128),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            // Rarity
            if (isUnlocked) ...[
              const SizedBox(height: 4),
              Text(
                rarity,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: iconColor.withAlpha(179), // 0.7 opacity
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
