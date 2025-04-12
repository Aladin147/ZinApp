import 'package:flutter/material.dart';

/// A container with a customizable gradient background.
///
/// This widget creates a container with a gradient background that can be
/// customized with different colors, directions, and shapes.
class GradientBackgroundContainer extends StatelessWidget {
  /// The child widget to display inside the container.
  final Widget child;

  /// The width of the container. If null, the container will expand to fill its parent.
  final double? width;

  /// The height of the container. If null, the container will expand to fill its parent.
  final double? height;

  /// The padding to apply to the child.
  final EdgeInsetsGeometry padding;

  /// The margin to apply around the container.
  final EdgeInsetsGeometry margin;

  /// The border radius of the container.
  final BorderRadius? borderRadius;

  /// The gradient to apply as the background.
  final Gradient gradient;

  /// The box shadow to apply to the container.
  final List<BoxShadow>? boxShadow;

  /// The border to apply around the container.
  final BoxBorder? border;

  const GradientBackgroundContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.borderRadius,
    required this.gradient,
    this.boxShadow,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        border: border,
      ),
      child: child,
    );
  }

  /// Creates a soft gradient background container with preset properties.
  factory GradientBackgroundContainer.soft({
    required Widget child,
    double? width,
    double? height,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    BoxBorder? border,
    List<Color>? colors,
  }) {
    return GradientBackgroundContainer(
      child: child,
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      border: border,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors ??
            [
              const Color(0xFFF8F9FA),
              const Color(0xFFE9ECEF),
            ],
      ),
    );
  }

  /// Creates a dark gradient background container with preset properties.
  factory GradientBackgroundContainer.dark({
    required Widget child,
    double? width,
    double? height,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    BoxBorder? border,
    List<Color>? colors,
  }) {
    return GradientBackgroundContainer(
      child: child,
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      border: border,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors ??
            [
              const Color(0xFF212529),
              const Color(0xFF343A40),
            ],
      ),
    );
  }

  /// Creates a colorful gradient background container with preset properties.
  factory GradientBackgroundContainer.colorful({
    required Widget child,
    double? width,
    double? height,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    BoxBorder? border,
    List<Color>? colors,
  }) {
    return GradientBackgroundContainer(
      child: child,
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      border: border,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors ??
            [
              const Color(0xFF6A11CB),
              const Color(0xFF2575FC),
            ],
      ),
    );
  }
}
