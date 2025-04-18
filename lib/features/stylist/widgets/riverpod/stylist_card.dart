import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zinapp_v2/features/stylist/extensions/stylist_extensions.dart';
import 'package:zinapp_v2/models/stylist.dart';
import 'package:zinapp_v2/router/app_routes.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/utils/image_utils.dart';

/// A card displaying stylist information in the discovery section
class StylistCard extends StatelessWidget {
  final Stylist stylist;
  final Function(Stylist)? onTap;
  final bool showBookButton;
  final bool compact;

  const StylistCard({
    super.key,
    required this.stylist,
    this.onTap,
    this.showBookButton = true,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap != null ? () => onTap!(stylist) : () {
        context.go(AppRoutes.stylistDetail.replaceFirst(':id', stylist.id));
      },
      child: Container(
        width: compact ? 120 : 160,
        height: compact ? 180 : 240,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: AppColors.baseDark.withAlpha(179), // 0.7 opacity
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(51), // 0.2 opacity
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stylist image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: SizedBox(
                height: compact ? 80 : 110,
                width: double.infinity,
                child: ImageUtils.loadNetworkImage(
                  imageUrl: stylist.profileImageUrl,
                  fit: BoxFit.cover,
                  errorWidget: Container(
                    color: AppColors.primaryHighlight.withAlpha(51), // 0.2 opacity
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: AppColors.primaryHighlight,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Stylist info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    stylist.name,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: compact ? 12 : 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Rating
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: compact ? 12 : 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${stylist.rating.toStringAsFixed(1)} (${stylist.reviewCount})',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                          fontSize: compact ? 10 : 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Book button
                  if (showBookButton && !compact)
                    SizedBox(
                      width: double.infinity,
                      height: 28,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to booking screen
                          context.go(AppRoutes.booking);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryHighlight,
                          foregroundColor: AppColors.baseDark,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Book',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
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
