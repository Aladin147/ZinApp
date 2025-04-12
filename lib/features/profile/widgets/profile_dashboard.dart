import 'package:flutter/material.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/backgrounds/organic_background.dart';

/// A dashboard-style container for the user profile
/// Displays widgets in a unified, scrollable view
class ProfileDashboard extends StatelessWidget {
  /// The user profile to display
  final UserProfile user;

  /// List of widgets to display in the dashboard
  final List<Widget> widgets;

  /// Padding around the dashboard
  final EdgeInsetsGeometry padding;

  /// Spacing between widgets
  final double widgetSpacing;

  /// Whether to use the organic background
  final bool useOrganicBackground;

  /// Background color (used if not using organic background)
  final Color backgroundColor;

  /// Whether to use a sliver-based implementation
  /// (for use within CustomScrollView)
  final bool useSliver;

  /// Creates a profile dashboard
  const ProfileDashboard({
    super.key,
    required this.user,
    required this.widgets,
    this.padding = const EdgeInsets.all(16),
    this.widgetSpacing = 16,
    this.useOrganicBackground = true,
    this.backgroundColor = AppColors.baseDarkDeeper,
    this.useSliver = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = ListView.separated(
      padding: padding,
      itemCount: widgets.length,
      itemBuilder: (context, index) => widgets[index],
      separatorBuilder: (context, index) => SizedBox(height: widgetSpacing),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: useSliver,
      // Don't set primary to true, let the framework decide
      primary: useSliver ? false : null,
    );

    if (useSliver) {
      return SliverToBoxAdapter(
        child: useOrganicBackground
            ? OrganicBackground(
                backgroundColor: backgroundColor,
                shapeColor: AppColors.baseDarkAccent,
                numberOfShapes: 3,
                shapeOpacity: 0.05,
                animate: true,
                child: content,
              )
            : content,
      );
    }

    return useOrganicBackground
        ? OrganicBackground(
            backgroundColor: backgroundColor,
            shapeColor: AppColors.baseDarkAccent,
            numberOfShapes: 3,
            shapeOpacity: 0.05,
            animate: true,
            child: content,
          )
        : content;
  }
}

/// A sliver implementation of the profile dashboard
class SliverProfileDashboard extends StatelessWidget {
  /// The user profile to display
  final UserProfile user;

  /// List of widgets to display in the dashboard
  final List<Widget> widgets;

  /// Padding around the dashboard
  final EdgeInsetsGeometry padding;

  /// Spacing between widgets
  final double widgetSpacing;

  /// Whether to use the organic background
  final bool useOrganicBackground;

  /// Background color (used if not using organic background)
  final Color backgroundColor;

  /// Creates a sliver profile dashboard
  const SliverProfileDashboard({
    super.key,
    required this.user,
    required this.widgets,
    this.padding = const EdgeInsets.all(16),
    this.widgetSpacing = 16,
    this.useOrganicBackground = true,
    this.backgroundColor = AppColors.baseDarkDeeper,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileDashboard(
      user: user,
      widgets: widgets,
      padding: padding,
      widgetSpacing: widgetSpacing,
      useOrganicBackground: useOrganicBackground,
      backgroundColor: backgroundColor,
      useSliver: true,
    );
  }
}
