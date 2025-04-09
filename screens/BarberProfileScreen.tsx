import React from 'react';
import { View, ScrollView, StyleSheet, Image, TouchableOpacity } from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '../types';
import { colors, spacing } from '../constants';
import { FontAwesome } from '@expo/vector-icons';

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

  return (
    <ScrollView style={styles.container} showsVerticalScrollIndicator={false}>
      {/* Header Section with Profile Image */}
      <View style={styles.header}>
        <Image source={stylist.profileImage} style={styles.coverImage} />

        <View style={styles.profileContainer}>
          <Avatar
            source={stylist.profileImage}
            size="large"
            verified={stylist.verified}
            style={styles.profileImage}
          />

          <View style={styles.nameContainer}>
            <Typography variant="heading">
              {stylist.name}
            </Typography>

            <Typography variant="bodyMedium" color={colors.textMuted}>
              {stylist.title}
            </Typography>

            <View style={styles.ratingContainer}>
              <RatingStars rating={stylist.rating} size={16} />
              <Typography variant="body" color={colors.textMuted} style={styles.reviewCount}>
                ({stylist.reviewCount} reviews)
              </Typography>
            </View>
          </View>
        </View>

        {isQrSource && (
          <View style={styles.qrBadge}>
            <Typography variant="captionMedium" color={colors.bgLight}>
              Scanned via QR
            </Typography>
          </View>
        )}
      </View>

      {/* Content Section */}
      <View style={styles.content}>
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
              <Image key={index} source={image} style={styles.galleryImage} />
            ))}
          </ScrollView>
        </Card>

        {/* Services Section */}
        <Card style={styles.section}>
          <Typography variant="sectionHeader" style={styles.sectionTitle}>
            Services
          </Typography>

          {stylist.services.map((service) => (
            <View key={service.id} style={styles.serviceItem}>
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
            </View>
          ))}
        </Card>

        {/* Availability Section */}
        <Card style={styles.section}>
          <Typography variant="sectionHeader" style={styles.sectionTitle}>
            Availability
          </Typography>

          <View style={styles.availabilityContainer}>
            {stylist.availability.map((day, index) => (
              <TouchableOpacity key={index} style={styles.availabilityItem}>
                <Typography variant="bodyMedium">
                  {day}
                </Typography>
              </TouchableOpacity>
            ))}
          </View>
        </Card>

        {/* Booking Button */}
        <Button
          title="Book Appointment"
          variant="primary"
          size="large"
          style={styles.bookButton}
          onPress={() => navigation.navigate('BookingScreen', { stylistId: stylist.id, serviceId: 1 })}
        />
      </View>
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
    backgroundColor: colors.accent,
    paddingHorizontal: spacing.sm,
    paddingVertical: spacing.xxs,
    borderRadius: 16,
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
    borderRadius: 8,
    marginRight: spacing.sm,
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
    borderRadius: 8,
    marginRight: spacing.sm,
  },
  bookButton: {
    marginTop: spacing.lg,
    marginBottom: spacing.xl,
  },
});

export default BarberProfileScreen;
