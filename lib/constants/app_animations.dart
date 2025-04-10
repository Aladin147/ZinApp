import 'package:flutter/material.dart';

/// Defines standard animation durations and curves for the application.
abstract class AppAnimations {
  // --- Durations ---
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);

  // Specific durations
  static const Duration screenTransitionDuration = medium;
  static const Duration buttonPressDuration = fast;
  static const Duration cardHoverDuration = fast;
  static const Duration shimmerDuration = Duration(milliseconds: 1500);

  // --- Curves ---
  static const Curve primaryCurve = Curves.easeInOut; // Default curve
  static const Curve decelerateCurve = Curves.decelerate;
  static const Curve accelerateCurve = Curves.accelerate;
  static const Curve bounceCurve = Curves.bounceOut; // For playful effects

  // Specific curves
  static const Curve screenTransitionCurve = primaryCurve;
  static const Curve buttonPressCurve = Curves.easeOut; // Quick release
}
