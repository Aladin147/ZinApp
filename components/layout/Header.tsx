import React from 'react';
import {
  View,
  TouchableOpacity,
  StyleSheet,
  ViewStyle
} from 'react-native';
import { useNavigation } from '@react-navigation/native';
import Typography from '../common/Typography';
import { colors } from '@constants';

interface HeaderProps {
  title: string;
  showBackButton?: boolean;
  rightComponent?: React.ReactNode;
  style?: ViewStyle;
  titleAlign?: 'left' | 'center';
  onBackPress?: () => void;
}

/**
 * Header component for screen headers
 *
 * Based on the specifications in the design documentation:
 * - 24px header padding for vertical scroll sections
 * - Screen Title: 24px, Bold, 32px line height
 */
const Header: React.FC<HeaderProps> = ({
  title,
  showBackButton = true,
  rightComponent,
  style,
  titleAlign = 'center',
  onBackPress,
}) => {
  const navigation = useNavigation();

  const handleBackPress = () => {
    if (onBackPress) {
      onBackPress();
    } else {
      navigation.goBack();
    }
  };

  return (
    <View style={[styles.header, style]}>
      <View style={styles.leftContainer}>
        {showBackButton && (
          <TouchableOpacity
            onPress={handleBackPress}
            style={styles.backButton}
            hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
          >
            {/* Back arrow icon - simplified for now */}
            <View style={styles.backArrow} />
          </TouchableOpacity>
        )}
      </View>

      <View style={[
        styles.titleContainer,
        titleAlign === 'center' ? styles.titleCenter : styles.titleLeft
      ]}>
        <Typography
          variant="screenTitle"
          align={titleAlign}
          numberOfLines={1}
        >
          {title}
        </Typography>
      </View>

      <View style={styles.rightContainer}>
        {rightComponent}
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingVertical: 16,
    paddingHorizontal: 16,
  },
  leftContainer: {
    width: 40,
    alignItems: 'flex-start',
  },
  rightContainer: {
    width: 40,
    alignItems: 'flex-end',
  },
  titleContainer: {
    flex: 1,
  },
  titleCenter: {
    alignItems: 'center',
  },
  titleLeft: {
    alignItems: 'flex-start',
    marginLeft: 8,
  },
  backButton: {
    padding: 8,
  },
  backArrow: {
    width: 16,
    height: 16,
    borderLeftWidth: 2,
    borderBottomWidth: 2,
    transform: [{ rotate: '45deg' }],
    borderColor: colors.textMain,
  },
});

export default Header;
