import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zinapp_v2/common/widgets/frosted_glass_container.dart';
import 'package:zinapp_v2/router/app_routes.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// Provider for the current navigation index
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

/// A custom bottom navigation bar for the main app navigation
class ZinBottomNavBar extends ConsumerWidget {
  const ZinBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);
    final theme = Theme.of(context);

    return FrostedGlassContainer(
      blurAmount: 15,
      backgroundColor: theme.scaffoldBackgroundColor,
      backgroundOpacity: 0.85, // Increased opacity for better visibility
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      border: Border.all(
        color: Colors.white.withOpacity(0.2),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 20,
          offset: const Offset(0, -5),
        ),
      ],
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                ref,
                index: 0,
                icon: Icons.home_rounded,
                label: 'Home',
                route: AppRoutes.home,
              ),
              _buildNavItem(
                context,
                ref,
                index: 1,
                icon: Icons.explore_rounded,
                label: 'Discover',
                route: AppRoutes.stylistList,
              ),
              _buildCreateButton(context, ref),
              _buildNavItem(
                context,
                ref,
                index: 3,
                icon: Icons.emoji_events_rounded,
                label: 'Rewards',
                route: AppRoutes.rewardsHub,
              ),
              _buildNavItem(
                context,
                ref,
                index: 4,
                icon: Icons.person_rounded,
                label: 'Profile',
                route: AppRoutes.profile,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    WidgetRef ref, {
    required int index,
    required IconData icon,
    required String label,
    required String route,
  }) {
    final currentIndex = ref.watch(bottomNavIndexProvider);
    final isSelected = currentIndex == index;
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        ref.read(bottomNavIndexProvider.notifier).state = index;
        context.go(route);
      },
      customBorder: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primaryHighlight : theme.colorScheme.onSurface.withOpacity(0.6),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isSelected ? AppColors.primaryHighlight : theme.colorScheme.onSurface.withOpacity(0.6),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateButton(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        // TODO: Implement create post functionality
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Create post feature coming soon!'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryHighlight,
              AppColors.primaryHighlight.withOpacity(0.8),
            ],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryHighlight.withOpacity(0.3),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: const Icon(
          Icons.add_rounded,
          color: Colors.black,
          size: 32,
        ),
      ),
    );
  }
}
