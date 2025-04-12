import 'package:flutter/material.dart';
import '../components/zin_button.dart';

/// A screen that showcases all UI components in the ZinApp design system.
///
/// This screen serves as both a visual testing ground and documentation
/// for the available components and their variants.
class ComponentShowcaseScreen extends StatelessWidget {
  const ComponentShowcaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZinApp Component Showcase'),
        backgroundColor: const Color(0xFF232D30),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'ZinButton'),
            const SizedBox(height: 16),
            
            // Primary button variants
            const ComponentLabel(label: 'Primary'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ZinButton.primary(
                  label: 'Primary Button',
                  onPressed: () {},
                ),
                ZinButton.primary(
                  label: 'With Icon',
                  onPressed: () {},
                  icon: Icons.star,
                ),
                ZinButton.primary(
                  label: 'Disabled',
                  onPressed: null,
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Secondary button variants
            const ComponentLabel(label: 'Secondary'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ZinButton.secondary(
                  label: 'Secondary Button',
                  onPressed: () {},
                ),
                ZinButton.secondary(
                  label: 'With Icon',
                  onPressed: () {},
                  icon: Icons.settings,
                ),
                ZinButton.secondary(
                  label: 'Disabled',
                  onPressed: null,
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Reward button variants
            const ComponentLabel(label: 'Reward'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ZinButton.reward(
                  label: 'Claim Reward',
                  onPressed: () {},
                ),
                ZinButton.reward(
                  label: 'With Icon',
                  onPressed: () {},
                  icon: Icons.emoji_events,
                ),
                ZinButton.reward(
                  label: 'Disabled',
                  onPressed: null,
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Full width button
            const ComponentLabel(label: 'Full Width'),
            const SizedBox(height: 8),
            ZinButton.primary(
              label: 'Full Width Button',
              onPressed: () {},
              fullWidth: true,
            ),
            const SizedBox(height: 8),
            ZinButton.secondary(
              label: 'Full Width Secondary',
              onPressed: () {},
              fullWidth: true,
            ),
            const SizedBox(height: 8),
            ZinButton.reward(
              label: 'Full Width Reward',
              onPressed: () {},
              fullWidth: true,
              icon: Icons.emoji_events,
            ),
            const SizedBox(height: 32),
            
            // Animation demonstration
            const SectionTitle(title: 'Animation Demonstration'),
            const SizedBox(height: 16),
            const Text(
              'Tap and hold any button to see its press animation.',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),
            
            // Additional components will be added here as they are developed
            const SectionTitle(title: 'Coming Soon'),
            const SizedBox(height: 16),
            const Text('• ZinCard\n• ZinAvatar\n• ZinTextField\n• ZinTokenBadge'),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

/// A title for a component section
class SectionTitle extends StatelessWidget {
  final String title;
  
  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF232D30),
      ),
    );
  }
}

/// A label for a component variant
class ComponentLabel extends StatelessWidget {
  final String label;
  
  const ComponentLabel({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF535F65),
      ),
    );
  }
}
