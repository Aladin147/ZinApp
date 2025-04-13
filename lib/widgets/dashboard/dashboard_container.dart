import 'package:flutter/material.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/backgrounds/organic_background.dart';

/// A container for dashboard layouts
/// Organizes dashboard cards in a scrollable view
class DashboardContainer extends StatelessWidget {
  /// List of widgets to display in the dashboard
  final List<Widget> children;

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

  /// Scroll physics for the dashboard
  final ScrollPhysics? physics;

  /// Scroll controller for the dashboard
  final ScrollController? controller;

  /// Creates a dashboard container
  const DashboardContainer({
    super.key,
    required this.children,
    this.padding = const EdgeInsets.all(16),
    this.widgetSpacing = 16,
    this.useOrganicBackground = true,
    this.backgroundColor = AppColors.baseDarkDeeper,
    this.useSliver = false,
    this.physics,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final content = ListView.separated(
      controller: controller,
      padding: padding,
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
      separatorBuilder: (context, index) => SizedBox(height: widgetSpacing),
      physics: physics ?? const BouncingScrollPhysics(),
      shrinkWrap: useSliver,
      // Don't set primary to true, let the framework decide based on controller
      primary: controller == null && !useSliver ? true : false,
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

/// A sliver implementation of the dashboard container
class SliverDashboardContainer extends StatelessWidget {
  /// List of widgets to display in the dashboard
  final List<Widget> children;

  /// Padding around the dashboard
  final EdgeInsetsGeometry padding;

  /// Spacing between widgets
  final double widgetSpacing;

  /// Whether to use the organic background
  final bool useOrganicBackground;

  /// Background color (used if not using organic background)
  final Color backgroundColor;

  /// Scroll physics for the dashboard
  final ScrollPhysics? physics;

  /// Creates a sliver dashboard container
  const SliverDashboardContainer({
    super.key,
    required this.children,
    this.padding = const EdgeInsets.all(16),
    this.widgetSpacing = 16,
    this.useOrganicBackground = true,
    this.backgroundColor = AppColors.baseDarkDeeper,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardContainer(
      children: children,
      padding: padding,
      widgetSpacing: widgetSpacing,
      useOrganicBackground: useOrganicBackground,
      backgroundColor: backgroundColor,
      useSliver: true,
      physics: physics,
    );
  }
}
