import React, { useEffect } from 'react';
import { View, StyleSheet, TouchableOpacity, Animated, ScrollView } from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RootStackParamList } from '../types';
import { colors, spacing } from '../constants'; // Use relative path for now
import { FontAwesome } from '@expo/vector-icons';
// import { LinearGradient } from 'expo-linear-gradient'; // Not needed anymore
// import { MotiView } from 'moti'; // Comment out Moti

// Import our custom components
import { ImmersiveScreen, Typography, Button, Card, HeroHeader, ServiceButton } from '../components';

type LandingScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'LandingScreen'
>;

type Props = {
  navigation: LandingScreenNavigationProp;
};

const LandingScreen: React.FC<Props> = ({ navigation }) => {
  // Animation values
  const fadeAnim = React.useRef(new Animated.Value(0)).current;

  useEffect(() => {
    // Start the fade-in animation when the component mounts
    Animated.timing(fadeAnim, {
      toValue: 1,
      duration: 800,
      useNativeDriver: true,
    }).start();
  }, []);

  // Service options with their icons and colors
  const serviceOptions = [
    { id: 1, name: 'Haircut', icon: 'scissors' as const, color: colors.primary },
    { id: 2, name: 'Beard Trim', icon: 'user' as const, color: colors.stylistBlue },
    { id: 3, name: 'Braids', icon: 'paint-brush' as const, color: colors.success },
    { id: 4, name: 'Full Service', icon: 'star' as const, color: colors.info },
  ];

  return (
    <ImmersiveScreen contentPadding={0} statusBarStyle="light-content" scrollable={true}>
      {/* Hero Section with HeroHeader */}
      <HeroHeader
        title="ZinApp"
        icon={require('../assets/images/LOGO-StandAlone_ZinApp.png')}
        style={styles.heroHeader}
      />

      {/* Subtitle */}
      <View style={styles.subtitleContainer}>
        <Typography variant="body" color="white" style={styles.heroSubtitle}>
          Premium Grooming On-Demand
        </Typography>
      </View>

      {/* Main Content */}
      <View style={styles.content}>
        {/* Welcome Card */}
        <Card
          style={styles.welcomeCard}
          variant="bubble"
          withShadow
        >
          <Typography variant="sectionHeader" style={styles.welcomeTitle}>
            Welcome to ZinApp
          </Typography>
          <Typography variant="body" color={colors.textPrimary} style={styles.welcomeText}>
            Book haircuts, beard trims, braids, or full services in seconds. Discover stylists by proximity, rating, and portfolio.
          </Typography>
        </Card>

        {/* Service Selection */}
        <Typography variant="sectionHeader" color="white" style={styles.sectionTitle}>
          What do you need today?
        </Typography>

        {/* Service Buttons - Horizontal Scrollable */}
        <View style={styles.serviceButtonsContainer}>
          <ScrollView
            horizontal
            showsHorizontalScrollIndicator={false}
            contentContainerStyle={styles.serviceScroll}
          >
            {serviceOptions.map((service) => (
              <ServiceButton
                key={service.id}
                name={service.name}
                icon={service.icon}
                color={service.color}
                onPress={() => navigation.navigate('StylistListScreen', { serviceId: service.id })}
                variant="circle"
                size="medium"
                style={styles.serviceButton}
              />
            ))}
          </ScrollView>
        </View>

        {/* Featured Stylists Section */}
        <Typography variant="sectionHeader" color="white" style={styles.sectionTitle}>
          Top Stylists
        </Typography>

        {/* Stylist Cards - Horizontal Scrollable */}
        <View style={styles.stylistCardsContainer}>
          <ScrollView
            horizontal
            showsHorizontalScrollIndicator={false}
            contentContainerStyle={styles.stylistScroll}
          >
            {/* Placeholder stylist cards */}
            <TouchableOpacity activeOpacity={0.8}>
              <Card style={styles.stylistCard} variant="bubble" withShadow>
                <View style={styles.stylistCardContent}>
                  <View style={styles.stylistAvatar}>
                    <FontAwesome name="user" size={24} color={colors.primary} />
                  </View>
                  <Typography variant="bodyMedium" style={styles.stylistName}>Sarah J.</Typography>
                  <Typography variant="caption" color={colors.textMuted}>⭐ 4.8 (120)</Typography>
                </View>
              </Card>
            </TouchableOpacity>

            <TouchableOpacity activeOpacity={0.8}>
              <Card style={styles.stylistCard} variant="bubble" withShadow>
                <View style={styles.stylistCardContent}>
                  <View style={styles.stylistAvatar}>
                    <FontAwesome name="user" size={24} color={colors.stylistBlue} />
                  </View>
                  <Typography variant="bodyMedium" style={styles.stylistName}>Mike T.</Typography>
                  <Typography variant="caption" color={colors.textMuted}>⭐ 4.9 (85)</Typography>
                </View>
              </Card>
            </TouchableOpacity>

            <TouchableOpacity activeOpacity={0.8}>
              <Card style={styles.stylistCard} variant="bubble" withShadow>
                <View style={styles.stylistCardContent}>
                  <View style={styles.stylistAvatar}>
                    <FontAwesome name="user" size={24} color={colors.success} />
                  </View>
                  <Typography variant="bodyMedium" style={styles.stylistName}>Alex R.</Typography>
                  <Typography variant="caption" color={colors.textMuted}>⭐ 4.7 (92)</Typography>
                </View>
              </Card>
            </TouchableOpacity>
          </ScrollView>
        </View>

        {/* Popular Locations Section */}
        <Typography variant="sectionHeader" color="white" style={styles.sectionTitle}>
          Popular Locations
        </Typography>

        <ScrollView
          horizontal
          showsHorizontalScrollIndicator={false}
          contentContainerStyle={styles.locationsScroll}
        >
          {/* Location cards */}
          <TouchableOpacity activeOpacity={0.8}>
            <Card style={styles.locationCard} variant="bubble" withShadow>
              <View style={styles.locationImagePlaceholder}>
                <FontAwesome name="map-marker" size={24} color={colors.primary} />
              </View>
              <Typography variant="bodyMedium" style={styles.locationName}>Downtown</Typography>
              <Typography variant="caption" color={colors.textMuted}>12 stylists</Typography>
            </Card>
          </TouchableOpacity>

          <TouchableOpacity activeOpacity={0.8}>
            <Card style={styles.locationCard} variant="bubble" withShadow>
              <View style={styles.locationImagePlaceholder}>
                <FontAwesome name="map-marker" size={24} color={colors.stylistBlue} />
              </View>
              <Typography variant="bodyMedium" style={styles.locationName}>Westside</Typography>
              <Typography variant="caption" color={colors.textMuted}>8 stylists</Typography>
            </Card>
          </TouchableOpacity>

          <TouchableOpacity activeOpacity={0.8}>
            <Card style={styles.locationCard} variant="bubble" withShadow>
              <View style={styles.locationImagePlaceholder}>
                <FontAwesome name="map-marker" size={24} color={colors.success} />
              </View>
              <Typography variant="bodyMedium" style={styles.locationName}>Uptown</Typography>
              <Typography variant="caption" color={colors.textMuted}>15 stylists</Typography>
            </Card>
          </TouchableOpacity>
        </ScrollView>

        {/* Special Offers Section */}
        <Typography variant="sectionHeader" color="white" style={styles.sectionTitle}>
          Special Offers
        </Typography>

        <Card style={styles.offerCard} variant="bubble" withShadow>
          <View style={styles.offerCardContent}>
            <View style={styles.offerTextContainer}>
              <Typography variant="subheading" style={styles.offerTitle}>
                20% OFF First Booking
              </Typography>
              <Typography variant="caption" color={colors.textMuted} style={styles.offerDescription}>
                Use code WELCOME20 on your first appointment
              </Typography>
              <TouchableOpacity style={styles.offerButton}>
                <Typography variant="caption" color={colors.primary} style={{fontWeight: '600'}}>
                  Apply Code
                </Typography>
              </TouchableOpacity>
            </View>
            <View style={styles.offerIconContainer}>
              <FontAwesome name="gift" size={36} color={colors.primary} />
            </View>
          </View>
        </Card>

        {/* Action Buttons */}
        <View style={styles.buttonContainer}>
          <Button
            title="Find Nearby Stylists"
            variant="primary"
            size="large"
            iconName="map-marker"
            iconPosition="left"
            style={styles.primaryButton}
            textStyle={styles.buttonText}
            onPress={() => navigation.navigate('StylistListScreen', { serviceId: 1 })}
          />

          <Button
            title="Scan Stylist QR"
            variant="outline"
            size="large"
            iconName="qrcode"
            iconPosition="left"
            style={styles.secondaryButton}
            textStyle={styles.secondaryButtonText}
            onPress={() => navigation.navigate('ServiceSelectScreen')}
          />

          <Button
            title="Browse All Services"
            variant="outline"
            size="large"
            iconName="list"
            iconPosition="left"
            style={styles.secondaryButton}
            textStyle={styles.secondaryButtonText}
            onPress={() => navigation.navigate('ServiceSelectScreen')}
          />
        </View>

        {/* App Info Section */}
        <Card style={styles.infoCard} variant="bubble" withShadow>
          <Typography variant="subheading" style={styles.infoTitle}>
            About ZinApp
          </Typography>
          <Typography variant="body" color={colors.textMuted} style={styles.infoText}>
            ZinApp connects you with top stylists in your area for haircuts, beard trims, braids, and more. Book appointments, track your stylist's arrival, and enjoy premium grooming services on-demand.
          </Typography>
          <View style={styles.infoStats}>
            <View style={styles.statItem}>
              <Typography variant="subheading" color={colors.primary}>500+</Typography>
              <Typography variant="caption" color={colors.textMuted}>Stylists</Typography>
            </View>
            <View style={styles.statItem}>
              <Typography variant="subheading" color={colors.primary}>20k+</Typography>
              <Typography variant="caption" color={colors.textMuted}>Customers</Typography>
            </View>
            <View style={styles.statItem}>
              <Typography variant="subheading" color={colors.primary}>50k+</Typography>
              <Typography variant="caption" color={colors.textMuted}>Bookings</Typography>
            </View>
          </View>
        </Card>
      </View>
    </ImmersiveScreen>
  );
};

