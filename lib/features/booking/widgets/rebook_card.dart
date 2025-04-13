import 'package:flutter/material.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/dashboard/expandable_dashboard_card.dart';

/// A card that displays quick rebook options for favorite stylists
class RebookCard extends StatelessWidget {
  /// List of favorite stylist IDs
  final List<String> favoriteStylists;
  
  /// Callback when a stylist is tapped
  final Function(String)? onStylistTap;
  
  /// Callback when the book now button is tapped
  final VoidCallback? onBookNowTap;

  /// Creates a rebook card
  const RebookCard({
    super.key,
    required this.favoriteStylists,
    this.onStylistTap,
    this.onBookNowTap,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableDashboardCard(
      title: 'Quick Rebook',
      icon: Icons.replay,
      accentColor: Colors.orange,
      collapsedChild: _buildCollapsedContent(context),
      expandedChild: _buildExpandedContent(context),
    );
  }

  Widget _buildCollapsedContent(BuildContext context) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: onBookNowTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.calendar_today,
                color: Colors.orange,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Book Your Next Appointment',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Quick and easy booking',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    final theme = Theme.of(context);
    
    // Mock stylist data
    final stylists = [
      {
        'id': favoriteStylists.isNotEmpty ? favoriteStylists[0] : 'stylist1',
        'name': 'Alex Johnson',
        'specialty': 'Hair Stylist',
        'rating': 4.9,
      },
      {
        'id': favoriteStylists.length > 1 ? favoriteStylists[1] : 'stylist2',
        'name': 'Jamie Smith',
        'specialty': 'Color Specialist',
        'rating': 4.7,
      },
      {
        'id': favoriteStylists.length > 2 ? favoriteStylists[2] : 'stylist3',
        'name': 'Taylor Wilson',
        'specialty': 'Stylist & Colorist',
        'rating': 4.8,
      },
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Book With Your Favorite Stylists',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Quick access to stylists you love',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 16),
        
        // Stylist list
        ...stylists.map((stylist) => _buildStylistItem(context, stylist)).toList(),
        
        const SizedBox(height: 16),
        
        // Book now button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onBookNowTap,
            icon: const Icon(Icons.add),
            label: const Text('Book New Appointment'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryHighlight,
              foregroundColor: AppColors.baseDark,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStylistItem(BuildContext context, Map<String, dynamic> stylist) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => onStylistTap?.call(stylist['id'] as String),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.baseDarkAccent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Stylist avatar placeholder
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Stylist details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stylist['name'] as String,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      stylist['specialty'] as String,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Rating
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${stylist['rating']}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 8),
              
              // Book button
              ElevatedButton(
                onPressed: onBookNowTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  minimumSize: const Size(0, 32),
                  textStyle: theme.textTheme.labelSmall,
                ),
                child: const Text('Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
