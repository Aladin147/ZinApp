import React, { useEffect } from 'react';
import { View, ScrollView, StyleSheet, Image, TouchableOpacity, Animated } from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '../types';
import { colors, spacing } from '../constants';
import { FontAwesome } from '@expo/vector-icons';
import { MotiView, MotiImage } from 'moti';
import { useAnimation } from '../hooks';

// Import our custom components
import { Typography, Button, Card, Avatar, RatingStars } from '../components';

type BarberProfileScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'BarberProfileScreen'
>;
type BarberProfileScreenRouteProp = RouteProp<
  RootStackParamList,
  'BarberProfileScreen'
>;

type Props = {
  navigation: BarberProfileScreenNavigationProp;
  route: BarberProfileScreenRouteProp;
};

const BarberProfileScreen: React.FC<Props> = ({ navigation, route }) => {
  const stylistId = route.params?.stylistId;
  const isQrSource = route.params?.qrSource;

  // Animation values
  const headerAnim = useAnimation(0, 'fadeIn');
  const profileAnim = useAnimation(0, 'slideUp');
  const contentAnim = useAnimation(0, 'fadeIn');

  // Mock stylist data - would be fetched from API in a real app
  const stylist = {
    id: stylistId,
    name: 'James Wilson',
    title: 'Master Barber',
    rating: 4.8,
    reviewCount: 127,
    bio: 'Specializing in modern cuts, fades, and beard styling with over 8 years of experience. Certified master barber with a passion for precision and client satisfaction.',
    location: 'Downtown Barbershop, 2.3 miles away',
    verified: true,
    profileImage: { uri: 'https://randomuser.me/api/portraits/men/32.jpg' },
    gallery: [
      { uri: 'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60' },
      { uri: 'https://images.unsplash.com/photo-1521322714240-ee1d383eab62?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60' },
      { uri: 'https://images.unsplash.com/photo-1519345182560-3f2917c472ef?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60' },
    ],
    services: [
      { id: 1, name: 'Haircut', price: 35, duration: '30 min' },
      { id: 2, name: 'Beard Trim', price: 25, duration: '20 min' },
      { id: 3, name: 'Full Service', price: 55, duration: '45 min' },
    ],
    availability: ['Today', 'Tomorrow', 'Friday'],
  };

  // Start animations when component mounts
  useEffect(() => {
    // Start header animation
    headerAnim.startAnimation();

    // Start profile animation after a delay
    setTimeout(() => {
      profileAnim.startAnimation();
    }, 300);

    // Start content animation after a delay
    setTimeout(() => {
      contentAnim.startAnimation();
    }, 600);
  }, []);

  return (
    <ScrollView style={styles.container} showsVerticalScrollIndicator={false}>
      {/* Header Section with Profile Image */}
      <Animated.View
        style={[styles.header, { opacity: headerAnim.animatedValue }]}
      >
        <MotiImage
          source={stylist.profileImage}
          style={styles.coverImage}
          from={{ opacity: 0.3, scale: 1.1 }}
          animate={{ opacity: 0.7, scale: 1 }}
          transition={{ type: 'timing', duration: 1000 }}
        />

        <Animated.View
          style={[styles.profileContainer, {
            transform: [{
              translateY: profileAnim.animatedValue.interpolate({
                inputRange: [0, 1],
                outputRange: [50, 0]
              })
            }],
            opacity: profileAnim.animatedValue
          }]}
        >
          <MotiView
            from={{ scale: 0.8, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ type: 'spring', delay: 500, damping: 15 }}
          >
            <Avatar
              source={stylist.profileImage}
              size="large"
              verified={stylist.verified}
              style={styles.profileImage}
            />
          </MotiView>

          <View style={styles.nameContainer}>
            <MotiView
              from={{ opacity: 0, translateX: 20 }}
              animate={{ opacity: 1, translateX: 0 }}
              transition={{ type: 'timing', duration: 600, delay: 700 }}
            >
              <Typography variant="heading">
                {stylist.name}
              </Typography>
            </MotiView>

            <MotiView
              from={{ opacity: 0, translateX: 20 }}
              animate={{ opacity: 1, translateX: 0 }}
              transition={{ type: 'timing', duration: 600, delay: 800 }}
            >
              <Typography variant="bodyMedium" color={colors.textMuted}>
                {stylist.title}
              </Typography>
            </MotiView>

            <MotiView
              from={{ opacity: 0, translateX: 20 }}
              animate={{ opacity: 1, translateX: 0 }}
              transition={{ type: 'timing', duration: 600, delay: 900 }}
              style={styles.ratingContainer}
            >
              <RatingStars rating={stylist.rating} size={16} />
              <Typography variant="body" color={colors.textMuted} style={styles.reviewCount}>
                ({stylist.reviewCount} reviews)
              </Typography>
            </MotiView>
          </View>
        </Animated.View>

        {isQrSource && (
          <MotiView
            from={{ opacity: 0, scale: 0.5, translateY: -10 }}
            animate={{ opacity: 1, scale: 1, translateY: 0 }}
            transition={{ type: 'spring', delay: 1000, damping: 12 }}
            style={styles.qrBadge}
          >
            <Typography variant="captionMedium" color={colors.bgLight}>
              Scanned via QR
            </Typography>
          </MotiView>
        )}
      </Animated.View>

      {/* Content Section */}
      <Animated.View style={[styles.content, {
        opacity: contentAnim.animatedValue,
        transform: [{
          translateY: contentAnim.animatedValue.interpolate({
            inputRange: [0, 1],
            outputRange: [20, 0]
          })
        }]
      }]}>
        {/* About Section */}
        <Card style={styles.section}>
          <Typography variant="sectionHeader" style={styles.sectionTitle}>
            About
          </Typography>

          <Typography variant="body" style={styles.bio}>
            {stylist.bio}
          </Typography>

          <View style={styles.locationContainer}>
            <FontAwesome name="map-marker" size={16} color={colors.primary} style={styles.locationIcon} />
            <Typography variant="body" color={colors.textMuted}>
              {stylist.location}
            </Typography>
          </View>
        </Card>

        {/* Gallery Section */}
        <Card style={styles.section}>
          <Typography variant="sectionHeader" style={styles.sectionTitle}>
            Gallery
          </Typography>

          <ScrollView horizontal showsHorizontalScrollIndicator={false} style={styles.galleryContainer}>
            {stylist.gallery.map((image, index) => (
              <MotiView
                key={index}
                from={{ opacity: 0, scale: 0.9, translateX: 20 }}
                animate={{ opacity: 1, scale: 1, translateX: 0 }}
                transition={{ type: 'timing', duration: 600, delay: 1000 + (index * 200) }}
              >
                <Image source={image} style={styles.galleryImage} />
              </MotiView>
            ))}
          </ScrollView>
        </Card>

        {/* Services Section */}
        <Card style={styles.section}>
          <Typography variant="sectionHeader" style={styles.sectionTitle}>
            Services
          </Typography>

          {stylist.services.map((service, index) => (
            <MotiView
              key={service.id}
              from={{ opacity: 0, translateY: 10 }}
              animate={{ opacity: 1, translateY: 0 }}
              transition={{ type: 'timing', duration: 400, delay: 1200 + (index * 150) }}
              style={styles.serviceItem}
            >
              <View>
                <Typography variant="bodyMedium">
                  {service.name}
                </Typography>
                <Typography variant="caption" color={colors.textMuted}>
                  {service.duration}
                </Typography>
              </View>

              <Typography variant="bodyBold" color={colors.primary}>
                ${service.price}
              </Typography>
            </MotiView>
          ))}
        </Card>

        {/* Availability Section */}
        <Card style={styles.section}>
          <Typography variant="sectionHeader" style={styles.sectionTitle}>
            Availability
          </Typography>

          <View style={styles.availabilityContainer}>
            {stylist.availability.map((day, index) => (
              <MotiView
                key={index}
                from={{ opacity: 0, scale: 0.8 }}
                animate={{ opacity: 1, scale: 1 }}
                transition={{ type: 'spring', delay: 1500 + (index * 150), damping: 12 }}
              >
                <TouchableOpacity style={styles.availabilityItem}>
                  <Typography variant="bodyMedium">
                    {day}
                  </Typography>
                </TouchableOpacity>
              </MotiView>
            ))}
          </View>
        </Card>

        {/* Booking Button */}
        <MotiView
          from={{ opacity: 0, translateY: 20, scale: 0.95 }}
          animate={{ opacity: 1, translateY: 0, scale: 1 }}
          transition={{ type: 'spring', delay: 1800, damping: 12 }}
        >
          <Button
            title="Book Appointment"
            variant="primary"
            size="large"
            style={styles.bookButton}
            onPress={() => navigation.navigate('BookingScreen', { stylistId: stylist.id, serviceId: 1 })}
          />
        </MotiView>
      </Animated.View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.bgLight,
  },
  header: {
    position: 'relative',
    backgroundColor: colors.warmSand,
  },
  coverImage: {
    width: '100%',
    height: 150,
    opacity: 0.7,
  },
  profileContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: spacing.md,
    marginTop: -50,
  },
  profileImage: {
    borderWidth: 3,
    borderColor: colors.bgLight,
  },
  nameContainer: {
    marginLeft: spacing.md,
  },
  ratingContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: spacing.xs,
  },
  reviewCount: {
    marginLeft: spacing.xs,
  },
  qrBadge: {
    position: 'absolute',
    top: spacing.md,
    right: spacing.md,
    backgroundColor: colors.accent1, // Glovo-like yellow accent
    paddingHorizontal: spacing.sm,
    paddingVertical: spacing.xxs,
    borderRadius: 20, // More rounded like Glovo
    shadowColor: 'rgba(0,0,0,0.2)',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 3,
    elevation: 3,
  },
  content: {
    padding: spacing.md,
  },
  section: {
    marginBottom: spacing.md,
    padding: spacing.md,
    borderRadius: 16,
  },
  sectionTitle: {
    marginBottom: spacing.sm,
  },
  bio: {
    marginBottom: spacing.sm,
  },
  locationContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  locationIcon: {
    marginRight: spacing.xs,
  },
  galleryContainer: {
    marginTop: spacing.sm,
  },
  galleryImage: {
    width: 120,
    height: 120,
    borderRadius: 16, // More rounded like Glovo
    marginRight: spacing.sm,
    shadowColor: 'rgba(0,0,0,0.1)',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 3,
    elevation: 2,
  },
  serviceItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: spacing.sm,
    borderBottomWidth: 1,
    borderBottomColor: colors.gray100,
  },
  availabilityContainer: {
    flexDirection: 'row',
    marginTop: spacing.sm,
  },
  availabilityItem: {
    backgroundColor: colors.gray100,
    paddingHorizontal: spacing.md,
    paddingVertical: spacing.sm,
    borderRadius: 20, // More rounded like Glovo
    marginRight: spacing.sm,
    shadowColor: 'rgba(0,0,0,0.05)',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.2,
    shadowRadius: 2,
    elevation: 1,
  },
  bookButton: {
    marginTop: spacing.lg,
    marginBottom: spacing.xl,
  },
});

export default BarberProfileScreen;
