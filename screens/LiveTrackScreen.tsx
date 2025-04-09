import React, { useState, useEffect } from 'react';
import { View, StyleSheet, TouchableOpacity, Platform } from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '../types'; // Use relative path
import { colors, spacing } from '../constants'; // Use relative path
import MapTracker from '../components/specific/MapTracker'; // Use relative path
import Typography from '../components/common/Typography'; // Use relative path
import Button from '../components/common/Button'; // Use relative path
import Icon from 'react-native-vector-icons/FontAwesome';
import ErrorBoundary from '../components/common/ErrorBoundary'; // Use relative path
import tw from 'twrnc'; // Add missing import



type LiveTrackScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'LiveTrackScreen'
>;
type LiveTrackScreenRouteProp = RouteProp<
  RootStackParamList,
  'LiveTrackScreen'
>;

type Props = {
  navigation: LiveTrackScreenNavigationProp;
  route: LiveTrackScreenRouteProp;
};

const LiveTrackScreen: React.FC<Props> = ({ navigation, route }) => {
  const bookingId = route.params?.bookingId;

  // State for ETA countdown
  const [eta, setEta] = useState(15); // Start with 15 minutes

  // Mock stylist and user locations
  const stylistLocation = {
    latitude: 33.5899,
    longitude: -7.6039,
  };

  const userLocation = {
    latitude: 33.5921,
    longitude: -7.6089,
  };

  // Mock waypoints for the route
  const waypoints = [
    {
      latitude: 33.5910,
      longitude: -7.6060,
    },
    {
      latitude: 33.5915,
      longitude: -7.6075,
    },
  ];

  // Countdown ETA
  useEffect(() => {
    if (eta <= 0) return;

    const timer = setTimeout(() => {
      setEta(prevEta => prevEta - 1);
    }, 60000); // Update every minute

    return () => clearTimeout(timer);
  }, [eta]);

  // Handle stylist arrival
  const handleArrival = () => {
    navigation.navigate('Bsse7aScreen', { bookingId: bookingId });
  };

  // Simulate faster arrival for demo purposes
  const simulateArrival = () => {
    setEta(0);
    setTimeout(() => {
      handleArrival();
    }, 1000);
  };

  return (
    // Wrap the main content in ErrorBoundary
    <ErrorBoundary>
      <View style={styles.container}>
        {/* Map Tracker Component */}
        {/* Conditionally render MapTracker or a placeholder */}
        {/* For now, let's assume MapTracker might crash and render placeholder */}
        {/* <MapTracker
          stylistLocation={stylistLocation}
          userLocation={userLocation}
          eta={eta}
          stylistAvatar="https://via.placeholder.com/100"
          stylistName="Hassan the Barber"
          isVerified={true}
          waypoints={waypoints}
          onArrival={handleArrival}
        /> */}
        <View style={tw`flex-1 items-center justify-center`}>
            <Typography variant="heading">Map Placeholder</Typography>
            <Typography variant="body">Live tracking unavailable in this demo phase.</Typography>
        </View>

        {/* Action Buttons */}
        {/* Duplicated block removed */}
        <View style={styles.actionButtons}>
          <TouchableOpacity style={styles.actionButton} activeOpacity={0.7}>
          <Icon name="phone" size={20} color={colors.primary} />
          <Typography variant="caption" color={colors.primary} style={styles.actionText}>
            Call
          </Typography>
        </TouchableOpacity>

        <TouchableOpacity style={styles.actionButton} activeOpacity={0.7}>
          <Icon name="comment" size={20} color={colors.primary} />
          <Typography variant="caption" color={colors.primary} style={styles.actionText}>
            Message
          </Typography>
        </TouchableOpacity>

        <TouchableOpacity style={styles.actionButton} activeOpacity={0.7}>
          <Icon name="times-circle" size={20} color={colors.error} />
          <Typography variant="caption" color={colors.error} style={styles.actionText}>
            Cancel
          </Typography>
        </TouchableOpacity>
      </View>

      {/* Demo Button */}
      <Button
        title="Simulate Arrival"
        variant="primary"
        size="small"
        iconName="fast-forward"
        iconPosition="left"
        onPress={simulateArrival}
        style={styles.demoButton}
      />
      </View>
    </ErrorBoundary>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.bgLight,
  },
  actionButtons: {
    position: 'absolute',
    top: spacing.lg,
    left: spacing.md,
    right: spacing.md,
    flexDirection: 'row',
    justifyContent: 'space-between',
    backgroundColor: colors.bgLight,
    borderRadius: 16,
    padding: spacing.sm,
    ...Platform.select({
      ios: {
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 2 },
        shadowOpacity: 0.1,
        shadowRadius: 4,
      },
      android: {
        elevation: 2,
      },
    }),
  },
  actionButton: {
    alignItems: 'center',
    justifyContent: 'center',
    padding: spacing.sm,
    borderRadius: 8,
  },
  actionText: {
    marginTop: spacing.xxs,
  },
  demoButton: {
    position: 'absolute',
    bottom: spacing.xl + 80, // Position above the ETA card
    alignSelf: 'center',
  },
});

export default LiveTrackScreen;
