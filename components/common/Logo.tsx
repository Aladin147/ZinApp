import React from 'react';
import { View, StyleSheet, ViewStyle } from 'react-native';
import { SvgProps } from 'react-native-svg';

// Import SVG files
import NormalLogo from '../../LOGO_ZineApp.svg';
import InvertedLogo from '../../LOGO-Inverted_ZinApp.svg';
import StandaloneLogo from '../../LOGO-StandAlone_ZinApp.svg';

interface LogoProps {
  /**
   * Logo variant
   */
  variant?: 'normal' | 'inverted' | 'standalone';
  
  /**
   * Width of the logo
   */
  width?: number;
  
  /**
   * Height of the logo (optional, will maintain aspect ratio if not provided)
   */
  height?: number;
  
  /**
   * Additional style for the container
   */
  style?: ViewStyle;
}

/**
 * Logo component for displaying the ZinApp logo
 * 
 * Supports three variants:
 * - normal: Standard logo with dark text (for light backgrounds)
 * - inverted: Logo with light text (for dark backgrounds)
 * - standalone: Just the icon without text
 */
const Logo: React.FC<LogoProps> = ({
  variant = 'normal',
  width = 150,
  height,
  style,
}) => {
  // Calculate height based on aspect ratio if not provided
  const getHeight = () => {
    if (height) return height;
    
    // Default aspect ratios for each variant
    switch (variant) {
      case 'normal':
      case 'inverted':
        return width * 0.35; // Approximate aspect ratio for full logo
      case 'standalone':
        return width; // Standalone logo is roughly square
      default:
        return width * 0.35;
    }
  };
  
  // Get the appropriate logo component based on variant
  const LogoComponent = (): React.FC<SvgProps> => {
    switch (variant) {
      case 'normal':
        return NormalLogo;
      case 'inverted':
        return InvertedLogo;
      case 'standalone':
        return StandaloneLogo;
      default:
        return NormalLogo;
    }
  };
  
  const SelectedLogo = LogoComponent();
  const calculatedHeight = getHeight();
  
  return (
    <View style={[styles.container, style]}>
      <SelectedLogo width={width} height={calculatedHeight} />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export default Logo;
