import React from 'react';
import { View, Image, StyleSheet, TouchableOpacity } from 'react-native';
import Card from '../common/Card';
import Typography from '../common/Typography';
import { colors } from '../../constants';
import tw from 'twrnc';

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
          <Image
            source={imageSource}
            style={styles.profileImage}
            resizeMode="cover"
          />
          {verified && (
            <View style={styles.verifiedBadge}>
              <Typography variant="caption" color="white" align="center" style={tw`text-xs`}>
                ✓
              </Typography>
            </View>
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

        <TouchableOpacity
          style={styles.bookButton}
          onPress={handlePress}
        >
          <Typography variant="caption" color="white" weight="medium">
            Book
          </Typography>
        </TouchableOpacity>
      </View>
    </Card>
  );
};

const styles = StyleSheet.create({
  profileImage: {
    width: 60,
    height: 60,
    borderRadius: 30,
    backgroundColor: colors.gray200,
  },
  verifiedBadge: {
    position: 'absolute',
    bottom: 0,
    right: 0,
    width: 20,
    height: 20,
    borderRadius: 10,
    backgroundColor: colors.accent,
    alignItems: 'center',
    justifyContent: 'center',
    borderWidth: 2,
    borderColor: 'white',
  },
  bookButton: {
    backgroundColor: colors.primary,
    paddingVertical: 6,
    paddingHorizontal: 12,
    borderRadius: 16,
  },
});

export default BarberCard;
