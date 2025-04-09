import React from 'react';
import { TouchableOpacity, View, StyleSheet } from 'react-native';
import Typography from '../common/Typography';
import { colors } from '@constants';
import tw from 'twrnc';

interface ServiceIconBtnProps {
  icon: string;
  label: string;
  price?: number;
  selected?: boolean;
  onPress: () => void;
}

/**
 * ServiceIconBtn component for service selection
 */
const ServiceIconBtn: React.FC<ServiceIconBtnProps> = ({
  icon,
  label,
  price,
  selected = false,
  onPress,
}) => {
  return (
    <TouchableOpacity
      style={[
        styles.container,
        selected && styles.selectedContainer,
      ]}
      onPress={onPress}
      activeOpacity={0.7}
    >
      <View style={styles.iconContainer}>
        <Typography variant="heading" align="center">
          {icon}
        </Typography>
      </View>
      
      <Typography 
        variant="body" 
        align="center"
        weight="medium"
        style={tw`mt-2`}
      >
        {label}
      </Typography>
      
      {price !== undefined && (
        <Typography 
          variant="caption" 
          align="center"
          color={selected ? colors.primary : colors.textMuted}
          style={tw`mt-1`}
        >
          {price} DH
        </Typography>
      )}
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  container: {
    width: 100,
    padding: 12,
    borderRadius: 16,
    alignItems: 'center',
    backgroundColor: colors.gray100,
    marginRight: 12,
    marginBottom: 12,
  },
  selectedContainer: {
    backgroundColor: colors.gray200,
    borderWidth: 2,
    borderColor: colors.primary,
  },
  iconContainer: {
    width: 50,
    height: 50,
    borderRadius: 25,
    backgroundColor: 'white',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 8,
  },
});

export default ServiceIconBtn;
