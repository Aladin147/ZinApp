import 'dart:ui';
import 'package:flutter/material.dart';

/// A reusable frosted glass container that creates a modern glassmorphism effect.
///
/// This widget applies a blur effect to create a frosted glass appearance,
/// which can be customized with different blur amounts, colors, and borders.
class FrostedGlassContainer extends StatelessWidget {
  /// The child widget to display inside the frosted glass container.
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
  final BorderRadius borderRadius;

  /// The blur amount to apply to the background. Higher values create a more blurred effect.
  final double blurAmount;

  /// The background color to apply with opacity. This adds a tint to the frosted effect.
  final Color backgroundColor;

  /// The opacity of the background color.
  final double backgroundOpacity;

  /// The border to apply around the container.
  final Border? border;

  /// The box shadow to apply to the container.
  final List<BoxShadow>? boxShadow;

  const FrostedGlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.blurAmount = 10,
    this.backgroundColor = Colors.white,
    this.backgroundOpacity = 0.2,
    this.border,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurAmount,
            sigmaY: blurAmount,
          ),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor.withOpacity(backgroundOpacity),
              borderRadius: borderRadius,
              border: border,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// A lighter variant of the frosted glass container with preset properties
/// for a more subtle effect.
class LightFrostedGlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BorderRadius borderRadius;

  const LightFrostedGlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });

  @override
  Widget build(BuildContext context) {
    return FrostedGlassContainer(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      blurAmount: 5,
      backgroundColor: Colors.white,
      backgroundOpacity: 0.15,
      border: Border.all(
        color: Colors.white.withOpacity(0.2),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          spreadRadius: 0,
          offset: const Offset(0, 4),
        ),
      ],
      child: child,
    );
  }
}

/// A darker variant of the frosted glass container with preset properties
/// for a more pronounced effect.
class DarkFrostedGlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BorderRadius borderRadius;

  const DarkFrostedGlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });

  @override
  Widget build(BuildContext context) {
    return FrostedGlassContainer(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      blurAmount: 10,
      backgroundColor: Colors.black,
      backgroundOpacity: 0.3,
      border: Border.all(
        color: Colors.white.withOpacity(0.1),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 15,
          spreadRadius: 0,
          offset: const Offset(0, 8),
        ),
      ],
      child: child,
    );
  }
}
