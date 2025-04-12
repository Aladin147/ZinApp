import 'package:flutter/material.dart';

/// A stylized action button with organic styling
class OrganicActionButton extends StatelessWidget {
  /// The icon to display
  final IconData icon;
  
  /// The label text
  final String label;
  
  /// The primary color for the button
  final Color color;
  
  /// Callback when button is tapped
  final VoidCallback onTap;
  
  /// Size of the button (affects icon container size)
  final double size;
  
  /// Icon size
  final double iconSize;
  
  /// Whether to use a pill shape instead of circle
  final bool usePillShape;
  
  /// Whether to use enhanced visual effects
  final bool enhancedEffects;
  
  /// Text style for the label
  final TextStyle? labelStyle;

  /// Creates an organic action button with flowing styling
  const OrganicActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.size = 60,
    this.iconSize = 26,
    this.usePillShape = true,
    this.enhancedEffects = true,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Default text style with shadows
    final defaultLabelStyle = theme.textTheme.bodySmall?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
      shadows: enhancedEffects ? [
        Shadow(
          color: Colors.black.withAlpha(100),
          blurRadius: 3,
          offset: const Offset(0, 1),
        ),
      ] : null,
    );
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(usePillShape ? size / 2 : 16),
      splashColor: color.withAlpha(40),
      highlightColor: color.withAlpha(20),
      child: Container(
        width: usePillShape ? size * 1.8 : size * 1.3,
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon container
            Container(
              padding: EdgeInsets.all(usePillShape ? 12 : 10),
              decoration: BoxDecoration(
                // Use either pill shape or circle
                borderRadius: usePillShape 
                  ? BorderRadius.circular(size / 2)
                  : null,
                shape: usePillShape ? BoxShape.rectangle : BoxShape.circle,
                
                // Use either gradient or solid color with opacity
                gradient: enhancedEffects ? RadialGradient(
                  colors: [
                    color.withAlpha(80),
                    color.withAlpha(30),
                  ],
                  stops: const [0.4, 1.0],
                ) : null,
                color: enhancedEffects ? null : color.withAlpha(51),
                
                // Add shadow effect
                boxShadow: enhancedEffects ? [
                  BoxShadow(
                    color: color.withAlpha(100),
                    blurRadius: 12,
                    spreadRadius: -2,
                  ),
                ] : [
                  BoxShadow(
                    color: color.withAlpha(77),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
                
                // Add border for enhanced effect
                border: enhancedEffects ? Border.all(
                  color: color.withAlpha(120),
                  width: 1.5,
                ) : null,
              ),
              child: Icon(
                icon,
                color: color,
                size: iconSize,
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Label text
            Text(
              label,
              style: labelStyle ?? defaultLabelStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// A row of organic action buttons with even spacing
class OrganicActionButtonRow extends StatelessWidget {
  /// The list of button data
  final List<OrganicActionButtonData> buttons;
  
  /// Whether to use pill shapes instead of circles
  final bool usePillShape;
  
  /// Whether to use enhanced visual effects
  final bool enhancedEffects;
  
  /// Size of the buttons
  final double buttonSize;
  
  /// Icon size
  final double iconSize;
  
  /// Text style for the labels
  final TextStyle? labelStyle;

  /// Creates a row of evenly spaced organic action buttons
  const OrganicActionButtonRow({
    super.key,
    required this.buttons,
    this.usePillShape = true,
    this.enhancedEffects = true,
    this.buttonSize = 60,
    this.iconSize = 26,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((buttonData) => OrganicActionButton(
        icon: buttonData.icon,
        label: buttonData.label,
        color: buttonData.color,
        onTap: buttonData.onTap,
        usePillShape: usePillShape,
        enhancedEffects: enhancedEffects,
        size: buttonSize,
        iconSize: iconSize,
        labelStyle: labelStyle,
      )).toList(),
    );
  }
}

/// Data for an organic action button
class OrganicActionButtonData {
  /// The icon to display
  final IconData icon;
  
  /// The label text
  final String label;
  
  /// The primary color for the button
  final Color color;
  
  /// Callback when button is tapped
  final VoidCallback onTap;

  /// Creates data for an organic action button
  const OrganicActionButtonData({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}
