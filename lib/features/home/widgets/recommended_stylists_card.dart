import 'package:flutter/material.dart';
import 'package:zinapp_v2/models/stylist.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/dashboard/expandable_dashboard_card.dart';
import 'package:zinapp_v2/widgets/zin_avatar.dart';

/// A card that displays recommended stylists
class RecommendedStylistsCard extends StatelessWidget {
  /// List of recommended stylists
  final List<Stylist> stylists;
  
  /// Callback when a stylist is tapped
  final Function(Stylist)? onStylistTap;
  
  /// Callback when the view all button is tapped
  final VoidCallback? onViewAllTap;
  
  /// Initial state of the card
  final DashboardCardState initialState;

  /// Creates a recommended stylists card
  const RecommendedStylistsCard({
    super.key,
    required this.stylists,
    this.onStylistTap,
    this.onViewAllTap,
    this.initialState = DashboardCardState.collapsed,
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context); // Removed unused variable
    
    return ExpandableDashboardCard(
      title: 'Recommended Stylists',
      subtitle: 'Based on your preferences',
      icon: Icons.recommend,
      accentColor: Colors.blue,
      initialState: initialState,
      onViewAllTap: onViewAllTap,
      
      // Collapsed view - horizontal list of stylists
      collapsedChild: stylists.isEmpty
          ? _buildEmptyState(context)
          : SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: stylists.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  return _buildStylistItem(
                    context,
                    stylist: stylists[index],
                    onTap: () => onStylistTap?.call(stylists[index]),
                  );
                },
              ),
            ),
      
      // Expanded view - list of stylists with more details
      expandedChild: stylists.isEmpty
          ? _buildEmptyState(context)
          : Column(
              children: [
                // Specialization filter
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildSpecializationChip(context, 'All', isSelected: true),
                      _buildSpecializationChip(context, 'Haircut'),
                      _buildSpecializationChip(context, 'Color'),
                      _buildSpecializationChip(context, 'Styling'),
                      _buildSpecializationChip(context, 'Treatment'),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // List of stylists
                ...stylists.map((stylist) => _buildDetailedStylistItem(
                  context,
                  stylist: stylist,
                  onTap: () => onStylistTap?.call(stylist),
                )),
              ],
            ),
    );
  }
  
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_search,
            color: Colors.white.withOpacity(0.5),
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            'No recommended stylists yet',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStylistItem(
    BuildContext context, {
    required Stylist stylist,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 80,
        child: Column(
          children: [
            // Stylist avatar
            ZinAvatar(
              size: ZinAvatarSize.large,
              imageUrl: stylist.profilePictureUrl,
              initials: stylist.username.isNotEmpty ? stylist.username[0] : '?',
            ),
            
            const SizedBox(height: 8),
            
            // Stylist name
            Text(
              stylist.username,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            
            // Stylist rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 14,
                ),
                const SizedBox(width: 2),
                Text(
                  stylist.stylistProfile.rating.toString(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDetailedStylistItem(
    BuildContext context, {
    required Stylist stylist,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.baseDarkAccent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Stylist avatar
              ZinAvatar(
                size: ZinAvatarSize.medium,
                imageUrl: stylist.profilePictureUrl,
                initials: stylist.username.isNotEmpty ? stylist.username[0] : '?',
              ),
              
              const SizedBox(width: 12),
              
              // Stylist details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          stylist.username,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Lvl ${stylist.level}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.blue,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      stylist.stylistProfile.specialization,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildStylistStat(
                          context,
                          icon: Icons.star,
                          value: stylist.stylistProfile.rating.toString(),
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 12),
                        _buildStylistStat(
                          context,
                          icon: Icons.people,
                          value: '${stylist.stylistProfile.clientCount}',
                          color: Colors.green,
                        ),
                        const SizedBox(width: 12),
                        _buildStylistStat(
                          context,
                          icon: Icons.calendar_today,
                          value: '${stylist.stylistProfile.completedBookings}',
                          color: Colors.purple,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Availability indicator
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: stylist.stylistProfile.isAvailable
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  stylist.stylistProfile.isAvailable
                      ? Icons.check
                      : Icons.close,
                  color: stylist.stylistProfile.isAvailable
                      ? Colors.green
                      : Colors.red,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildStylistStat(
    BuildContext context, {
    required IconData icon,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 14,
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
  
  Widget _buildSpecializationChip(
    BuildContext context,
    String label, {
    bool isSelected = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          // TODO: Implement specialization filtering
        },
        backgroundColor: AppColors.baseDarkAccent,
        selectedColor: Colors.blue.withOpacity(0.3),
        checkmarkColor: Colors.blue,
        labelStyle: TextStyle(
          color: isSelected ? Colors.blue : Colors.white.withOpacity(0.7),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 1,
          ),
        ),
      ),
    );
  }
}
