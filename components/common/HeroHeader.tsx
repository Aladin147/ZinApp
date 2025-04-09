import React from 'react';
import { View, StyleSheet, ViewProps, ViewStyle, Image, ImageSourcePropType } from 'react-native';
import { colors, spacing, typography } from '../../constants';
import Typography from './Typography';

interface HeroHeaderProps extends ViewProps {
  title: string;
  icon?: ImageSourcePropType;
  style?: ViewStyle;
  iconSize?: number;
  bottomCornersOnly?: boolean;
}

/**
 * HeroHeader component following ZinApp design system
 *
 * Based on the specifications in the audit requirements:
 * - Coral background (#F4805D)
 * - Centered icon (24-36px)
 * - ScreenTitle below (24px Bold)
 * - Sections: 24px bottom corners (optional)
 */
const HeroHeader: React.FC<HeroHeaderProps> = ({
  title,
  icon,
  style,
  iconSize = 36,
  bottomCornersOnly = false,
  ...props
}) => {
  return (
    <View
      style={[
        styles.container,
        bottomCornersOnly ? styles.bottomCornersOnly : styles.allCorners,
        style,
      ]}
      {...props}
    >
      {icon && (
        <View style={styles.iconContainer}>
          <Image
            source={icon}
            style={[styles.icon, { width: iconSize, height: iconSize }]}
            resizeMode="contain"
          />
        </View>
      )}
      <Typography variant="screenTitle" color="white" align="center" style={styles.title}>
        {title}
      </Typography>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    backgroundColor: colors.primary, // Coral background (#F4805D)
    paddingVertical: spacing.lg,
    paddingHorizontal: spacing.md,
    alignItems: 'center',
    justifyContent: 'center',
    width: '100%',
  },
  allCorners: {
    borderRadius: 0, // No border radius for immersive design
  },
  bottomCornersOnly: {
    borderBottomLeftRadius: spacing.section.bottomCornerRadius, // 24px bottom corners (audit requirement)
    borderBottomRightRadius: spacing.section.bottomCornerRadius, // 24px bottom corners (audit requirement)
  },
  iconContainer: {
    marginBottom: spacing.sm,
  },
  icon: {
    tintColor: 'white',
    width: 48, // Larger icon for more impact
    height: 48, // Larger icon for more impact
    resizeMode: 'contain',
  },
  title: {
    marginTop: spacing.xs,
    textShadowColor: 'rgba(0, 0, 0, 0.2)',
    textShadowOffset: { width: 0, height: 1 },
    textShadowRadius: 2,
  },
});

export default HeroHeader;
