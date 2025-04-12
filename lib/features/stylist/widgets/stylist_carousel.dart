import 'package:flutter/material.dart';
// Revert imports to original paths as moves failed/incomplete
import 'package:zinapp_v2/app/features/stylist/widgets/stylist_card.dart';
import 'package:zinapp_v2/app/models/stylist.dart';
import 'package:zinapp_v2/app/theme/color_scheme.dart';

/// A horizontal carousel of stylist cards
class StylistCarousel extends StatelessWidget {
  final String title;
  final List<Stylist> stylists;
  final bool isLoading;
  final String? errorMessage;
  final Function(Stylist)? onStylistTap;
  final VoidCallback? onSeeAllTap;
  final bool showBookButton;

  const StylistCarousel({
    super.key, // Correct way to handle key
    required this.title,
    required this.stylists,
    this.isLoading = false,
    this.errorMessage,
    this.onStylistTap,
    this.onSeeAllTap,
    this.showBookButton = true,
  }); // Remove incorrect super(key: key) from here

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title row with "See All" button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (onSeeAllTap != null && stylists.isNotEmpty)
                TextButton(
                  onPressed: onSeeAllTap,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryHighlight,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'See All',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.primaryHighlight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Stylist cards
        // Wrap in Expanded to allow the list container to fill remaining space
        Expanded(
          child: SizedBox(
            // Keep height constraint for the ListView itself if needed,
            // or remove if Expanded should fully dictate the height.
            // Let's keep it for now as it might relate to card size.
            height: 220,
            child: _buildContent(context),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return _buildLoadingState();
    }

    if (errorMessage != null) {
      return _buildErrorState(context); // Pass context
    }

    if (stylists.isEmpty) {
      return _buildEmptyState(context); // Pass context
    }

    return _buildStylistList();
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          width: 160,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: AppColors.baseDark.withOpacity(0.7),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryHighlight,
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorState(BuildContext context) { // Add context parameter
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          errorMessage ?? 'An error occurred',
          // Apply style using theme
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) { // Add context parameter
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'No stylists found',
          // Apply style using theme
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white.withOpacity(0.7),
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildStylistList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: stylists.length,
      itemBuilder: (context, index) {
        final stylist = stylists[index];
        return StylistCard(
          stylist: stylist,
          onTap: onStylistTap != null ? () => onStylistTap!(stylist) : null,
          showBookButton: showBookButton,
        );
      },
    );
  }
}
