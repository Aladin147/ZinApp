import 'package:flutter/material.dart';
import 'package:zinapp_v2/models/stylist.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// A card displaying stylist information in the discovery section
class StylistCard extends StatelessWidget {
  final Stylist stylist;
  final VoidCallback? onTap;
  final bool showBookButton;

  const StylistCard({
    Key? key,
    required this.stylist,
    this.onTap,
    this.showBookButton = true,
  }) : super(key: key);

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
          color: AppColors.baseDark.withOpacity(0.7),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile image with availability indicator
              Stack(
                children: [
                  // Profile image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: stylist.profilePictureUrl != null
                        ? Image.asset(
                            stylist.profilePictureUrl!,
                            width: 160,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 160,
                                height: 120,
                                color: AppColors.baseDark,
                                child: const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: AppColors.primaryHighlight,
                                ),
                              );
                            },
                          )
                        : Container(
                            width: 160,
                            height: 120,
                            color: AppColors.baseDark,
                            child: const Icon(
                              Icons.person,
                              size: 40,
                              color: AppColors.primaryHighlight,
                            ),
                          ),
                  ),
                  // Availability indicator
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: stylist.stylistProfile.isAvailable
                            ? Colors.green
                            : Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        stylist.stylistProfile.isAvailable
                            ? 'Available'
                            : 'Unavailable',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Level badge
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryHighlight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Lvl ${stylist.level}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.baseDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Stylist info
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      stylist.username,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Specialization
                    Text(
                      stylist.stylistProfile.specialization,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Rating
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${stylist.stylistProfile.rating} (${stylist.stylistProfile.reviewCount})',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    if (showBookButton) ...[
                      const SizedBox(height: 12),
                      // Book button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: stylist.stylistProfile.isAvailable
                              ? () {}
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryHighlight,
                            foregroundColor: AppColors.baseDark,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            textStyle: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text('BOOK'),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
