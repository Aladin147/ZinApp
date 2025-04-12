import 'package:flutter/material.dart';
import 'package:zinapp_v2/features/stylist/widgets/stylist_card.dart';
import 'package:zinapp_v2/models/stylist.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

class ActionHubSection extends StatelessWidget {
  final List<Stylist> stylists;
  final bool isLoading;
  final String? errorMessage;

  const ActionHubSection({
    Key? key,
    required this.stylists,
    required this.isLoading,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.baseDark.withOpacity(0.9),
            AppColors.baseDark.withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick action buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  context,
                  icon: Icons.search,
                  label: 'Find',
                  onTap: () {},
                  color: Colors.blue,
                ),
                _buildActionButton(
                  context,
                  icon: Icons.calendar_today,
                  label: 'Book',
                  onTap: () {},
                  color: Colors.green,
                ),
                _buildActionButton(
                  context,
                  icon: Icons.camera_alt,
                  label: 'Share',
                  onTap: () {},
                  color: Colors.purple,
                ),
                _buildActionButton(
                  context,
                  icon: Icons.star,
                  label: 'Quests',
                  onTap: () {},
                  color: Colors.orange,
                ),
              ],
            ),
          ),

          // Trending styles section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trending Styles',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryHighlight,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 100,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: AppColors.baseDark,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Style image
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Container(
                              height: 80,
                              color: Colors.grey.withOpacity(0.2),
                              child: Center(
                                child: Icon(
                                  Icons.style,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                          // Style name
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Style ${index + 1}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Featured stylists section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Stylists',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryHighlight,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 220,
                child: _buildStylistsList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStylistsList() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Text(
          errorMessage!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (stylists.isEmpty) {
      return Center(
        child: Text(
          'No stylists found',
          style: TextStyle(color: Colors.white.withOpacity(0.7)),
        ),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: stylists.length,
      itemBuilder: (context, index) {
        return StylistCard(
          stylist: stylists[index],
          onTap: () {},
          showBookButton: false,
        );
      },
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 70,
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
