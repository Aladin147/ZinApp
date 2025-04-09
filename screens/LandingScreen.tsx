import React from 'react';
import { View, Image, StyleSheet } from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RootStackParamList } from '@types';
import { colors } from '@constants';
import tw from 'twrnc';

// Import our custom components
import Screen from '@components/layout/Screen';
import Typography from '@components/common/Typography';
import Button from '@components/common/Button';
import Card from '@components/common/Card';

type LandingScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'LandingScreen'
>;

type Props = {
  navigation: LandingScreenNavigationProp;
};

const LandingScreen: React.FC<Props> = ({ navigation }) => {
  return (
    <Screen scrollable>
      <View style={tw`flex-1 items-center justify-center p-6`}>
        {/* Logo */}
        <View style={tw`items-center mb-12 mt-8`}>
          <View style={styles.logoContainer}>
            <Typography variant="heading" size="large" align="center" style={tw`text-3xl`}>
              ZinApp
            </Typography>
          </View>
          <Typography variant="caption" align="center" style={tw`mt-2`}>
            On-Demand Grooming Platform
          </Typography>
        </View>

        {/* Welcome Card */}
        <Card style={tw`w-full mb-8`}>
          <Typography variant="subheading" weight="bold" style={tw`mb-2`}>
            Welcome to ZinApp
          </Typography>
          <Typography variant="body" style={tw`mb-4`}>
            Book haircuts, beard trims, braids, or full services in seconds.
          </Typography>
          <Typography variant="caption" color={colors.textMuted}>
            Discover stylists by proximity, rating, and portfolio.
          </Typography>
        </Card>

        {/* Action Buttons */}
        <Button
          title="Let's Book"
          variant="primary"
          size="large"
          style={tw`w-full mb-4`}
          onPress={() => navigation.navigate('ServiceSelectScreen')}
        />

        <Button
          title="Scan Stylist QR"
          variant="outline"
          style={tw`w-full`}
          onPress={() => navigation.navigate('ServiceSelectScreen')}
        />
      </View>
    </Screen>
  );
};

const styles = StyleSheet.create({
  logoContainer: {
    width: 120,
    height: 120,
    borderRadius: 60,
    backgroundColor: colors.primary,
    alignItems: 'center',
    justifyContent: 'center',
    shadowColor: colors.primary,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 5,
  },
});

export default LandingScreen;
