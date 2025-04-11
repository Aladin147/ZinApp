import 'package:flutter/material.dart';
import 'package:zinapp_v2/app/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/app_button.dart';
import 'package:zinapp_v2/widgets/zin_logo.dart';

/// A splash screen component for the ZinApp V2 application.
///
/// This component displays the ZinApp logo and provides a smooth
/// animation for application startup.
class ZinSplashScreen extends StatefulWidget {
  /// Duration to show the splash screen before auto-navigating
  final Duration duration;

  /// Callback when the splash screen completes its animation
  final VoidCallback? onComplete;

  /// Whether to show a "Get Started" button
  final bool showGetStartedButton;

  /// Callback when the "Get Started" button is pressed
  final VoidCallback? onGetStarted;

  const ZinSplashScreen({
    super.key,
    this.duration = const Duration(seconds: 2),
    this.onComplete,
    this.showGetStartedButton = false,
    this.onGetStarted,
  });

  @override
  State<ZinSplashScreen> createState() => _ZinSplashScreenState();
}

class _ZinSplashScreenState extends State<ZinSplashScreen> with TickerProviderStateMixin {
  // Main animation controller for initial animations
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;

  // Secondary animation controller for subtle continuous animation
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _taglineFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize main animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Create fade-in animation with a smoother curve
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // Create scale animation with a slight bounce at the end
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.85, end: 1.02),
        weight: 85,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.02, end: 1.0),
        weight: 15,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    // Create tagline fade animation that starts after logo appears
    _taglineFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
      ),
    );

    // Initialize secondary animation controller for subtle pulse effect
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Create subtle pulse animation
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    // Start main animation
    _controller.forward().then((_) {
      // Start subtle pulse animation after main animation completes
      if (mounted) {
        _pulseController.repeat(reverse: true);
      }
    });

    // Auto-navigate after duration if onComplete is provided
    if (widget.onComplete != null && !widget.showGetStartedButton) {
      Future.delayed(widget.duration, () {
        if (mounted) {
          widget.onComplete!();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baseDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated logo
            Expanded(
              child: Center(
                child: AnimatedBuilder(
                  animation: Listenable.merge([_controller, _pulseController]),
                  builder: (context, child) {
                    // Apply initial fade and scale animations
                    return FadeTransition(
                      opacity: _fadeInAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        // Apply subtle pulse animation after initial animation
                        child: _controller.isCompleted
                            ? Transform.scale(
                                scale: _pulseAnimation.value,
                                child: child,
                              )
                            : child,
                      ),
                    );
                  },
                  child: _buildLogo(),
                ),
              ),
            ),

            // Get Started button (if enabled)
            if (widget.showGetStartedButton)
              Padding(
                padding: const EdgeInsets.only(bottom: 48.0),
                child: FadeTransition(
                  opacity: _fadeInAnimation,
                  child: ZinButton(
                    label: 'Get Started',
                    onPressed: widget.onGetStarted,
                    variant: ZinButtonVariant.primary,
                    size: ZinButtonSize.large,
                    isFullWidth: false,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Use the ZinLogo component with large size and animation
        const ZinLogo(
          variant: ZinLogoVariant.full,
          colorScheme: ZinLogoColorScheme.primaryOnDark,
          size: 120,
          animated: true,
        ),
        const SizedBox(height: 24),
        // Animate tagline separately with a fade-in effect
        FadeTransition(
          opacity: _taglineFadeAnimation,
          child: Text(
            'Style Your Way',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }
}
