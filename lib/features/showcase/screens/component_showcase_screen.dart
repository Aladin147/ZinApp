import 'package:flutter/material.dart';
import 'package:zinapp_v2/app/theme/color_scheme.dart';
import 'package:zinapp_v2/app/theme/color_zones.dart';
import 'package:zinapp_v2/widgets/accessibility_aware_text.dart';
import 'package:zinapp_v2/widgets/animated_card.dart';
import 'package:zinapp_v2/widgets/app_button.dart';
import 'package:zinapp_v2/widgets/premium_card.dart';
import 'package:zinapp_v2/widgets/zin_avatar.dart';
import 'package:zinapp_v2/widgets/zin_background.dart';
import 'package:zinapp_v2/widgets/zin_badge.dart';
import 'package:zinapp_v2/widgets/zin_card.dart';
import 'package:zinapp_v2/widgets/zin_logo.dart';

/// A screen that showcases the ZinApp V2 components.
///
/// This screen is used for development and testing purposes to display
/// all the components in the design system.
class ComponentShowcaseScreen extends StatefulWidget {
  const ComponentShowcaseScreen({super.key});

  @override
  State<ComponentShowcaseScreen> createState() => _ComponentShowcaseScreenState();
}

class _ComponentShowcaseScreenState extends State<ComponentShowcaseScreen> {
  bool _isLoading = false;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baseDark,
      appBar: AppBar(
        title: const Text('Component Showcase'),
        backgroundColor: AppColors.baseDark,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Logo Variants'),
            _buildLogoShowcase(),

            const SizedBox(height: 32),
            _buildSectionTitle('Button Variants'),
            _buildButtonVariantsShowcase(),

            const SizedBox(height: 32),
            _buildSectionTitle('Button Sizes'),
            _buildButtonSizesShowcase(),

            const SizedBox(height: 32),
            _buildSectionTitle('Button States'),
            _buildButtonStatesShowcase(),

            const SizedBox(height: 32),
            _buildSectionTitle('Button with Icons'),
            _buildButtonWithIconsShowcase(),

            const SizedBox(height: 32),
            _buildSectionTitle('Card Variants'),
            _buildCardShowcase(),

            const SizedBox(height: 32),
            _buildSectionTitle('Animated Components'),
            _buildAnimatedComponentsShowcase(),

            const SizedBox(height: 32),
            _buildSectionTitle('Brand Backgrounds'),
            _buildBackgroundShowcase(),

            const SizedBox(height: 32),
            _buildSectionTitle('Premium Cards'),
            _buildPremiumCardShowcase(),

            const SizedBox(height: 32),
            _buildSectionTitle('Color Zones'),
            _buildColorZoneShowcase(),

            const SizedBox(height: 32),
            _buildSectionTitle('Accessibility Components'),
            _buildAccessibilityShowcase(),

            const SizedBox(height: 32),
            _buildSectionTitle('Avatar Variants'),
            _buildAvatarShowcase(),

            const SizedBox(height: 32),
            _buildSectionTitle('Badge Variants'),
            _buildBadgeShowcase(),

            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.textPrimary,
            ),
      ),
    );
  }

  Widget _buildLogoShowcase() {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      children: [
        _buildLogoVariant(
          'Full Logo',
          const ZinLogo(
            variant: ZinLogoVariant.full,
            size: 64,
          ),
        ),
        _buildLogoVariant(
          'Icon Only',
          const ZinLogo(
            variant: ZinLogoVariant.icon,
            size: 64,
          ),
        ),
        _buildLogoVariant(
          'Text Only',
          const ZinLogo(
            variant: ZinLogoVariant.text,
            size: 64,
          ),
        ),
        _buildLogoVariant(
          'White on Dark',
          const ZinLogo(
            variant: ZinLogoVariant.full,
            colorScheme: ZinLogoColorScheme.whiteOnDark,
            size: 64,
          ),
        ),
        _buildLogoVariant(
          'Outline',
          const ZinLogo(
            variant: ZinLogoVariant.full,
            colorScheme: ZinLogoColorScheme.outline,
            size: 64,
          ),
        ),
        _buildLogoVariant(
          'Animated',
          const ZinLogo(
            variant: ZinLogoVariant.full,
            size: 64,
            animated: true,
          ),
        ),
      ],
    );
  }

  Widget _buildLogoVariant(String label, Widget logo) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.baseDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.textDisabled.withAlpha(76)), // 30% opacity
          ),
          child: logo,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildButtonVariantsShowcase() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        AppButton( // Renamed
          label: 'Primary Button',
          onPressed: () {},
        ),
        AppButton.secondary( // Renamed
          label: 'Secondary Button',
          onPressed: () {},
        ),
        AppButton.text( // Renamed
          label: 'Text Button',
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildButtonSizesShowcase() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        AppButton( // Renamed
          label: 'Small Button',
          size: AppButtonSize.small, // Renamed enum
          onPressed: () {},
        ),
        AppButton( // Renamed
          label: 'Medium Button',
          size: AppButtonSize.medium, // Renamed enum
          onPressed: () {},
        ),
        AppButton( // Renamed
          label: 'Large Button',
          size: AppButtonSize.large, // Renamed enum
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildButtonStatesShowcase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            AppButton( // Renamed
              label: _isLoading ? 'Loading...' : 'Toggle Loading',
              isLoading: _isLoading,
              onPressed: _toggleLoading,
            ),
            AppButton( // Renamed
              label: 'Disabled Button',
              onPressed: null,
            ),
            AppButton( // Renamed
              label: 'Full Width Button',
              isFullWidth: true,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),
        AppButton( // Renamed
          label: 'Full Width Button',
          isFullWidth: true,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildButtonWithIconsShowcase() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        AppButton( // Renamed
          label: 'Leading Icon',
          icon: Icons.add,
          iconPosition: IconPosition.leading,
          onPressed: () {},
        ),
        AppButton( // Renamed
          label: 'Trailing Icon',
          icon: Icons.arrow_forward,
          iconPosition: IconPosition.trailing,
          onPressed: () {},
        ),
        AppButton.secondary( // Renamed
          label: 'Share',
          icon: Icons.share,
          onPressed: () {},
        ),
        AppButton.text( // Renamed
          label: 'Delete',
          icon: Icons.delete,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildCardShowcase() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: 300,
          child: ZinCard(
            title: 'Standard Card',
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text('This is a standard card with a title.'),
            ),
            onTap: () {},
          ),
        ),
        SizedBox(
          width: 300,
          child: ZinCard.elevated(
            title: 'Elevated Card',
            subtitle: 'With subtitle',
            trailing: IconButton(
              icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
              onPressed: () {},
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text('This card has higher elevation and a subtitle.'),
            ),
          ),
        ),
        SizedBox(
          width: 300,
          child: ZinCard.outlined(
            title: 'Outlined Card',
            showHeaderDivider: true,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text('This card has an outline instead of elevation.'),
            ),
            footer: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton.text( // Renamed
                    label: 'Cancel',
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  AppButton( // Renamed
                    label: 'Save',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            showFooterDivider: true,
          ),
        ),
        SizedBox(
          width: 300,
          child: ZinCard.light(
            title: 'Light Card',
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text('This card has a light background.'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarShowcase() {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      children: [
        _buildAvatarVariant(
          'Small',
          const ZinAvatar(
            initials: 'JS',
            size: ZinAvatarSize.small,
          ),
        ),
        _buildAvatarVariant(
          'Medium',
          const ZinAvatar(
            initials: 'AK',
            size: ZinAvatarSize.medium,
          ),
        ),
        _buildAvatarVariant(
          'Large',
          const ZinAvatar(
            initials: 'RW',
            size: ZinAvatarSize.large,
          ),
        ),
        _buildAvatarVariant(
          'Extra Large',
          const ZinAvatar(
            initials: 'ZA',
            size: ZinAvatarSize.extraLarge,
          ),
        ),
        _buildAvatarVariant(
          'With Image',
          const ZinAvatar(
            imageUrl: 'https://i.pravatar.cc/300',
            size: ZinAvatarSize.large,
          ),
        ),
        _buildAvatarVariant(
          'Online Status',
          const ZinAvatar(
            initials: 'ON',
            size: ZinAvatarSize.large,
            status: ZinAvatarStatus.online,
          ),
        ),
        _buildAvatarVariant(
          'Busy Status',
          const ZinAvatar(
            initials: 'BS',
            size: ZinAvatarSize.large,
            status: ZinAvatarStatus.busy,
          ),
        ),
        _buildAvatarVariant(
          'Away Status',
          const ZinAvatar(
            initials: 'AW',
            size: ZinAvatarSize.large,
            status: ZinAvatarStatus.away,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarVariant(String label, Widget avatar) {
    return Column(
      children: [
        avatar,
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildBadgeShowcase() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildBadgeVariant(
          'Primary',
          const ZinBadge(
            label: 'Primary',
            variant: ZinBadgeVariant.primary,
          ),
        ),
        _buildBadgeVariant(
          'Secondary',
          const ZinBadge(
            label: 'Secondary',
            variant: ZinBadgeVariant.secondary,
          ),
        ),
        _buildBadgeVariant(
          'Success',
          const ZinBadge(
            label: 'Success',
            variant: ZinBadgeVariant.success,
          ),
        ),
        _buildBadgeVariant(
          'Warning',
          const ZinBadge(
            label: 'Warning',
            variant: ZinBadgeVariant.warning,
          ),
        ),
        _buildBadgeVariant(
          'Error',
          const ZinBadge(
            label: 'Error',
            variant: ZinBadgeVariant.error,
          ),
        ),
        _buildBadgeVariant(
          'Neutral',
          const ZinBadge(
            label: 'Neutral',
            variant: ZinBadgeVariant.neutral,
          ),
        ),
        _buildBadgeVariant(
          'With Icon',
          const ZinBadge(
            label: 'New',
            icon: Icons.star,
            variant: ZinBadgeVariant.primary,
          ),
        ),
        _buildBadgeVariant(
          'Count',
          const ZinBadge(
            count: 5,
            variant: ZinBadgeVariant.primary,
          ),
        ),
        _buildBadgeVariant(
          'Outlined',
          const ZinBadge(
            label: 'Outlined',
            variant: ZinBadgeVariant.primary,
            filled: false,
          ),
        ),
        _buildBadgeVariant(
          'Small',
          const ZinBadge(
            label: 'Small',
            variant: ZinBadgeVariant.primary,
            size: ZinBadgeSize.small,
          ),
        ),
        _buildBadgeVariant(
          'Large',
          const ZinBadge(
            label: 'Large',
            variant: ZinBadgeVariant.primary,
            size: ZinBadgeSize.large,
          ),
        ),
      ],
    );
  }

  Widget _buildBadgeVariant(String label, Widget badge) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.baseDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.textDisabled.withAlpha(76)), // 30% opacity
          ),
          child: badge,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  /// Builds a showcase of animated components
  Widget _buildAnimatedComponentsShowcase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Hover over or tap these components to see animations'),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            // Animated Card
            AnimatedCard(
              elevation: 1.0,
              color: AppColors.baseDark,
              borderRadius: BorderRadius.circular(16),
              padding: const EdgeInsets.all(16),
              onTap: () {},
              child: SizedBox(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Animated Card',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.textPrimary,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Hover over me to see scale and elevation animations',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    const SizedBox(height: 16),
                    AppButton( // Renamed
                      label: 'Interactive Button',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),

            // Light Animated Card
            AnimatedCard(
              elevation: 1.0,
              color: const Color(0xFFF8F3ED), // Light background color
              borderRadius: BorderRadius.circular(16),
              padding: const EdgeInsets.all(16),
              onTap: () {},
              child: SizedBox(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Light Animated Card',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.textInverted,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Hover over me to see scale and elevation animations',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textInvertedSecondary,
                          ),
                    ),
                    const SizedBox(height: 16),
                    AppButton.secondary( // Renamed
                      label: 'Interactive Button',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Builds a showcase of brand-reinforcing backgrounds
  Widget _buildBackgroundShowcase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Brand-reinforcing background patterns'),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            // Subtle Background
            _buildBackgroundVariant(
              'Subtle Pattern',
              ZinBackgroundVariant.subtle,
            ),

            // Featured Background
            _buildBackgroundVariant(
              'Featured Pattern',
              ZinBackgroundVariant.featured,
            ),

            // Minimal Background
            _buildBackgroundVariant(
              'Minimal Pattern',
              ZinBackgroundVariant.minimal,
            ),

            // Special Background
            _buildBackgroundVariant(
              'Special Pattern',
              ZinBackgroundVariant.special,
            ),
          ],
        ),
      ],
    );
  }

  /// Builds a single background variant showcase
  Widget _buildBackgroundVariant(String label, ZinBackgroundVariant variant) {
    return Column(
      children: [
        SizedBox(
          width: 250,
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ZinBackground(
              variant: variant,
              animated: true,
              patternOpacity: 0.15, // Higher opacity for demo purposes
              child: Center(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  /// Builds a showcase of premium cards
  Widget _buildPremiumCardShowcase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Premium cards with enhanced visual effects'),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 24,
          children: [
            // Dark Premium Card
            _buildPremiumCardVariant(
              'Dark Card',
              PremiumCardVariant.dark,
              false,
            ),

            // Light Premium Card
            _buildPremiumCardVariant(
              'Light Card',
              PremiumCardVariant.light,
              false,
            ),

            // Cool Premium Card
            _buildPremiumCardVariant(
              'Cool Accent Card',
              PremiumCardVariant.cool,
              false,
            ),

            // Coral Premium Card
            _buildPremiumCardVariant(
              'Coral Accent Card',
              PremiumCardVariant.coral,
              false,
            ),

            // Jade Premium Card
            _buildPremiumCardVariant(
              'Jade Accent Card',
              PremiumCardVariant.jade,
              false,
            ),

            // Featured Premium Card with Pattern
            _buildPremiumCardVariant(
              'Featured Card with Pattern',
              PremiumCardVariant.featured,
              true,
            ),
          ],
        ),
      ],
    );
  }

  /// Builds a single premium card variant
  Widget _buildPremiumCardVariant(String label, PremiumCardVariant variant, bool showPattern) {
    return Column(
      children: [
        SizedBox(
          width: 280,
          child: PremiumCard(
            variant: variant,
            showPattern: showPattern,
            onTap: () {},
            header: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Premium card with enhanced animations and visual effects.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                AppButton( // Renamed
                  label: 'Interactive Button',
                  onPressed: () {},
                ),
              ],
            ),
            footer: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Hover to see effects',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  /// Builds a showcase of color zones
  Widget _buildColorZoneShowcase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Color zones for maintaining brand identity with accessibility'),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 24,
          children: [
            // Interactive Zone
            _buildColorZoneCard(
              'Interactive Zone',
              ColorZones.interactiveZone.background,
              ColorZones.interactiveZone.textPrimary,
              ColorZones.interactiveZone.textSecondary,
              ColorZones.interactiveZone.action,
              'Used for navigation, actions, and interactive elements',
              'Dark background with neon accents',
            ),

            // Content Zone
            _buildColorZoneCard(
              'Content Zone',
              ColorZones.contentZone.background,
              ColorZones.contentZone.textPrimary,
              ColorZones.contentZone.textSecondary,
              ColorZones.contentZone.action,
              'Used for reading-focused screens and content',
              'Cream background with dark text',
            ),

            // Accent Zone - Cool
            _buildColorZoneCard(
              'Accent Zone - Cool',
              ColorZones.accentZone.coolBackground,
              ColorZones.accentZone.textOnCool,
              ColorZones.accentZone.textOnCool.withOpacity(0.7),
              ColorZones.accentZone.actionOnCool,
              'Used for featured content and categories',
              'Accent color backgrounds for emphasis',
            ),

            // Brand Zone
            _buildColorZoneCard(
              'Brand Zone',
              ColorZones.brandZone.background,
              ColorZones.brandZone.textOnDark,
              ColorZones.brandZone.textOnDark.withOpacity(0.7),
              ColorZones.brandZone.brandPrimary,
              'Used for splash screen and onboarding',
              'Prominent brand presence',
            ),
          ],
        ),
      ],
    );
  }

  /// Builds a color zone card
  Widget _buildColorZoneCard(
    String title,
    Color backgroundColor,
    Color textColor,
    Color secondaryTextColor,
    Color actionColor,
    String description,
    String subtitle,
  ) {
    return Column(
      children: [
        SizedBox(
          width: 280,
          child: Card(
            color: backgroundColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: textColor,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: secondaryTextColor,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: textColor,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: actionColor,
                      foregroundColor: backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Action Button'),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  /// Builds a showcase of accessibility components
  Widget _buildAccessibilityShowcase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Components that automatically ensure proper contrast'),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 24,
          children: [
            // Accessibility-aware text on dark background
            _buildAccessibilityCard(
              'Text on Dark Background',
              AppColors.baseDark,
              false,
            ),

            // Accessibility-aware text on cream background
            _buildAccessibilityCard(
              'Text on Cream Background',
              AppColors.canvasLight,
              false,
            ),

            // Accessibility-aware text on neon background
            _buildAccessibilityCard(
              'Text on Neon Background',
              AppColors.primaryHighlight,
              false,
            ),

            // Accessibility-aware text on cool blue background
            _buildAccessibilityCard(
              'Text on Cool Blue Background',
              AppColors.coolBlue,
              false,
            ),
          ],
        ),
      ],
    );
  }

  /// Builds a card showcasing accessibility-aware components
  Widget _buildAccessibilityCard(String title, Color backgroundColor, bool showWarning) {
    return Column(
      children: [
        SizedBox(
          width: 280,
          child: AccessibilityAwareCard(
            backgroundColor: backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AccessibilityAwareText(
                  text: title,
                  backgroundColor: backgroundColor,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                AccessibilityAwareText(
                  text: 'This text automatically adjusts its color to ensure proper contrast with the background.',
                  backgroundColor: backgroundColor,
                  isSecondaryText: true,
                ),
                const SizedBox(height: 16),
                AccessibilityAwareButton(
                  label: 'Primary Button',
                  backgroundColor: backgroundColor,
                  onPressed: () {},
                ),
                const SizedBox(height: 8),
                AccessibilityAwareButton(
                  label: 'Secondary Button',
                  backgroundColor: backgroundColor,
                  onPressed: () {},
                  variant: ButtonVariant.secondary,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
// Note: AccessibilityAwareCard and AccessibilityAwareButton are assumed to exist
// and handle contrast logic internally. ButtonVariant might need adjustment if
// the actual enum name differs.
