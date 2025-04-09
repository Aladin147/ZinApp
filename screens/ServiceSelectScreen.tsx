import React, { useState } from 'react';
import { View, ScrollView, StyleSheet, TouchableOpacity, Animated } from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RootStackParamList } from '../types';
import { colors, spacing } from '../constants';
import { FontAwesome } from '@expo/vector-icons';

// Import our custom components
import { ImmersiveScreen, Header, Typography, Button, Card } from '../components';

type ServiceSelectScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'ServiceSelectScreen'
>;

type Props = {
  navigation: ServiceSelectScreenNavigationProp;
};

// Enhanced service data
const serviceCategories = [
  {
    id: 1,
    name: 'Haircuts',
    color: colors.primary,
    icon: 'scissors' as const,
    services: [
      { id: 101, name: 'Classic Cut', price: 50, duration: 30, popular: true },
      { id: 102, name: 'Fade', price: 60, duration: 45 },
      { id: 103, name: 'Buzz Cut', price: 40, duration: 20 },
      { id: 104, name: 'Kids Cut', price: 35, duration: 30 },
    ]
  },
  {
    id: 2,
    name: 'Beard & Facial',
    color: colors.stylistBlue,
    icon: 'user' as const,
    services: [
      { id: 201, name: 'Beard Trim', price: 30, duration: 20, popular: true },
      { id: 202, name: 'Beard Shaping', price: 40, duration: 30 },
      { id: 203, name: 'Hot Towel Shave', price: 45, duration: 30 },
      { id: 204, name: 'Facial', price: 50, duration: 40 },
    ]
  },
  {
    id: 3,
    name: 'Braids & Styling',
    color: colors.success,
    icon: 'paint-brush' as const,
    services: [
      { id: 301, name: 'Box Braids', price: 70, duration: 60, popular: true },
      { id: 302, name: 'Cornrows', price: 65, duration: 50 },
      { id: 303, name: 'Twists', price: 75, duration: 60 },
      { id: 304, name: 'Loc Maintenance', price: 80, duration: 70 },
    ]
  },
  {
    id: 4,
    name: 'Packages',
    color: colors.info,
    icon: 'star' as const,
    services: [
      { id: 401, name: 'Full Service', price: 100, duration: 90, popular: true },
      { id: 402, name: 'Cut & Beard', price: 80, duration: 60 },
      { id: 403, name: 'VIP Package', price: 120, duration: 120 },
      { id: 404, name: 'Group Discount', price: 90, duration: 75 },
    ]
  },
];

const ServiceSelectScreen: React.FC<Props> = ({ navigation }) => {
  const [selectedCategory, setSelectedCategory] = useState(1);
  const [selectedService, setSelectedService] = useState<number | null>(null);

  // Get the current category
  const currentCategory = serviceCategories.find(cat => cat.id === selectedCategory) || serviceCategories[0];

  // Animation value for category change
  const fadeAnim = React.useRef(new Animated.Value(1)).current;

  const handleCategorySelect = (categoryId: number) => {
    // Fade out
    Animated.timing(fadeAnim, {
      toValue: 0,
      duration: 150,
      useNativeDriver: true,
    }).start(() => {
      // Change category
      setSelectedCategory(categoryId);
      setSelectedService(null);

      // Fade in
      Animated.timing(fadeAnim, {
        toValue: 1,
        duration: 300,
        useNativeDriver: true,
      }).start();
    });
  };

  const handleServiceSelect = (serviceId: number) => {
    setSelectedService(serviceId);
  };

  const handleContinue = () => {
    if (selectedService) {
      navigation.navigate('StylistListScreen', { serviceId: selectedCategory });
    }
  };

  return (
    <ImmersiveScreen
      backgroundColor={currentCategory.color}
      statusBarStyle="light-content"
      scrollable={true}
    >
      <Header
        title="Select Service"
        showBackButton
        style={styles.header}
        titleAlign="center"
      />

      {/* Category Tabs */}
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={styles.categoryTabsContainer}
      >
        {serviceCategories.map((category) => (
          <TouchableOpacity
            key={category.id}
            style={[
              styles.categoryTab,
              selectedCategory === category.id && styles.selectedCategoryTab,
              { borderColor: category.color }
            ]}
            onPress={() => handleCategorySelect(category.id)}
            activeOpacity={0.7}
          >
            <FontAwesome
              name={category.icon}
              size={16}
              color={selectedCategory === category.id ? 'white' : category.color}
              style={styles.categoryIcon}
            />
            <Typography
              variant="caption"
              color={selectedCategory === category.id ? 'white' : category.color}
              style={styles.categoryText}
            >
              {category.name}
            </Typography>
          </TouchableOpacity>
        ))}
      </ScrollView>

      {/* Category Description Card */}
      <Card style={styles.categoryCard} variant="bubble" withShadow>
        <View style={styles.categoryCardContent}>
          <View style={[styles.categoryIconLarge, { backgroundColor: `${currentCategory.color}20` }]}>
            <FontAwesome name={currentCategory.icon} size={24} color={currentCategory.color} />
          </View>
          <View style={styles.categoryInfo}>
            <Typography variant="subheading" style={styles.categoryTitle}>
              {currentCategory.name}
            </Typography>
            <Typography variant="caption" color={colors.textMuted}>
              {currentCategory.services.length} services available
            </Typography>
          </View>
        </View>
      </Card>

      {/* Services List */}
      <Animated.View style={[styles.servicesContainer, { opacity: fadeAnim }]}>
        <Typography variant="bodyMedium" color="white" style={styles.servicesTitle}>
          Select a service:
        </Typography>

        {currentCategory.services.map((service) => (
          <TouchableOpacity
            key={service.id}
            activeOpacity={0.8}
            onPress={() => handleServiceSelect(service.id)}
          >
            <Card
              style={{
                ...styles.serviceCard,
                ...(selectedService === service.id ? styles.selectedServiceCard : {})
              }}
              variant="bubble"
              withShadow
            >
              <View style={styles.serviceCardContent}>
                <View style={styles.serviceInfo}>
                  <View style={styles.serviceNameRow}>
                    <Typography variant="bodyMedium" style={styles.serviceName}>
                      {service.name}
                    </Typography>
                    {service.popular && (
                      <View style={styles.popularBadge}>
                        <Typography variant="caption" color="white" style={styles.popularText}>
                          Popular
                        </Typography>
                      </View>
                    )}
                  </View>
                  <View style={styles.serviceDetails}>
                    <View style={styles.serviceDuration}>
                      <FontAwesome name="clock-o" size={14} color={colors.textMuted as string} />
                      <Typography variant="caption" color={colors.textMuted} style={styles.durationText}>
                        {service.duration} min
                      </Typography>
                    </View>
                    <Typography variant="bodyMedium" color={currentCategory.color} style={styles.servicePrice}>
                      ${service.price}
                    </Typography>
                  </View>
                </View>
                <View style={{
                  ...styles.serviceCheckbox,
                  ...(selectedService === service.id ? { backgroundColor: currentCategory.color } : {})
                }}>
                  {selectedService === service.id && (
                    <FontAwesome name="check" size={14} color="white" />
                  )}
                </View>
              </View>
            </Card>
          </TouchableOpacity>
        ))}
      </Animated.View>

      {/* Continue Button */}
      <View style={styles.buttonContainer}>
        <Button
          title="Continue to Stylists"
          variant="primary"
          size="large"
          iconName="arrow-right"
          iconPosition="right"
          style={{ ...styles.continueButton, backgroundColor: colors.cream }}
          textStyle={{ color: currentCategory.color, fontWeight: '600' }}
          disabled={!selectedService}
          onPress={handleContinue}
        />
      </View>
    </ImmersiveScreen>
  );
};

