import React, { useState, useEffect, useRef } from 'react';
import {
  View,
  StyleSheet,
  TouchableOpacity,
  Animated,
  Image
} from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '../types';
import { colors, spacing } from '../constants';
import { Typography, Card, Button } from '../components';
import { FontAwesome } from '@expo/vector-icons';
import ErrorBoundary from '../components/common/ErrorBoundary';
import { LinearGradient } from 'expo-linear-gradient';

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

// Screen component

const LiveTrackScreen: React.FC<Props> = ({ navigation, route }) => {
  const bookingId = route.params?.bookingId;

  // Animation values
  const fadeAnim = useRef(new Animated.Value(0)).current;
  const slideAnim = useRef(new Animated.Value(50)).current;
  const pulseAnim = useRef(new Animated.Value(1)).current;

  // State for ETA countdown
  const [eta, setEta] = useState(15); // Start with 15 minutes
  const [etaText, setEtaText] = useState('15 min');
  const [showDetails, setShowDetails] = useState(false);

  // Note: In a real app, we would use actual location data

  // Mock stylist data
  const stylist = {
    id: 1,
    name: 'Hassan the Barber',
    rating: 4.8,
    verified: true,
    avatar: 'https://randomuser.me/api/portraits/men/32.jpg',
    phone: '+212 612 345 678',
  };

  // Mock booking data
  const booking = {
    id: bookingId,
    service: 'Haircut',
    price: 35,
    date: 'Today',
    time: '3:30 PM',
  };

  // Start animations when component mounts
  useEffect(() => {
    // Start fade and slide animations
    Animated.parallel([
      Animated.timing(fadeAnim, {
        toValue: 1,
        duration: 600,
        useNativeDriver: true,
      }),
      Animated.timing(slideAnim, {
        toValue: 0,
        duration: 600,
        useNativeDriver: true,
      }),
    ]).start();

    // Start pulse animation
    Animated.loop(
      Animated.sequence([
        Animated.timing(pulseAnim, {
          toValue: 1.1,
          duration: 1000,
          useNativeDriver: true,
        }),
        Animated.timing(pulseAnim, {
          toValue: 1,
          duration: 1000,
          useNativeDriver: true,
        }),
      ])
    ).start();
  }, []);

  // Countdown ETA
  useEffect(() => {
    if (eta <= 0) return;

    const timer = setTimeout(() => {
      setEta(prevEta => {
        const newEta = prevEta - 1;

        // Update ETA text
        if (newEta <= 0) {
          setEtaText('Arrived!');
        } else if (newEta === 1) {
          setEtaText('1 min');
        } else {
          setEtaText(`${newEta} mins`);
        }

        return newEta;
      });
    }, 60000); // Update every minute

    // For demo purposes, update more frequently
    const demoTimer = setTimeout(() => {
      if (eta > 0) {
        setEtaText(`${eta} min${eta !== 1 ? 's' : ''}`);
      }
    }, 5000);

    return () => {
      clearTimeout(timer);
      clearTimeout(demoTimer);
    };
  }, [eta]);

  // Handle stylist arrival
  const handleArrival = () => {
    navigation.navigate('Bsse7aScreen', { bookingId: bookingId });
  };

  // Simulate faster arrival for demo purposes
  const simulateArrival = () => {
    setEta(0);
    setEtaText('Arrived!');
    setTimeout(() => {
      handleArrival();
    }, 1500);
  };

  // Toggle details panel
  const toggleDetails = () => {
    setShowDetails(!showDetails);
  };

  return (
    <ErrorBoundary>
      <View style={styles.container}>
        {/* Map View */}
        <View style={styles.mapContainer}>
          {/* Placeholder for map - in a real app, this would be the MapTracker component */}
          <View style={styles.mapPlaceholder}>
            <LinearGradient
              colors={['rgba(244, 128, 93, 0.2)', 'rgba(244, 128, 93, 0.1)', 'rgba(255, 255, 255, 0)']}
              style={styles.mapGradient}
            />
            {/* Use a colored background instead of an image */}
            <View
              style={[styles.mapImage, { backgroundColor: '#E8E8E8' }]}
            />

            {/* Stylist marker */}
            <Animated.View
              style={[
                styles.stylistMarker,
                { transform: [{ scale: pulseAnim }] }
              ]}
            >
              <View style={styles.stylistMarkerInner}>
                <Image
                  source={{ uri: stylist.avatar }}
                  style={styles.stylistAvatar}
                />
                {stylist.verified && (
                  <View style={styles.verifiedBadge}>
                    <FontAwesome name="check" size={8} color="white" />
                  </View>
                )}
              </View>
            </Animated.View>

            {/* User marker */}
            <View style={styles.userMarker}>
              <View style={styles.userMarkerInner} />
            </View>

            {/* Route line */}
            <View style={styles.routeLine} />
          </View>
        </View>

        {/* Action Buttons */}
        <Animated.View
          style={[
            styles.actionButtons,
            {
              opacity: fadeAnim,
              transform: [{ translateY: slideAnim }]
            }
          ]}
        >
          <TouchableOpacity style={styles.actionButton} activeOpacity={0.7}>
            <View style={styles.actionButtonInner}>
              <FontAwesome name="phone" size={20} color={colors.primary} />
            </View>
            <Typography variant="caption" color={colors.textMuted} style={styles.actionText}>
              Call
            </Typography>
          </TouchableOpacity>

          <TouchableOpacity style={styles.actionButton} activeOpacity={0.7}>
            <View style={styles.actionButtonInner}>
              <FontAwesome name="comment" size={20} color={colors.primary} />
            </View>
            <Typography variant="caption" color={colors.textMuted} style={styles.actionText}>
              Message
            </Typography>
          </TouchableOpacity>

          <TouchableOpacity style={styles.actionButton} activeOpacity={0.7}>
            <View style={styles.actionButtonInner}>
              <FontAwesome name="times-circle" size={20} color={colors.error} />
            </View>
            <Typography variant="caption" color={colors.error} style={styles.actionText}>
              Cancel
            </Typography>
          </TouchableOpacity>
        </Animated.View>

        {/* ETA Card */}
        <Animated.View
          style={[
            styles.etaCardContainer,
            {
              opacity: fadeAnim,
              transform: [{ translateY: slideAnim }]
            }
          ]}
        >
          <Card style={styles.etaCard} variant="bubble" withShadow>
            <TouchableOpacity
              style={styles.etaCardContent}
              onPress={toggleDetails}
              activeOpacity={0.9}
            >
              <View style={styles.etaInfo}>
                <View style={styles.etaHeader}>
                  <Typography variant="subheading" style={styles.etaTitle}>
                    {eta <= 0 ? 'Your stylist has arrived!' : 'Your stylist is on the way'}
                  </Typography>
                  <FontAwesome
                    name={showDetails ? "chevron-down" : "chevron-up"}
                    size={16}
                    color={colors.textMuted}
                  />
                </View>

                <View style={styles.etaTimeContainer}>
                  <View style={styles.etaTimeIconContainer}>
                    <FontAwesome name="clock-o" size={20} color={colors.primary} />
                  </View>
                  <Typography
                    variant="heading"
                    color={eta <= 0 ? colors.success : colors.primary}
                    style={styles.etaTime}
                  >
                    {etaText}
                  </Typography>
                </View>
              </View>

              <View style={styles.stylistInfo}>
                <Image source={{ uri: stylist.avatar }} style={styles.stylistCardAvatar} />
                <View style={styles.stylistDetails}>
                  <Typography variant="bodyMedium" style={styles.stylistName}>
                    {stylist.name}
                  </Typography>
                  <View style={styles.ratingContainer}>
                    <FontAwesome name="star" size={14} color="#FFD700" />
                    <Typography variant="caption" style={styles.ratingText}>
                      {stylist.rating}
                    </Typography>
                  </View>
                </View>
              </View>
            </TouchableOpacity>

            {/* Expanded details */}
            {showDetails && (
              <View style={styles.expandedDetails}>
                <View style={styles.divider} />

                <View style={styles.bookingDetails}>
                  <View style={styles.bookingDetailItem}>
                    <FontAwesome name="scissors" size={14} color={colors.textMuted} />
                    <Typography variant="body" style={styles.bookingDetailText}>
                      {booking.service}
                    </Typography>
                    <Typography variant="bodyMedium" color={colors.primary} style={styles.bookingPrice}>
                      ${booking.price}
                    </Typography>
                  </View>

                  <View style={styles.bookingDetailItem}>
                    <FontAwesome name="calendar" size={14} color={colors.textMuted} />
                    <Typography variant="body" style={styles.bookingDetailText}>
                      {booking.date}, {booking.time}
                    </Typography>
                  </View>

                  <View style={styles.bookingDetailItem}>
                    <FontAwesome name="map-marker" size={14} color={colors.textMuted} />
                    <Typography variant="body" style={styles.bookingDetailText}>
                      Your current location
                    </Typography>
                  </View>
                </View>

                <View style={styles.divider} />

                <View style={styles.trackingUpdates}>
                  <Typography variant="bodyMedium" style={styles.trackingTitle}>
                    Tracking Updates
                  </Typography>

                  <View style={styles.updateItem}>
                    <View style={[styles.updateDot, { backgroundColor: colors.success }]} />
                    <View style={styles.updateContent}>
                      <Typography variant="body" style={styles.updateText}>
                        Hassan has accepted your booking
                      </Typography>
                      <Typography variant="caption" color={colors.textMuted}>
                        15 minutes ago
                      </Typography>
                    </View>
                  </View>

                  <View style={styles.updateItem}>
                    <View style={[styles.updateDot, { backgroundColor: colors.primary }]} />
                    <View style={styles.updateContent}>
                      <Typography variant="body" style={styles.updateText}>
                        Hassan is on the way to your location
                      </Typography>
                      <Typography variant="caption" color={colors.textMuted}>
                        10 minutes ago
                      </Typography>
                    </View>
                  </View>

                  {eta <= 5 && (
                    <View style={styles.updateItem}>
                      <View style={[styles.updateDot, { backgroundColor: colors.info }]} />
                      <View style={styles.updateContent}>
                        <Typography variant="body" style={styles.updateText}>
                          Hassan is almost at your location
                        </Typography>
                        <Typography variant="caption" color={colors.textMuted}>
                          Just now
                        </Typography>
                      </View>
                    </View>
                  )}
                </View>
              </View>
            )}
          </Card>
        </Animated.View>

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

        {/* Back Button */}
        <TouchableOpacity
          style={styles.backButton}
          onPress={() => navigation.goBack()}
          activeOpacity={0.7}
        >
          <FontAwesome name="arrow-left" size={18} color="white" />
        </TouchableOpacity>
      </View>
    </ErrorBoundary>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.bgLight,
  },
  mapContainer: {
    flex: 1,
    position: 'relative',
  },
  mapPlaceholder: {
    flex: 1,
    backgroundColor: '#f2f2f2',
    position: 'relative',
  },
  mapGradient: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    height: 200,
    zIndex: 1,
  },
  mapImage: {
    width: '100%',
    height: '100%',
    position: 'absolute',
  },
  stylistMarker: {
    position: 'absolute',
    top: '40%',
    left: '30%',
    width: 50,
    height: 50,
    justifyContent: 'center',
    alignItems: 'center',
    zIndex: 2,
  },
  stylistMarkerInner: {
    width: 44,
    height: 44,
    borderRadius: 22,
    backgroundColor: 'white',
    justifyContent: 'center',
    alignItems: 'center',
    shadowColor: 'rgba(0,0,0,0.3)',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 4,
    elevation: 5,
  },
  stylistAvatar: {
    width: 40,
    height: 40,
    borderRadius: 20,
  },
  verifiedBadge: {
    position: 'absolute',
    bottom: 0,
    right: 0,
    width: 16,
    height: 16,
    borderRadius: 8,
    backgroundColor: colors.success,
    alignItems: 'center',
    justifyContent: 'center',
    borderWidth: 2,
    borderColor: 'white',
  },
  userMarker: {
    position: 'absolute',
    bottom: '30%',
    right: '30%',
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'rgba(244, 128, 93, 0.3)',
    justifyContent: 'center',
    alignItems: 'center',
    zIndex: 2,
  },
  userMarkerInner: {
    width: 20,
    height: 20,
    borderRadius: 10,
    backgroundColor: colors.primary,
    borderWidth: 2,
    borderColor: 'white',
  },
  routeLine: {
    position: 'absolute',
    top: '42%',
    left: '33%',
    width: '37%',
    height: 4,
    backgroundColor: colors.primary,
    transform: [{ rotate: '45deg' }],
    zIndex: 1,
  },
  actionButtons: {
    position: 'absolute',
    top: spacing.lg,
    left: spacing.md,
    right: spacing.md,
    flexDirection: 'row',
    justifyContent: 'space-between',
    backgroundColor: 'white',
    borderRadius: 20,
    padding: spacing.sm,
    shadowColor: 'rgba(0,0,0,0.1)',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 4,
    elevation: 3,
    zIndex: 10,
  },
  actionButton: {
    alignItems: 'center',
    justifyContent: 'center',
    padding: spacing.sm,
  },
  actionButtonInner: {
    width: 44,
    height: 44,
    borderRadius: 22,
    backgroundColor: 'rgba(244, 128, 93, 0.1)',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: spacing.xs,
  },
  actionText: {
    marginTop: spacing.xxs,
  },
  etaCardContainer: {
    position: 'absolute',
    bottom: spacing.lg,
    left: spacing.md,
    right: spacing.md,
    zIndex: 10,
  },
  etaCard: {
    borderRadius: 20,
    backgroundColor: 'white',
    overflow: 'hidden',
  },
  etaCardContent: {
    padding: spacing.md,
  },
  etaInfo: {
    marginBottom: spacing.md,
  },
  etaHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: spacing.sm,
  },
  etaTitle: {
    flex: 1,
  },
  etaTimeContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  etaTimeIconContainer: {
    width: 36,
    height: 36,
    borderRadius: 18,
    backgroundColor: 'rgba(244, 128, 93, 0.1)',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: spacing.sm,
  },
  etaTime: {
    fontWeight: 'bold',
  },
  stylistInfo: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  stylistCardAvatar: {
    width: 50,
    height: 50,
    borderRadius: 25,
    marginRight: spacing.sm,
  },
  stylistDetails: {
    flex: 1,
  },
  stylistName: {
    fontWeight: '600',
    marginBottom: spacing.xxs,
  },
  ratingContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  ratingText: {
    marginLeft: spacing.xs,
  },
  expandedDetails: {
    paddingHorizontal: spacing.md,
    paddingBottom: spacing.md,
  },
  divider: {
    height: 1,
    backgroundColor: 'rgba(0,0,0,0.05)',
    marginVertical: spacing.sm,
  },
  bookingDetails: {
    marginBottom: spacing.sm,
  },
  bookingDetailItem: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: spacing.xs,
  },
  bookingDetailText: {
    marginLeft: spacing.sm,
    flex: 1,
  },
  bookingPrice: {
    fontWeight: '600',
  },
  trackingUpdates: {
    marginTop: spacing.xs,
  },
  trackingTitle: {
    fontWeight: '600',
    marginBottom: spacing.sm,
  },
  updateItem: {
    flexDirection: 'row',
    marginBottom: spacing.sm,
  },
  updateDot: {
    width: 12,
    height: 12,
    borderRadius: 6,
    marginTop: 4,
    marginRight: spacing.sm,
  },
  updateContent: {
    flex: 1,
  },
  updateText: {
    marginBottom: spacing.xxs,
  },
  demoButton: {
    position: 'absolute',
    bottom: spacing.xxxl,
    alignSelf: 'center',
    backgroundColor: 'rgba(255,255,255,0.9)',
    zIndex: 5,
  },
  backButton: {
    position: 'absolute',
    top: spacing.lg + 10,
    left: spacing.lg,
    width: 36,
    height: 36,
    borderRadius: 18,
    backgroundColor: 'rgba(0,0,0,0.3)',
    alignItems: 'center',
    justifyContent: 'center',
    zIndex: 20,
  },
});

export default LiveTrackScreen;
