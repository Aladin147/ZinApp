import 'package:flutter/material.dart';

/// Defines standard animation durations and curves for the application.
abstract class AppAnimations {
  // --- Durations ---
  static const Duration extraFast = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration extraSlow = Duration(milliseconds: 800);

  // --- ZinApp Signature Animation Durations ---

  // Screen and page transitions
  static const Duration screenTransitionDuration = medium;

  // Button animations
  static const Duration buttonPressDuration = fast;
  static const Duration buttonHoverDuration = extraFast;
  static const Duration buttonReleaseDuration = Duration(milliseconds: 200);

  // Card animations
  static const Duration cardHoverDuration = fast;
  static const Duration cardPressDuration = fast;
  static const Duration cardExpandDuration = medium;

  // Feedback animations
  static const Duration feedbackDuration = fast;
  static const Duration shimmerDuration = Duration(milliseconds: 1500);

  // Reveal animations
  static const Duration revealDuration = medium;
  static const Duration staggeredItemDelay = Duration(milliseconds: 50);

  // --- Curves ---
  static const Curve primaryCurve = Curves.easeInOut; // Default curve
  static const Curve decelerateCurve = Curves.decelerate;
  static const Curve accelerateCurve = Curves.easeIn; // Accelerate curve
  static const Curve bounceCurve = Curves.elasticOut; // For playful effects
  static const Curve sharpCurve = Curves.easeOutQuint; // For crisp, premium feel

  // --- ZinApp Signature Animation Curves ---

  // Screen transitions
  static const Curve screenTransitionCurve = Curves.fastOutSlowIn;

  // Button animations
  static const Curve buttonPressCurve = sharpCurve; // Premium feel
  static const Curve buttonReleaseCurve = Curves.easeOut;
  static const Curve buttonHoverCurve = Curves.easeOutCubic;

  // Card animations
  static const Curve cardHoverCurve = Curves.easeOutCubic;
  static const Curve cardPressCurve = sharpCurve;

  // Reveal animations
  static const Curve revealCurve = Curves.easeOutCubic;

  // --- ZinApp Signature Animation Patterns ---

  /// ZinPulse: A subtle, rhythmic pulsing effect for emphasis
  static List<TweenSequenceItem<double>> getZinPulseSequence() {
    return [
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.03), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.03, end: 1.0), weight: 1),
    ];
  }

  /// ZinRise: A smooth, confident upward motion
  static List<TweenSequenceItem<double>> getZinRiseSequence() {
    return [
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -4.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -4.0, end: 0.0), weight: 0.5),
    ];
  }

  /// ZinPress: A premium-feeling press animation
  static List<TweenSequenceItem<double>> getZinPressSequence() {
    return [
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.97), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.97, end: 1.0), weight: 0.5),
    ];
  }
}
