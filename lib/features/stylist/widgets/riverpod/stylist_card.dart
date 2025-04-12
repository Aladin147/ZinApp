import 'package:flutter/material.dart';
import 'package:zinapp_v2/features/stylist/extensions/stylist_extensions.dart';
import 'package:zinapp_v2/models/stylist.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// A card displaying stylist information in the discovery section
class StylistCard extends StatelessWidget {
  final Stylist stylist;
  final VoidCallback? onTap;
  final bool showBookButton;

  const StylistCard({
    super.key,
    required this.stylist,
    this.onTap,
    this.showBookButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        height: 220,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stylist image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: SizedBox(
                height: 120,
                width: double.infinity,
                child: stylist.profileImageUrl != null
                    ? Image.network(
                        stylist.profileImageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.primaryHighlight.withAlpha(51), // 0.2 opacity
                            child: const Center(
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: AppColors.primaryHighlight,
                              ),
                            ),
                          );
                        },
                      )
                    : Container(
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

            // Stylist info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    stylist.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Rating
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${stylist.rating.toStringAsFixed(1)} (${stylist.reviewCount})',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Book button
                  if (showBookButton)
                    SizedBox(
                      width: double.infinity,
                      height: 28,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement booking functionality
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
