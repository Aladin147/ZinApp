import React, { useEffect } from 'react';
import { View, StyleSheet, TouchableOpacity, Animated } from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RootStackParamList } from '../types';
import { colors, spacing, themeColors } from '@constants'; // Use alias
import { FontAwesome } from '@expo/vector-icons';
import { LinearGradient } from 'expo-linear-gradient';
// import { MotiView } from 'moti'; // Comment out Moti

// Import our custom components
import { Screen, Typography, Button, Card } from '../components';

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
    <Screen>
      {/* Hero Section with Background */}
      <View style={styles.heroContainer}>
        <LinearGradient
          colors={[colors.primary, '#FF8F66']}
          style={styles.gradient}
          start={{ x: 0, y: 0 }}
          end={{ x: 1, y: 1 }}
        >
          <Animated.View style={[styles.heroContent, { opacity: fadeAnim }]}>
            {/* <MotiView
              from={{ scale: 0.8, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              transition={{ type: 'timing', duration: 1000 }}
              style={[styles.logo, { backgroundColor: 'rgba(255,255,255,0.2)', borderRadius: 40 }]}
            > */}
            <View style={[styles.logo, { backgroundColor: 'rgba(255,255,255,0.2)', borderRadius: 40 }]}>
              <FontAwesome name="scissors" size={32} color="white" />
            {/* </MotiView> */}
            </View>
            <Typography variant="screenTitle" color={colors.bgLight} style={styles.heroTitle}>
              ZinApp
            </Typography>
            <Typography variant="body" color={colors.bgLight} style={styles.heroSubtitle}>
              Premium Grooming On-Demand
            </Typography>
          </Animated.View>
        </LinearGradient>
      </View>

      {/* Main Content */}
      <View style={styles.content}>
        {/* Welcome Card */}
        {/* <MotiView
          from={{ opacity: 0, translateY: 20 }}
          animate={{ opacity: 1, translateY: 0 }}
          transition={{ type: 'timing', duration: 800, delay: 300 }}
        > */}
          <Card style={styles.welcomeCard}>
            <Typography variant="sectionHeader" style={styles.welcomeTitle}>
              Welcome to ZinApp
            </Typography>
            <Typography variant="body" color={colors.textMuted} style={styles.welcomeText}>
              Book haircuts, beard trims, braids, or full services in seconds. Discover stylists by proximity, rating, and portfolio.
            </Typography>
          </Card>
        {/* </MotiView> */}

        {/* Service Selection */}
        {/* <MotiView
          from={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ type: 'timing', duration: 800, delay: 500 }}
        > */}
          <Typography variant="sectionHeader" style={styles.sectionTitle}>
            What do you need today?
          </Typography>
        {/* </MotiView> */}

        <View style={styles.serviceGrid}>
          {serviceOptions.map((service, index) => (
            // <MotiView
            //   key={service.id}
            //   from={{ opacity: 0, scale: 0.9, translateY: 20 }}
            //   animate={{ opacity: 1, scale: 1, translateY: 0 }}
            //   transition={{ type: 'timing', duration: 600, delay: 600 + (index * 100) }}
            // >
              <TouchableOpacity
                key={service.id} // Add key here since MotiView is removed
                style={styles.serviceCard}
                onPress={() => navigation.navigate('StylistListScreen', { serviceId: service.id })}
                activeOpacity={0.7}
              >
                <View style={[styles.iconContainer, { backgroundColor: service.color }]}>
                  <FontAwesome name={service.icon} size={24} color="white" />
                </View>
                <Typography variant="bodyMedium" style={styles.serviceName}>
                  {service.name}
                </Typography>
              </TouchableOpacity>
            // </MotiView>
          ))}
        </View>

        {/* Action Buttons */}
        {/* <MotiView
          from={{ opacity: 0, translateY: 30 }}
          animate={{ opacity: 1, translateY: 0 }}
          transition={{ type: 'timing', duration: 800, delay: 1000 }}
          style={styles.buttonContainer}
        > */}
        <View style={styles.buttonContainer}>
          <Button
            title="Find Nearby Stylists"
            variant="primary"
            size="large"
            iconName="map-marker"
            iconPosition="left"
            style={styles.primaryButton}
            onPress={() => navigation.navigate('StylistListScreen', { serviceId: 1 })}
          />

          <Button
            title="Scan Stylist QR"
            variant="outline"
            size="large"
            iconName="qrcode"
            iconPosition="left"
            style={styles.secondaryButton}
            onPress={() => navigation.navigate('ServiceSelectScreen')}
          />
        {/* </MotiView> */}
        </View>
      </View>
    </Screen>
  );
};

const styles = StyleSheet.create({
  heroContainer: {
    height: 220,
    width: '100%',
  },
  gradient: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  heroContent: {
    alignItems: 'center',
    paddingHorizontal: spacing.md,
  },
  logo: {
    width: 80,
    height: 80,
    marginBottom: spacing.sm,
    justifyContent: 'center',
    alignItems: 'center',
  },
  heroTitle: {
    marginBottom: spacing.xxs,
  },
  heroSubtitle: {
    opacity: 0.9,
  },
  content: {
    flex: 1,
    padding: spacing.md,
    marginTop: -20,
  },
  welcomeCard: {
    marginBottom: spacing.lg,
    padding: spacing.md,
    borderRadius: 16,
    backgroundColor: colors.bgLight,
    shadowColor: themeColors.shadow,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  welcomeTitle: {
    marginBottom: spacing.xs,
  },
  welcomeText: {
    lineHeight: 20,
  },
  sectionTitle: {
    marginBottom: spacing.md,
  },
  serviceGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
    marginBottom: spacing.xl,
  },
  serviceCard: {
    width: '48%',
    backgroundColor: colors.bgLight,
    borderRadius: 24, // More rounded corners like Glovo
    padding: spacing.md,
    marginBottom: spacing.md,
    alignItems: 'center',
    shadowColor: themeColors.shadow,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.15,
    shadowRadius: 8,
    elevation: 3,
    borderWidth: 1,
    borderColor: colors.gray100,
  },
  iconContainer: {
    width: 56,
    height: 56,
    borderRadius: 28, // Fully rounded like Glovo
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: spacing.sm,
    shadowColor: 'rgba(0,0,0,0.2)',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 3,
    elevation: 3,
  },
  serviceName: {
    marginTop: spacing.xs,
  },
  buttonContainer: {
    marginTop: spacing.md,
  },
  primaryButton: {
    marginBottom: spacing.md,
  },
  secondaryButton: {
    marginBottom: spacing.md,
  },
});

export default LandingScreen;
