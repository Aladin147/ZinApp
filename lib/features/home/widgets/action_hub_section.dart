import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zinapp_v2/features/stylist/widgets/riverpod/stylist_card.dart';
import 'package:zinapp_v2/models/stylist.dart';
import 'package:zinapp_v2/router/app_routes.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/containers/organic_container.dart';
import 'package:zinapp_v2/widgets/buttons/organic_action_button.dart';


class ActionHubSection extends StatelessWidget {
  final List<Stylist> stylists;
  final bool isLoading;
  final String? errorMessage;

  const ActionHubSection({
    super.key,
    required this.stylists,
    required this.isLoading,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OrganicContainer(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: AppColors.baseDark,
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.baseDarkAlt,
          AppColors.baseDark,
        ],
      ),
      shape: OrganicShape.curvedBottom,
      curveHeight: 20,
      elevation: 2,
      borderRadius: 0,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(30),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
        BoxShadow(
          color: AppColors.primaryHighlight.withAlpha(10),
          blurRadius: 8,
          spreadRadius: 0,
          offset: const Offset(0, 2),
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick action buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: OrganicActionButtonRow(
              buttons: [
                OrganicActionButtonData(
                  icon: Icons.search,
                  label: 'Find',
                  onTap: () {
                    context.go(AppRoutes.stylistList);
                  },
                  color: Colors.blue,
                ),
                OrganicActionButtonData(
                  icon: Icons.calendar_today,
                  label: 'Book',
                  onTap: () {
                    context.go(AppRoutes.booking);
                  },
                  color: Colors.green,
                ),
                OrganicActionButtonData(
                  icon: Icons.camera_alt,
                  label: 'Share',
                  onTap: () {},
                  color: Colors.purple,
                ),
                OrganicActionButtonData(
                  icon: Icons.star,
                  label: 'Quests',
                  onTap: () {},
                  color: Colors.orange,
                ),
              ],
              usePillShape: true,
              enhancedEffects: true,
              buttonSize: 60,
              iconSize: 26,
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
                    onPressed: () {
                    context.go(AppRoutes.stylistList);
                  },
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
                            color: Colors.black.withAlpha(26), // 0.1 opacity
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
                              color: Colors.grey.withAlpha(51), // 0.2 opacity
                              child: Center(
                                child: Icon(
                                  Icons.style,
                                  color: Colors.grey.withAlpha(128), // 0.5 opacity
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
                    onPressed: () {
                    context.go(AppRoutes.stylistList);
                  },
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
          style: TextStyle(color: Colors.white.withAlpha(179)), // 0.7 opacity
        ),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: stylists.length,
      itemBuilder: (context, index) {
        return StylistCard(
          stylist: stylists[index],
          onTap: (stylist) {
            context.go(AppRoutes.stylistDetail.replaceFirst(':id', stylist.id));
          },
          showBookButton: false,
        );
      },
    );
  }


}
