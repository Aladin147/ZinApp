import React, { useEffect, useRef, useState } from 'react';
import { View, StyleSheet, Image, Animated } from 'react-native';
import MapView, { Marker, Polyline, PROVIDER_GOOGLE } from 'react-native-maps';
import { colors, spacing } from '../../constants';
import Typography from '../common/Typography';
import Card from '../common/Card';
import Icon from 'react-native-vector-icons/FontAwesome';

interface Coordinate {
  latitude: number;
  longitude: number;
}

interface MapTrackerProps {
  /**
   * Stylist's current location
   */
  stylistLocation: Coordinate;
  
  /**
   * User's location (destination)
   */
  userLocation: Coordinate;
  
  /**
   * Estimated time of arrival in minutes
   */
  eta: number;
  
  /**
   * Stylist's profile picture URL
   */
  stylistAvatar?: string;
  
  /**
   * Stylist's name
   */
  stylistName?: string;
  
  /**
   * Whether the stylist is verified
   */
  isVerified?: boolean;
  
  /**
   * Optional waypoints for the route
   */
  waypoints?: Coordinate[];
  
  /**
   * Callback when the stylist arrives
   */
  onArrival?: () => void;
}

/**
 * MapTracker component for displaying live tracking of a stylist
 * 
 * Based on the design specifications in the conceptboard:
 * - Map view with stylist and user markers
 * - Route line in primary color
 * - ETA display
 * - Stylist avatar
 */
const MapTracker: React.FC<MapTrackerProps> = ({
  stylistLocation,
  userLocation,
  eta,
  stylistAvatar,
  stylistName = 'Your Stylist',
  isVerified = false,
  waypoints = [],
  onArrival,
}) => {
  // Reference to the map view
  const mapRef = useRef<MapView>(null);
  
  // Animation value for the pulsing effect on the user marker
  const pulseAnim = useRef(new Animated.Value(0.5)).current;
  
  // State to track if the stylist has arrived
  const [hasArrived, setHasArrived] = useState(false);
  
  // Calculate the route coordinates including waypoints
  const routeCoordinates = [
    stylistLocation,
    ...waypoints,
    userLocation,
  ];
  
  // Start the pulsing animation for the user marker
  useEffect(() => {
    Animated.loop(
      Animated.sequence([
        Animated.timing(pulseAnim, {
          toValue: 1,
          duration: 1000,
          useNativeDriver: true,
        }),
        Animated.timing(pulseAnim, {
          toValue: 0.5,
          duration: 1000,
          useNativeDriver: true,
        }),
      ])
    ).start();
  }, [pulseAnim]);
  
  // Check if the stylist has arrived (when ETA reaches 0)
  useEffect(() => {
    if (eta <= 0 && !hasArrived) {
      setHasArrived(true);
      if (onArrival) {
        onArrival();
      }
    }
  }, [eta, hasArrived, onArrival]);
  
  // Fit the map to show both markers when the component mounts
  useEffect(() => {
    if (mapRef.current) {
      mapRef.current.fitToCoordinates(routeCoordinates, {
        edgePadding: { top: 50, right: 50, bottom: 50, left: 50 },
        animated: true,
      });
    }
  }, [routeCoordinates]);
  
  // Placeholder image for development
  const placeholderImage = 'https://via.placeholder.com/100';
  const avatarSource = stylistAvatar
    ? { uri: stylistAvatar.startsWith('http') ? stylistAvatar : placeholderImage }
    : { uri: placeholderImage };
  
  return (
    <View style={styles.container}>
      {/* Map View */}
      <MapView
        ref={mapRef}
        style={styles.map}
        provider={PROVIDER_GOOGLE}
        initialRegion={{
          latitude: userLocation.latitude,
          longitude: userLocation.longitude,
          latitudeDelta: 0.01,
          longitudeDelta: 0.01,
        }}
      >
        {/* Stylist Marker */}
        <Marker
          coordinate={stylistLocation}
          title={stylistName}
          description={hasArrived ? 'Has arrived' : `${eta} min away`}
        >
          <View style={styles.stylistMarker}>
            <Image
              source={avatarSource}
              style={styles.stylistAvatar}
              resizeMode="cover"
            />
            {isVerified && (
              <View style={styles.verifiedBadge}>
                <Typography variant="caption" color="white" style={styles.verifiedText}>
                  ✓
                </Typography>
              </View>
            )}
          </View>
        </Marker>
        
        {/* User Marker (Destination) */}
        <Marker coordinate={userLocation} title="Your Location">
          <Animated.View
            style={[
              styles.userMarker,
              {
                transform: [{ scale: pulseAnim }],
              },
            ]}
          >
            <View style={styles.userMarkerInner} />
          </Animated.View>
        </Marker>
        
        {/* Route Line */}
        <Polyline
          coordinates={routeCoordinates}
          strokeWidth={4}
          strokeColor={colors.primary}
          lineDashPattern={[1, 0]}
        />
      </MapView>
      
      {/* ETA Card */}
      <Card
        variant="elevated"
        padding="medium"
        style={styles.etaCard}
      >
        <View style={styles.etaHeader}>
          <Typography variant="sectionHeader">
            {hasArrived ? 'Stylist has arrived!' : `ETA: ${eta} minutes`}
          </Typography>
          <View style={styles.etaIcon}>
            <Icon name="clock-o" size={20} color={colors.primary} />
          </View>
        </View>
        
        <View style={styles.stylistInfo}>
          <Image
            source={avatarSource}
            style={styles.cardAvatar}
            resizeMode="cover"
          />
          <View style={styles.stylistDetails}>
            <Typography variant="body">
              {stylistName}
            </Typography>
            <Typography variant="caption" color={colors.textMuted}>
              {hasArrived ? 'Ready to start' : 'On the way'}
            </Typography>
          </View>
        </View>
      </Card>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    position: 'relative',
  },
  map: {
    ...StyleSheet.absoluteFillObject,
  },
  stylistMarker: {
    position: 'relative',
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: colors.bgLight,
    borderWidth: 2,
    borderColor: colors.primary,
    justifyContent: 'center',
    alignItems: 'center',
    overflow: 'hidden',
  },
  stylistAvatar: {
    width: 36,
    height: 36,
    borderRadius: 18,
  },
  verifiedBadge: {
    position: 'absolute',
    bottom: 0,
    right: 0,
    width: 14,
    height: 14,
    borderRadius: 7,
    backgroundColor: colors.accent,
    alignItems: 'center',
    justifyContent: 'center',
    borderWidth: 1,
    borderColor: colors.bgLight,
  },
  verifiedText: {
    fontSize: 8,
    lineHeight: 10,
  },
  userMarker: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'rgba(244, 128, 93, 0.3)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  userMarkerInner: {
    width: 20,
    height: 20,
    borderRadius: 10,
    backgroundColor: colors.primary,
    borderWidth: 2,
    borderColor: colors.bgLight,
  },
  etaCard: {
    position: 'absolute',
    bottom: spacing.lg,
    left: spacing.md,
    right: spacing.md,
    borderRadius: 16,
  },
  etaHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: spacing.sm,
  },
  etaIcon: {
    width: 36,
    height: 36,
    borderRadius: 18,
    backgroundColor: 'rgba(244, 128, 93, 0.1)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  stylistInfo: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  cardAvatar: {
    width: 40,
    height: 40,
    borderRadius: 20,
    marginRight: spacing.sm,
  },
  stylistDetails: {
    flex: 1,
  },
});

export default MapTracker;
