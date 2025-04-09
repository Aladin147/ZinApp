import React from 'react';
import { View, StyleSheet, TouchableOpacity } from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RootStackParamList } from '../types';
import { colors, spacing, themeColors } from '../constants';
import { FontAwesome } from '@expo/vector-icons';
import { LinearGradient } from 'expo-linear-gradient';

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
  // Service options with their icons and colors
  const serviceOptions = [
    { id: 1, name: 'Haircut', icon: 'scissors' as const, color: colors.primary },
    { id: 2, name: 'Beard Trim', icon: 'user' as const, color: colors.accent },
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
          <View style={styles.heroContent}>
            <View style={[styles.logo, { backgroundColor: 'rgba(255,255,255,0.2)', borderRadius: 40 }]}>
              <FontAwesome name="scissors" size={32} color="white" />
            </View>
            <Typography variant="screenTitle" color={colors.bgLight} style={styles.heroTitle}>
              ZinApp
            </Typography>
            <Typography variant="body" color={colors.bgLight} style={styles.heroSubtitle}>
              Premium Grooming On-Demand
            </Typography>
          </View>
        </LinearGradient>
      </View>

      {/* Main Content */}
      <View style={styles.content}>
        {/* Welcome Card */}
        <Card style={styles.welcomeCard}>
          <Typography variant="sectionHeader" style={styles.welcomeTitle}>
            Welcome to ZinApp
          </Typography>
          <Typography variant="body" color={colors.textMuted} style={styles.welcomeText}>
            Book haircuts, beard trims, braids, or full services in seconds. Discover stylists by proximity, rating, and portfolio.
          </Typography>
        </Card>

        {/* Service Selection */}
        <Typography variant="sectionHeader" style={styles.sectionTitle}>
          What do you need today?
        </Typography>
        
        <View style={styles.serviceGrid}>
          {serviceOptions.map((service) => (
            <TouchableOpacity
              key={service.id}
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
          ))}
        </View>

        {/* Action Buttons */}
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
    borderRadius: 16,
    padding: spacing.md,
    marginBottom: spacing.md,
    alignItems: 'center',
    shadowColor: themeColors.shadow,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
    borderWidth: 1,
    borderColor: colors.gray100,
  },
  iconContainer: {
    width: 48,
    height: 48,
    borderRadius: 24,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: spacing.sm,
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
