import React from 'react';
import { View, Image, StyleSheet, TouchableOpacity } from 'react-native';
import Card from '../common/Card';
import Typography from '../common/Typography';
import { colors } from '../../constants';
import tw from 'twrnc';
import { MotiView } from 'moti';

interface BarberCardProps {
  id: number;
  name: string;
  rating: number;
  distance_km: number;
  verified: boolean;
  profile_picture: string;
  onPress: (id: number) => void;
}

/**
 * BarberCard component for displaying stylist information
 */
const BarberCard: React.FC<BarberCardProps> = ({
  id,
  name,
  rating,
  distance_km,
  verified,
  profile_picture,
  onPress,
}) => {
  const handlePress = () => {
    onPress(id);
  };

  // Placeholder image for development
  const placeholderImage = 'https://via.placeholder.com/100';
  const imageSource = profile_picture
    ? { uri: profile_picture.startsWith('http') ? profile_picture : placeholderImage }
    : { uri: placeholderImage };

  return (
    <Card
      variant="default"
      onPress={handlePress}
      style={tw`mb-4`}
    >
      <View style={tw`flex-row items-center`}>
        <View style={tw`mr-4`}>
          <MotiView
            from={{ scale: 0.9, opacity: 0.5 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ type: 'timing', duration: 500 }}
          >
            <Image
              source={imageSource}
              style={styles.profileImage}
              resizeMode="cover"
            />
          </MotiView>
          {verified && (
            <MotiView
              from={{ scale: 0, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              transition={{ type: 'spring', damping: 15, delay: 300 }}
              style={styles.verifiedBadge}
            >
              <Typography variant="caption" color="white" align="center" style={tw`text-xs`}>
                ✓
              </Typography>
            </MotiView>
          )}
        </View>

        <View style={tw`flex-1`}>
          <Typography variant="subheading" weight="bold">
            {name}
          </Typography>

          <View style={tw`flex-row items-center mt-1`}>
            <View style={tw`flex-row items-center mr-4`}>
              <Typography variant="caption" color={colors.primary} style={tw`mr-1`}>
                ★
              </Typography>
              <Typography variant="caption">
                {rating.toFixed(1)}
              </Typography>
            </View>

            <Typography variant="caption">
              {distance_km.toFixed(1)} km away
            </Typography>
          </View>
        </View>

        <MotiView
          from={{ translateX: 20, opacity: 0 }}
          animate={{ translateX: 0, opacity: 1 }}
          transition={{ type: 'spring', damping: 15, delay: 200 }}
        >
          <TouchableOpacity
            style={styles.bookButton}
            onPress={handlePress}
          >
            <Typography variant="caption" color="white" weight="medium">
              Book
            </Typography>
          </TouchableOpacity>
        </MotiView>
      </View>
    </Card>
  );
};

const styles = StyleSheet.create({
  profileImage: {
    width: 70,
    height: 70,
    borderRadius: 35, // Fully rounded like Glovo
    backgroundColor: colors.gray200,
    borderWidth: 2,
    borderColor: colors.stylistBlue,
  },
  verifiedBadge: {
    position: 'absolute',
    bottom: 0,
    right: 0,
    width: 24,
    height: 24,
    borderRadius: 12, // Fully rounded like Glovo
    backgroundColor: colors.accent1, // Glovo-like yellow accent
    alignItems: 'center',
    justifyContent: 'center',
    borderWidth: 2,
    borderColor: 'white',
    shadowColor: 'rgba(0,0,0,0.2)',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 3,
    elevation: 3,
  },
  bookButton: {
    backgroundColor: colors.primary,
    paddingVertical: 8,
    paddingHorizontal: 16,
    borderRadius: 20, // More rounded like Glovo
    shadowColor: 'rgba(0,0,0,0.1)',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 3,
    elevation: 2,
  },
});

export default BarberCard;
