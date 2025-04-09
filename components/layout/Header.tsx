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
import tw from 'twrnc';

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
    <View style={[tw`flex-row items-center justify-between py-4 px-4`, style]}>
      <View style={tw`w-10`}>
        {showBackButton && (
          <TouchableOpacity
            onPress={handleBackPress}
            style={tw`p-2 -ml-2`}
            hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
          >
            {/* Back arrow icon - simplified for now */}
            <View style={styles.backArrow} />
          </TouchableOpacity>
        )}
      </View>

      <View style={[
        tw`flex-1`,
        titleAlign === 'center' ? tw`items-center` : tw`items-start ml-2`
      ]}>
        <Typography 
          variant="subheading" 
          weight="bold"
          align={titleAlign}
          numberOfLines={1}
        >
          {title}
        </Typography>
      </View>

      <View style={tw`w-10 items-end`}>
        {rightComponent}
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
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
