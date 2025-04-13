import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/constants/app_animations.dart';
import 'package:zinapp_v2/widgets/zin_background.dart';

/// Premium card variants
enum PremiumCardVariant {
  /// Standard dark card for interactive zones
  dark,

  /// Light card for content zones
  light,

  /// Accent card with cool blue theme
  cool,

  /// Accent card with coral theme
  coral,

  /// Accent card with jade theme
  jade,

  /// Featured card with brand emphasis
  featured,
}

/// A premium card component with sophisticated animations and visual effects.
///
/// This component creates a high-end, polished card with subtle animations,
/// proper elevation, and brand-reinforcing visual elements.
class PremiumCard extends StatefulWidget {
  /// The child widget to display inside the card
  final Widget child;

  /// The card variant
  final PremiumCardVariant variant;

  /// Whether to show a subtle background pattern
  final bool showPattern;

  /// The border radius of the card
  final BorderRadius? borderRadius;

  /// The padding inside the card
  final EdgeInsetsGeometry? padding;

  /// The margin around the card
  final EdgeInsetsGeometry? margin;

  /// Callback when the card is tapped
  final VoidCallback? onTap;

  /// Whether to animate the card on appearance
  final bool animateEntrance;

  /// Optional header widget
  final Widget? header;

  /// Optional footer widget
  final Widget? footer;

  /// Whether to show a divider below the header
  final bool showHeaderDivider;

  /// Whether to show a divider above the footer
  final bool showFooterDivider;

  const PremiumCard({
    super.key,
    required this.child,
    this.variant = PremiumCardVariant.dark,
    this.showPattern = false,
    this.borderRadius,
    this.padding,
    this.margin,
    this.onTap,
    this.animateEntrance = true,
    this.header,
    this.footer,
    this.showHeaderDivider = true,
    this.showFooterDivider = true,
  });

  @override
  State<PremiumCard> createState() => _PremiumCardState();
}

class _PremiumCardState extends State<PremiumCard> with SingleTickerProviderStateMixin {
  // Animation controllers
  late AnimationController _animationController;

  // Animations
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  // We're using AnimatedOpacity instead of an animation controller for the entrance effect