const styles = StyleSheet.create({
  heroHeader: {
    height: 140, // Reduced height for better spacing
    borderRadius: 0, // Remove border radius for full-width header
  },
  subtitleContainer: {
    alignItems: 'center',
    paddingVertical: spacing.sm,
    backgroundColor: 'transparent', // Make it transparent to show the coral background
    marginBottom: spacing.sm,
  },
  heroSubtitle: {
    opacity: 0.9,
    textShadowColor: 'rgba(0, 0, 0, 0.2)',
    textShadowOffset: { width: 0, height: 1 },
    textShadowRadius: 2,
  },
  content: {
    padding: spacing.md,
    paddingBottom: spacing.xxxl, // Extra padding at bottom for scrollable content
  },
  welcomeCard: {
    marginBottom: spacing.md,
    padding: spacing.md,
    backgroundColor: colors.cream,
  },
  welcomeTitle: {
    marginBottom: spacing.xs,
  },
  welcomeText: {
    lineHeight: 20,
  },
  sectionTitle: {
    marginBottom: spacing.sm,
    textShadowColor: 'rgba(0, 0, 0, 0.2)',
    textShadowOffset: { width: 0, height: 1 },
    textShadowRadius: 2,
  },
  serviceButtonsContainer: {
    marginBottom: spacing.md,
  },
  serviceScroll: {
    paddingBottom: spacing.sm,
    paddingRight: spacing.md,
    paddingLeft: spacing.xs,
  },
  serviceButton: {
    marginRight: spacing.sm,
  },
  stylistCardsContainer: {
    marginBottom: spacing.md,
  },
  stylistScroll: {
    paddingBottom: spacing.sm,
    paddingRight: spacing.md,
    paddingLeft: spacing.xs,
  },
  stylistCard: {
    width: 120,
    height: 160,
    marginRight: spacing.md,
    padding: spacing.sm,
    backgroundColor: colors.cream,
  },
  stylistCardContent: {
    alignItems: 'center',
    justifyContent: 'center',
    flex: 1,
  },
  stylistAvatar: {
    width: 60,
    height: 60,
    borderRadius: 30,
    backgroundColor: colors.cream,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: spacing.sm,
    borderWidth: 2,
    borderColor: colors.primary,
  },
  stylistName: {
    marginBottom: spacing.xs,
  },
  locationsScroll: {
    paddingBottom: spacing.sm,
    paddingRight: spacing.md,
    paddingLeft: spacing.xs,
  },
  locationCard: {
    width: 140,
    height: 120,
    marginRight: spacing.md,
    padding: spacing.sm,
    backgroundColor: colors.cream,
    alignItems: 'center',
    justifyContent: 'center',
  },
  locationImagePlaceholder: {
    width: 50,
    height: 50,
    borderRadius: 25,
    backgroundColor: 'rgba(244, 128, 93, 0.1)',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: spacing.sm,
  },
  locationName: {
    fontWeight: '600',
    marginBottom: spacing.xs,
  },
  offerCard: {
    marginBottom: spacing.md,
    padding: spacing.md,
    backgroundColor: colors.cream,
  },
  offerCardContent: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  offerTextContainer: {
    flex: 1,
  },
  offerTitle: {
    fontWeight: '600',
    marginBottom: spacing.xs,
  },
  offerDescription: {
    marginBottom: spacing.sm,
  },
  offerButton: {
    alignSelf: 'flex-start',
    paddingVertical: spacing.xs,
    paddingHorizontal: spacing.sm,
    backgroundColor: 'rgba(244, 128, 93, 0.1)',
    borderRadius: 16,
  },
  offerIconContainer: {
    width: 60,
    height: 60,
    borderRadius: 30,
    backgroundColor: 'rgba(244, 128, 93, 0.1)',
    alignItems: 'center',
    justifyContent: 'center',
    marginLeft: spacing.sm,
  },
  buttonContainer: {
    marginTop: spacing.md,
    marginBottom: spacing.md,
  },
  primaryButton: {
    marginBottom: spacing.md,
    backgroundColor: colors.cream, // Change button color for contrast
    borderWidth: 0,
  },
  buttonText: {
    color: colors.primary,
    fontWeight: '600',
  },
  secondaryButton: {
    marginBottom: spacing.md,
    backgroundColor: 'rgba(255, 255, 255, 0.2)', // Semi-transparent background
    borderColor: colors.cream,
    borderWidth: 2,
  },
  secondaryButtonText: {
    color: 'white',
    fontWeight: '600',
  },
  infoCard: {
    marginTop: spacing.md,
    marginBottom: spacing.xl,
    padding: spacing.md,
    backgroundColor: colors.cream,
  },
  infoTitle: {
    fontWeight: '600',
    marginBottom: spacing.xs,
  },
  infoText: {
    lineHeight: 20,
    marginBottom: spacing.md,
  },
  infoStats: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingTop: spacing.sm,
    borderTopWidth: 1,
    borderTopColor: 'rgba(0,0,0,0.05)',
  },
  statItem: {
    alignItems: 'center',
  },
});

export default LandingScreen;
