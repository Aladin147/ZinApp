import 'package:flutter/material.dart';
import 'package:zinapp_v2/app/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/app_button.dart';
import 'package:zinapp_v2/widgets/zin_avatar.dart';
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
        ZinButton(
          label: 'Primary Button',
          onPressed: () {},
        ),
        ZinButton.secondary(
          label: 'Secondary Button',
          onPressed: () {},
        ),
        ZinButton.text(
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
        ZinButton(
          label: 'Small Button',
          size: ZinButtonSize.small,
          onPressed: () {},
        ),
        ZinButton(
          label: 'Medium Button',
          size: ZinButtonSize.medium,
          onPressed: () {},
        ),
        ZinButton(
          label: 'Large Button',
          size: ZinButtonSize.large,
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
            ZinButton(
              label: _isLoading ? 'Loading...' : 'Toggle Loading',
              isLoading: _isLoading,
              onPressed: _toggleLoading,
            ),
            ZinButton(
              label: 'Disabled Button',
              onPressed: null,
            ),
            ZinButton(
              label: 'Full Width Button',
              isFullWidth: true,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),
        ZinButton(
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
        ZinButton(
          label: 'Leading Icon',
          icon: Icons.add,
          iconPosition: IconPosition.leading,
          onPressed: () {},
        ),
        ZinButton(
          label: 'Trailing Icon',
          icon: Icons.arrow_forward,
          iconPosition: IconPosition.trailing,
          onPressed: () {},
        ),
        ZinButton.secondary(
          label: 'Share',
          icon: Icons.share,
          onPressed: () {},
        ),
        ZinButton.text(
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
                  ZinButton.text(
                    label: 'Cancel',
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  ZinButton(
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
}