  // State tracking
  bool _isHovered = false;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: AppAnimations.cardHoverDuration,
    );

    // Scale animation
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppAnimations.cardHoverCurve,
      ),
    );

    // Elevation animation
    _elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 4.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppAnimations.cardHoverCurve,
      ),
    );

    // Note: We're using AnimatedOpacity for entrance animation instead of an animation controller

    // Start entrance animation if enabled
    if (widget.animateEntrance) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          setState(() {
            _isVisible = true;
          });
        }
      });
    } else {
      _isVisible = true;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Handle mouse enter event
  void _handleMouseEnter(PointerEnterEvent event) {
    if (widget.onTap != null) {
      setState(() {
        _isHovered = true;
      });
      _animationController.forward();
    }
  }

  // Handle mouse exit event
  void _handleMouseExit(PointerExitEvent event) {
    setState(() {
      _isHovered = false;
    });
    _animationController.reverse();
  }

  // Get card colors based on variant
  CardColors _getCardColors() {
    switch (widget.variant) {
      case PremiumCardVariant.dark:
        return CardColors(
          background: AppColors.baseDark,
          foreground: AppColors.textPrimary,
          secondary: AppColors.textSecondary,
          accent: AppColors.primaryHighlight,
          divider: Color.fromRGBO(
            AppColors.textDisabled.r.toInt(),
            AppColors.textDisabled.g.toInt(),
            AppColors.textDisabled.b.toInt(),
            0.3,
          ),
        );
      case PremiumCardVariant.light:
        return CardColors(
          background: AppColors.canvasLight,
          foreground: AppColors.textInverted,
          secondary: AppColors.textInvertedSecondary,
          accent: AppColors.primaryHighlightDarker,
          divider: Color.fromRGBO(
            AppColors.textInvertedSecondary.r.toInt(),
            AppColors.textInvertedSecondary.g.toInt(),
            AppColors.textInvertedSecondary.b.toInt(),
            0.2,
          ),
        );
      case PremiumCardVariant.cool:
        return CardColors(
          background: const Color.fromRGBO(140, 186, 205, 0.15),
          foreground: AppColors.textInverted,
          secondary: AppColors.textInvertedSecondary,
          accent: AppColors.coolBlueDark,
          divider: Color.fromRGBO(
            AppColors.coolBlueDark.r.toInt(),
            AppColors.coolBlueDark.g.toInt(),
            AppColors.coolBlueDark.b.toInt(),
            0.3,
          ),
        );
      case PremiumCardVariant.coral:
        return CardColors(
          background: const Color.fromRGBO(244, 128, 93, 0.15),
          foreground: AppColors.textInverted,
          secondary: AppColors.textInvertedSecondary,
          accent: AppColors.coralDark,
          divider: Color.fromRGBO(
            AppColors.coralDark.r.toInt(),
            AppColors.coralDark.g.toInt(),
            AppColors.coralDark.b.toInt(),
            0.3,
          ),
        );
      case PremiumCardVariant.jade:
        return CardColors(
          background: const Color.fromRGBO(195, 255, 194, 0.15),
          foreground: AppColors.textInverted,
          secondary: AppColors.textInvertedSecondary,
          accent: AppColors.jadeDark,
          divider: Color.fromRGBO(
            AppColors.jadeDark.r.toInt(),
            AppColors.jadeDark.g.toInt(),
            AppColors.jadeDark.b.toInt(),
            0.3,
          ),
        );
      case PremiumCardVariant.featured:
        return CardColors(
          background: AppColors.baseDark,
          foreground: AppColors.textPrimary,
          secondary: AppColors.textSecondary,
          accent: AppColors.primaryHighlight,
          divider: Color.fromRGBO(
            AppColors.primaryHighlight.r.toInt(),
            AppColors.primaryHighlight.g.toInt(),
            AppColors.primaryHighlight.b.toInt(),
            0.3,
          ),
        );
    }
  }

  // Get background pattern variant based on card variant
  ZinBackgroundVariant _getPatternVariant() {
    switch (widget.variant) {
      case PremiumCardVariant.dark:
      case PremiumCardVariant.light:
        return ZinBackgroundVariant.subtle;
      case PremiumCardVariant.cool:
      case PremiumCardVariant.coral:
      case PremiumCardVariant.jade:
        return ZinBackgroundVariant.minimal;
      case PremiumCardVariant.featured:
        return ZinBackgroundVariant.featured;
    }
  }

  // Build divider
  Widget _buildDivider(Color dividerColor) {
    return Divider(
      height: 1,
      thickness: 1,
      color: dividerColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardColors = _getCardColors();
    final effectiveBorderRadius = widget.borderRadius ?? BorderRadius.circular(16);
    final effectivePadding = widget.padding ?? const EdgeInsets.all(16);

    // Build card content
    Widget cardContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.header != null) widget.header!,
        if (widget.header != null && widget.showHeaderDivider) _buildDivider(cardColors.divider),
        Padding(
          padding: effectivePadding,
          child: widget.child,
        ),
        if (widget.footer != null && widget.showFooterDivider) _buildDivider(cardColors.divider),
        if (widget.footer != null) widget.footer!,
      ],
    );

    // Add background pattern if enabled
    if (widget.showPattern) {
      cardContent = ClipRRect(
        borderRadius: effectiveBorderRadius,
        child: ZinBackground(
          variant: _getPatternVariant(),
          animated: true,
          patternOpacity: 0.05,
          backgroundColor: cardColors.background,
          child: cardContent,
        ),
      );
    }

    // Create the animated card
    Widget animatedCard = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        // Calculate the current elevation with animation
        final currentElevation = 1.0 + (_isHovered ? _elevationAnimation.value : 0);

        // Create the card with current styling
        return Transform.scale(
          scale: _isHovered ? _scaleAnimation.value : 1.0,
          child: Card(
            margin: widget.margin ?? EdgeInsets.zero,
            color: cardColors.background,
            elevation: currentElevation,
            shape: RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
            clipBehavior: Clip.antiAlias,
            child: child,
          ),
        );
      },
      child: cardContent,
    );

    // Add entrance animation if enabled
    if (widget.animateEntrance) {
      animatedCard = AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: AppAnimations.revealDuration,
        curve: AppAnimations.revealCurve,
        child: animatedCard,
      );
    }

    // Add interactive handlers if onTap is provided
    if (widget.onTap != null) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: _handleMouseEnter,
        onExit: _handleMouseExit,
        child: GestureDetector(
          onTap: widget.onTap,
          child: animatedCard,
        ),
      );
    }

    return animatedCard;
  }
}

/// Helper class for card colors
class CardColors {
  final Color background;
  final Color foreground;
  final Color secondary;
  final Color accent;
  final Color divider;

  CardColors({
    required this.background,
    required this.foreground,
    required this.secondary,
    required this.accent,
    required this.divider,
  });
}