const styles = StyleSheet.create({
  header: {
    backgroundColor: 'transparent',
  },
  categoryTabsContainer: {
    paddingHorizontal: spacing.md,
    paddingBottom: spacing.sm,
  },
  categoryTab: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: 'rgba(255, 255, 255, 0.9)',
    paddingVertical: spacing.xs,
    paddingHorizontal: spacing.sm,
    borderRadius: 20,
    marginRight: spacing.sm,
    borderWidth: 2,
    borderColor: 'transparent',
  },
  selectedCategoryTab: {
    backgroundColor: 'transparent',
    borderWidth: 2,
  },
  categoryIcon: {
    marginRight: spacing.xs,
  },
  categoryText: {
    fontWeight: '600',
  },
  categoryCard: {
    marginHorizontal: spacing.md,
    marginBottom: spacing.md,
    padding: spacing.md,
    backgroundColor: colors.cream,
  },
  categoryCardContent: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  categoryIconLarge: {
    width: 50,
    height: 50,
    borderRadius: 25,
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: spacing.md,
  },
  categoryInfo: {
    flex: 1,
  },
  categoryTitle: {
    fontWeight: '600',
    marginBottom: spacing.xs,
  },
  servicesContainer: {
    paddingHorizontal: spacing.md,
    marginBottom: spacing.md,
  },
  servicesTitle: {
    marginBottom: spacing.sm,
    textShadowColor: 'rgba(0, 0, 0, 0.2)',
    textShadowOffset: { width: 0, height: 1 },
    textShadowRadius: 2,
  },
  serviceCard: {
    marginBottom: spacing.sm,
    padding: spacing.md,
    backgroundColor: colors.cream,
  },
  selectedServiceCard: {
    borderWidth: 2,
    borderColor: 'rgba(255, 255, 255, 0.5)',
  },
  serviceCardContent: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  serviceInfo: {
    flex: 1,
  },
  serviceNameRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: spacing.xs,
  },
  serviceName: {
    fontWeight: '600',
    marginRight: spacing.xs,
  },
  popularBadge: {
    backgroundColor: colors.primary,
    paddingHorizontal: spacing.xs,
    paddingVertical: 2,
    borderRadius: 10,
  },
  popularText: {
    fontSize: 10,
    fontWeight: '600',
  },
  serviceDetails: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  serviceDuration: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  durationText: {
    marginLeft: spacing.xs,
  },
  servicePrice: {
    fontWeight: '600',
  },
  serviceCheckbox: {
    width: 24,
    height: 24,
    borderRadius: 12,
    borderWidth: 2,
    borderColor: 'rgba(0, 0, 0, 0.1)',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'transparent',
  },
  buttonContainer: {
    paddingHorizontal: spacing.md,
    marginBottom: spacing.xl,
  },
  continueButton: {
    borderWidth: 0,
  },
});

export default ServiceSelectScreen;
