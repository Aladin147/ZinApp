import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zinapp_v2/app/theme/color_scheme.dart';

/// Logo variants for different contexts
enum ZinLogoVariant {
  /// Full logo with text and icon
  full,

  /// Icon only
  icon,

  /// Text only
  text
}

/// Color schemes for the logo
enum ZinLogoColorScheme {
  /// Primary color on dark background (default)
  primaryOnDark,

  /// Dark color on light background
  darkOnLight,

  /// White on dark background
  whiteOnDark,

  /// Outline version
  outline
}

/// A component that renders the ZinApp logo in various formats.
///
/// This component provides consistent rendering of the ZinApp logo
/// across the application, with support for different variants and color schemes.
class ZinLogo extends StatelessWidget {
  /// The variant of the logo to display
  final ZinLogoVariant variant;

  /// The color scheme to use for the logo
  final ZinLogoColorScheme colorScheme;

  /// The size of the logo (affects both icon and text)
  final double size;

  /// Whether to add a subtle animation effect
  final bool animated;

  const ZinLogo({
    super.key,
    this.variant = ZinLogoVariant.full,
    this.colorScheme = ZinLogoColorScheme.primaryOnDark,
    this.size = 48.0,
    this.animated = false,
  });

  @override
  Widget build(BuildContext context) {
    // Determine colors based on color scheme
    Color iconColor;
    Color textColor;
    Color? outlineColor;

    switch (colorScheme) {
      case ZinLogoColorScheme.primaryOnDark:
        iconColor = AppColors.primaryHighlight;
        textColor = AppColors.primaryHighlight;
        outlineColor = null;
        break;
      case ZinLogoColorScheme.darkOnLight:
        iconColor = AppColors.baseDark;
        textColor = AppColors.baseDark;
        outlineColor = null;
        break;
      case ZinLogoColorScheme.whiteOnDark:
        iconColor = Colors.white;
        textColor = Colors.white;
        outlineColor = null;
        break;
      case ZinLogoColorScheme.outline:
        iconColor = Colors.transparent;
        textColor = AppColors.primaryHighlight;
        outlineColor = AppColors.primaryHighlight;
        break;
    }

    // Build the appropriate logo variant
    Widget logo;

    switch (variant) {
      case ZinLogoVariant.full:
        // For full logo, use the appropriate PNG based on color scheme
        Widget logoWidget;

        switch (colorScheme) {
          case ZinLogoColorScheme.primaryOnDark:
            // Primary color logo (neon green on dark)
            logoWidget = _buildShadowedLogo(
              SvgPicture.asset(
                'assets/logos/svg/ZinApp_zinapp_logo_full.svg',
                height: size,
                fit: BoxFit.contain,
              ),
              size: size,
            );
            break;

          case ZinLogoColorScheme.whiteOnDark:
            // White on dark logo
            logoWidget = Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.baseDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset(
                'assets/logos/svg/ZinApp_zinapp_logo_full.svg',
                height: size * 0.9,
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            );
            break;

          case ZinLogoColorScheme.darkOnLight:
            // Dark on light logo
            logoWidget = Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset(
                'assets/logos/svg/ZinApp_zinapp_logo_full.svg',
                height: size * 0.9,
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(AppColors.baseDark, BlendMode.srcIn),
              ),
            );
            break;

          case ZinLogoColorScheme.outline:
            // Outline logo
            logoWidget = Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryHighlight, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                'assets/logos/svg/ZinApp_zinapp_logo_full.svg',
                height: size * 0.8,
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(AppColors.primaryHighlight, BlendMode.srcIn),
              ),
            );
            break;
        }

        logo = SizedBox(
          width: size * 2.5,
          height: size,
          child: logoWidget,
        );
        break;
      case ZinLogoVariant.icon:
        logo = _buildIcon(iconColor, outlineColor);
        break;
      case ZinLogoVariant.text:
        logo = _buildText(textColor);
        break;
    }

    // Apply animation if requested
    if (animated) {
      return _AnimatedLogo(child: logo);
    }

    return logo;
  }

  Widget _buildIcon(Color color, Color? outlineColor) {
    // Use the PNG icon with appropriate styling for each variant
    Widget iconWidget;

    switch (colorScheme) {
      case ZinLogoColorScheme.primaryOnDark:
        // Standard icon with primary color
        iconWidget = _buildShadowedLogo(
          SvgPicture.asset(
            'assets/logos/svg/ZinApp_symbol_coin_only.svg',
            width: size,
            height: size,
            fit: BoxFit.contain,
          ),
          size: size,
          isCircular: true,
        );
        break;

      case ZinLogoColorScheme.whiteOnDark:
        // White icon on dark background
        iconWidget = Container(
          padding: EdgeInsets.all(size * 0.1),
          decoration: BoxDecoration(
            color: AppColors.baseDark,
            borderRadius: BorderRadius.circular(size * 0.2),
          ),
          child: SvgPicture.asset(
            'assets/logos/svg/ZinApp_symbol_coin_only.svg',
            width: size * 0.8,
            height: size * 0.8,
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        );
        break;

      case ZinLogoColorScheme.darkOnLight:
        // Dark icon on light background
        iconWidget = Container(
          padding: EdgeInsets.all(size * 0.1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(size * 0.2),
          ),
          child: SvgPicture.asset(
            'assets/logos/svg/ZinApp_symbol_coin_only.svg',
            width: size * 0.8,
            height: size * 0.8,
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(AppColors.baseDark, BlendMode.srcIn),
          ),
        );
        break;

      case ZinLogoColorScheme.outline:
        // Outline icon
        iconWidget = Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(color: outlineColor!, width: 2),
            borderRadius: BorderRadius.circular(size * 0.2),
          ),
          padding: EdgeInsets.all(size * 0.1),
          child: SvgPicture.asset(
            'assets/logos/svg/ZinApp_symbol_coin_only.svg',
            width: size * 0.8,
            height: size * 0.8,
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(AppColors.primaryHighlight, BlendMode.srcIn),
          ),
        );
        break;
    }

    return SizedBox(
      width: size,
      height: size,
      child: iconWidget,
    );
  }

  /// Adds a drop shadow to the logo for a more sophisticated look
  Widget _buildShadowedLogo(Widget logo, {required double size, bool isCircular = false, double shadowOpacity = 0.45}) {
    // For SVG logos, we need a more sophisticated approach to shadows
    // We'll use a Container with a decoration that includes the logo as a foreground
    // and a custom painter for the shadow
    return SizedBox(
      width: size * 1.1,  // Add some padding for the shadow
      height: size * 1.1, // Add some padding for the shadow
      child: Stack(
        fit: StackFit.expand,
        children: [
          // First shadow layer - more diffuse
          Positioned(
            left: 3.0,
            top: 3.0,
            right: 0,
            bottom: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Opacity(
                  opacity: shadowOpacity * 0.5,
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.black,
                      BlendMode.srcIn,
                    ),
                    child: logo,
                  ),
                ),
              ),
            ),
          ),
          // Second shadow layer - sharper
          Positioned(
            left: 1.5,
            top: 1.5,
            right: 1.5,
            bottom: 1.5,
            child: Opacity(
              opacity: shadowOpacity * 0.7,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
                child: logo,
              ),
            ),
          ),
          // Original logo
          Positioned(
            left: 0,
            top: 0,
            right: 3.0,
            bottom: 3.0,
            child: logo,
          ),
        ],
      ),
    );
  }

  Widget _buildText(Color color) {
    // Use the PNG text logo with appropriate styling for each variant
    Widget textWidget;

    switch (colorScheme) {
      case ZinLogoColorScheme.primaryOnDark:
        // Primary color text
        textWidget = _buildShadowedLogo(
          SvgPicture.asset(
            'assets/logos/svg/ZinApp_zinapp_logo_full.svg',
            height: size * 0.5,
            fit: BoxFit.contain,
          ),
          size: size * 0.5,
          shadowOpacity: 0.4,
        );
        break;

      case ZinLogoColorScheme.whiteOnDark:
        // White text on dark background
        textWidget = Container(
          padding: EdgeInsets.symmetric(horizontal: size * 0.1),
          decoration: BoxDecoration(
            color: AppColors.baseDark,
            borderRadius: BorderRadius.circular(size * 0.1),
          ),
          child: SvgPicture.asset(
            'assets/logos/svg/ZinApp_zinapp_logo_full.svg',
            height: size * 0.4,
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        );
        break;

      case ZinLogoColorScheme.darkOnLight:
        // Dark text on light background
        textWidget = Container(
          padding: EdgeInsets.symmetric(horizontal: size * 0.1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(size * 0.1),
          ),
          child: SvgPicture.asset(
            'assets/logos/svg/ZinApp_zinapp_logo_full.svg',
            height: size * 0.4,
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(AppColors.baseDark, BlendMode.srcIn),
          ),
        );
        break;

      case ZinLogoColorScheme.outline:
        // Outlined text
        textWidget = Container(
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(size * 0.1),
          ),
          padding: EdgeInsets.symmetric(horizontal: size * 0.1),
          child: SvgPicture.asset(
            'assets/logos/svg/ZinApp_zinapp_logo_full.svg',
            height: size * 0.4,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn), // Can't be const because color is a parameter
          ),
        );
        break;
    }

    return SizedBox(
      height: size * 0.5,
      child: textWidget,
    );
  }
}

/// A wrapper that adds subtle animation to the logo
class _AnimatedLogo extends StatefulWidget {
  final Widget child;

  const _AnimatedLogo({required this.child});

  @override
  State<_AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<_AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.98, end: 1.02).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
