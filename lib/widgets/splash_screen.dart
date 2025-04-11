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

class _ZinSplashScreenState extends State<ZinSplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Create fade-in animation
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
      ),
    );

    // Create scale animation
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
      ),
    );

    // Start animation
    _controller.forward();

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
                  animation: _controller,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeInAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: child,
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
        Text(
          'Style Your Way',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
