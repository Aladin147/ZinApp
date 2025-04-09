import React from 'react';
import {
  View,
  Image,
  StyleSheet,
  ViewStyle,
  ImageSourcePropType,
  ImageStyle
} from 'react-native';
import { colors } from '@constants';
import Typography from './Typography';

interface AvatarProps {
  /**
   * Source for the avatar image
   */
  source: ImageSourcePropType;
  
  /**
   * Size of the avatar
   */
  size?: 'small' | 'medium' | 'large';
  
  /**
   * Whether the user is verified
   */
  verified?: boolean;
  
  /**
   * Additional style for the container
   */
  style?: ViewStyle;
  
  /**
   * Additional style for the image
   */
  imageStyle?: ImageStyle;
  
  /**
   * Background color for the avatar container
   */
  backgroundColor?: string;
  
  /**
   * Border color for the avatar
   */
  borderColor?: string;
}

/**
 * Avatar component for displaying user profile images
 * 
 * Based on the specifications in the design documentation:
 * - Circular design with 20px border radius for profile avatars
 * - Blue verification badge for verified stylists
 * - Different sizes (small, medium, large)
 */
const Avatar: React.FC<AvatarProps> = ({
  source,
  size = 'medium',
  verified = false,
  style,
  imageStyle,
  backgroundColor = colors.gray200,
  borderColor,
}) => {
  // Get size dimensions based on size prop
  const getDimensions = () => {
    switch (size) {
      case 'small':
        return {
          container: 40,
          badge: 16,
          badgeText: 10,
        };
      case 'medium':
        return {
          container: 60,
          badge: 20,
          badgeText: 12,
        };
      case 'large':
        return {
          container: 100,
          badge: 24,
          badgeText: 14,
        };
      default:
        return {
          container: 60,
          badge: 20,
          badgeText: 12,
        };
    }
  };

  const dimensions = getDimensions();
  
  // Create container style with dimensions
  const containerStyle = {
    width: dimensions.container,
    height: dimensions.container,
    borderRadius: dimensions.container / 2,
    backgroundColor,
    ...(borderColor && { borderWidth: 2, borderColor }),
  };
  
  // Create badge style with dimensions
  const badgeStyle = {
    width: dimensions.badge,
    height: dimensions.badge,
    borderRadius: dimensions.badge / 2,
  };

  return (
    <View style={[styles.container, containerStyle, style]}>
      <Image
        source={source}
        style={[
          styles.image,
          { width: dimensions.container, height: dimensions.container, borderRadius: dimensions.container / 2 },
          imageStyle
        ]}
        resizeMode="cover"
      />
      
      {verified && (
        <View style={[styles.verifiedBadge, badgeStyle]}>
          <Typography
            variant="caption"
            color="white"
            align="center"
            style={{ fontSize: dimensions.badgeText, lineHeight: dimensions.badgeText + 2 }}
          >
            ✓
          </Typography>
        </View>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    position: 'relative',
  },
  image: {
    backgroundColor: colors.gray200,
  },
  verifiedBadge: {
    position: 'absolute',
    bottom: 0,
    right: 0,
    backgroundColor: colors.accent, // Cool Blue Slate for stylist identity
    alignItems: 'center',
    justifyContent: 'center',
    borderWidth: 2,
    borderColor: 'white',
  },
});

export default Avatar;
