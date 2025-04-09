import React, { useEffect, useState } from 'react';
import { View, ScrollView, StyleSheet, Image, TouchableOpacity, Animated, ImageBackground } from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '../types';
import { colors, spacing } from '../constants';
import { FontAwesome } from '@expo/vector-icons';
import { LinearGradient } from 'expo-linear-gradient';
import { useAnimation } from '../hooks';

// Import our custom components
import { Typography, Button, Card, Avatar, RatingStars, ImmersiveScreen } from '../components';

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
      { id: 1, name: 'Haircut', price: 35, duration: '30 min', popular: true },
      { id: 2, name: 'Beard Trim', price: 25, duration: '20 min' },
      { id: 3, name: 'Full Service', price: 55, duration: '45 min', popular: true },
      { id: 4, name: 'Kids Cut', price: 20, duration: '20 min' },
      { id: 5, name: 'Hot Towel Shave', price: 30, duration: '25 min' },
    ],
    availability: [
      { day: 'Today', slots: ['10:00 AM', '2:30 PM', '4:15 PM'] },
      { day: 'Tomorrow', slots: ['9:30 AM', '11:45 AM', '3:00 PM', '5:30 PM'] },
      { day: 'Friday', slots: ['10:15 AM', '1:00 PM', '4:45 PM'] },
    ],
    specialties: ['Fades', 'Beard Styling', 'Hot Towel Shaves', 'Kids Cuts'],
    languages: ['English', 'Spanish'],
  };
  
  // State for selected availability day
  const [selectedDay, setSelectedDay] = useState<number>(0);
  
  // State for selected time slot
  const [selectedTimeSlot, setSelectedTimeSlot] = useState<string | null>(null);

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
    <ImmersiveScreen backgroundColor={colors.stylistBlue} statusBarStyle="light-content" scrollable={true}>
      {/* Header Section with Profile Image */}
      <Animated.View
        style={[styles.header, { opacity: headerAnim.animatedValue }]}
      >
        <ImageBackground source={stylist.profileImage} style={styles.coverImage}>
          <LinearGradient
            colors={['rgba(0,0,0,0.1)', 'rgba(140, 186, 205, 0.9)']}
            style={styles.gradient}
          >
            {/* Back button */}
            <TouchableOpacity
              style={styles.backButton}
              onPress={() => navigation.goBack()}
              activeOpacity={0.7}
            >
              <FontAwesome name="arrow-left" size={18} color="white" />
            </TouchableOpacity>
            
            {/* QR Badge */}
            {isQrSource && (
              <View style={styles.qrBadge}>
                <FontAwesome name="qrcode" size={14} color="white" style={styles.qrIcon} />
                <Typography variant="captionMedium" color="white">
                  Scanned via QR
                </Typography>
              </View>
            )}
          </LinearGradient>
        </ImageBackground>

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
          <View style={styles.profileImageContainer}>
            <Avatar
              source={stylist.profileImage}
              size="large"
              verified={stylist.verified}
              style={styles.profileImage}
            />
            
            {/* Specialties badges */}
            <View style={styles.specialtiesBadges}>
              {stylist.specialties.slice(0, 2).map((specialty, index) => (
                <View key={index} style={styles.specialtyBadge}>
                  <Typography variant="caption" color="white" style={styles.specialtyText}>
                    {specialty}
                  </Typography>
                </View>
              ))}
              {stylist.specialties.length > 2 && (
                <View style={styles.specialtyBadge}>
                  <Typography variant="caption" color="white" style={styles.specialtyText}>
                    +{stylist.specialties.length - 2}
                  </Typography>
                </View>
              )}
            </View>
          </View>

          <View style={styles.nameContainer}>
            <Typography variant="heading" color="white" style={styles.stylistName}>
              {stylist.name}
            </Typography>

            <Typography variant="bodyMedium" color="white" style={{opacity: 0.9}}>
              {stylist.title}
            </Typography>

            <View style={styles.ratingContainer}>
              <RatingStars rating={stylist.rating} size={16} />
              <Typography variant="body" color="white" style={{marginLeft: spacing.xs, opacity: 0.9}}>
                ({stylist.reviewCount} reviews)
              </Typography>
            </View>
            
            <View style={styles.locationContainer}>
              <FontAwesome name="map-marker" size={14} color="white" style={styles.locationIcon} />
              <Typography variant="caption" color="white" style={{opacity: 0.9}}>
                {stylist.location}
              </Typography>
            </View>
          </View>
        </Animated.View>
        
        {/* Quick action buttons */}
        <View style={styles.quickActions}>
          <TouchableOpacity style={styles.actionButton}>
            <FontAwesome name="phone" size={18} color={colors.stylistBlue} />
            <Typography variant="caption" style={styles.actionText}>Call</Typography>
          </TouchableOpacity>
          
          <TouchableOpacity style={styles.actionButton}>
            <FontAwesome name="share-alt" size={18} color={colors.stylistBlue} />
            <Typography variant="caption" style={styles.actionText}>Share</Typography>
          </TouchableOpacity>
          
          <TouchableOpacity style={styles.actionButton}>
            <FontAwesome name="heart-o" size={18} color={colors.stylistBlue} />
            <Typography variant="caption" style={styles.actionText}>Save</Typography>
          </TouchableOpacity>
        </View>
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
        <Card style={styles.section} variant="bubble" withShadow>
          <Typography variant="sectionHeader" style={styles.sectionTitle}>
            About
          </Typography>

          <Typography variant="body" style={styles.bio}>
            {stylist.bio}
          </Typography>
          
          <View style={styles.languagesContainer}>
            {stylist.languages.map((language, index) => (
              <View key={index} style={styles.languageBadge}>
                <Typography variant="caption" color={colors.stylistBlue}>
                  {language}
                </Typography>
              </View>
            ))}
          </View>
        </Card>

        {/* Gallery Section */}
        <Card style={styles.section} variant="bubble" withShadow>
          <View style={styles.sectionHeader}>
            <Typography variant="sectionHeader" style={styles.sectionTitle}>
              Gallery
            </Typography>
            <TouchableOpacity style={styles.viewAllButton}>
              <Typography variant="caption" color={colors.stylistBlue}>
                View All
              </Typography>
            </TouchableOpacity>
          </View>

          <ScrollView horizontal showsHorizontalScrollIndicator={false} style={styles.galleryContainer}>
            {stylist.gallery.map((image, index) => (
              <TouchableOpacity key={index} activeOpacity={0.9}>
                <Image source={image} style={styles.galleryImage} />
              </TouchableOpacity>
            ))}
          </ScrollView>
        </Card>

        {/* Services Section */}
        <Card style={styles.section} variant="bubble" withShadow>
          <Typography variant="sectionHeader" style={styles.sectionTitle}>
            Services
          </Typography>

          {stylist.services.map((service) => (
            <View key={service.id} style={styles.serviceItem}>
              <View style={styles.serviceInfo}>
                <View style={styles.serviceNameRow}>
                  <Typography variant="bodyMedium" style={styles.serviceName}>
                    {service.name}
                  </Typography>
                  {service.popular && (
                    <View style={styles.popularTag}>
                      <Typography variant="caption" color="white" style={styles.popularTagText}>
                        Popular
                      </Typography>
                    </View>
                  )}
                </View>
                <Typography variant="caption" color={colors.textMuted}>
                  {service.duration}
                </Typography>
              </View>

              <Typography variant="bodyBold" color={colors.stylistBlue} style={styles.servicePrice}>
                ${service.price}
              </Typography>
            </View>
          ))}
        </Card>

        {/* Availability Section */}
        <Card style={styles.section} variant="bubble" withShadow>
          <Typography variant="sectionHeader" style={styles.sectionTitle}>
            Availability
          </Typography>

          {/* Day tabs */}
          <View style={styles.dayTabsContainer}>
            {stylist.availability.map((dayData, index) => (
              <TouchableOpacity 
                key={index} 
                style={[styles.dayTab, selectedDay === index && styles.selectedDayTab]}
                onPress={() => setSelectedDay(index)}
              >
                <Typography 
                  variant="bodyMedium" 
                  color={selectedDay === index ? 'white' : colors.textMuted}
                >
                  {dayData.day}
                </Typography>
              </TouchableOpacity>
            ))}
          </View>
          
          {/* Time slots */}
          <View style={styles.timeSlotsContainer}>
            {stylist.availability[selectedDay].slots.map((slot, index) => (
              <TouchableOpacity 
                key={index} 
                style={[styles.timeSlot, selectedTimeSlot === slot && styles.selectedTimeSlot]}
                onPress={() => setSelectedTimeSlot(slot)}
              >
                <Typography 
                  variant="caption" 
                  color={selectedTimeSlot === slot ? colors.stylistBlue : colors.textMuted}
                >
                  {slot}
                </Typography>
              </TouchableOpacity>
            ))}
          </View>
        </Card>

        {/* Booking Button */}
        <View style={styles.bookingButtonContainer}>
          <Button
            title="Book Appointment"
            variant="primary"
            size="large"
            iconName="calendar"
            iconPosition="left"
            style={styles.bookButton}
            onPress={() => navigation.navigate('BookingScreen', { stylistId: stylist.id, serviceId: 1 })}
          />
        </View>
      </Animated.View>
    </ImmersiveScreen>
  );
};

const styles = StyleSheet.create({
  header: {
    position: 'relative',
  },
  coverImage: {
    width: '100%',
    height: 220,
  },
  gradient: {
    width: '100%',
    height: '100%',
    justifyContent: 'space-between',
    padding: spacing.md,
  },
  backButton: {
    width: 36,
    height: 36,
    borderRadius: 18,
    backgroundColor: 'rgba(0,0,0,0.3)',
    alignItems: 'center',
    justifyContent: 'center',
    marginTop: spacing.sm,
  },
  profileContainer: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    padding: spacing.md,
    marginTop: -60,
  },
  profileImageContainer: {
    alignItems: 'center',
  },
  profileImage: {
    borderWidth: 3,
    borderColor: 'white',
    shadowColor: 'rgba(0,0,0,0.3)',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 5,
    elevation: 5,
  },
  specialtiesBadges: {
    flexDirection: 'row',
    marginTop: spacing.xs,
    justifyContent: 'center',
  },
  specialtyBadge: {
    backgroundColor: 'rgba(255,255,255,0.2)',
    paddingHorizontal: spacing.xs,
    paddingVertical: 2,
    borderRadius: 10,
    marginHorizontal: 2,
  },
  specialtyText: {
    fontSize: 10,
    fontWeight: '600',
  },
  nameContainer: {
    marginLeft: spacing.md,
    flex: 1,
  },
  stylistName: {
    textShadowColor: 'rgba(0,0,0,0.2)',
    textShadowOffset: { width: 0, height: 1 },
    textShadowRadius: 2,
  },
  ratingContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: spacing.xs,
  },
  reviewCount: {
    marginLeft: spacing.xs,
  },
  locationContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: spacing.xs,
  },
  locationIcon: {
    marginRight: spacing.xs,
  },
  qrBadge: {
    position: 'absolute',
    top: spacing.md,
    right: spacing.md,
    backgroundColor: 'rgba(255,255,255,0.2)',
    paddingHorizontal: spacing.sm,
    paddingVertical: spacing.xxs,
    borderRadius: 20,
    flexDirection: 'row',
    alignItems: 'center',
  },
  qrIcon: {
    marginRight: spacing.xs,
  },
  quickActions: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    backgroundColor: 'white',
    borderRadius: 20,
    marginHorizontal: spacing.md,
    marginBottom: spacing.md,
    paddingVertical: spacing.sm,
    shadowColor: 'rgba(0,0,0,0.1)',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 4,
    elevation: 3,
  },
  actionButton: {
    alignItems: 'center',
    justifyContent: 'center',
    paddingHorizontal: spacing.md,
  },
  actionText: {
    marginTop: spacing.xxs,
    color: colors.textMuted,
  },
  content: {
    padding: spacing.md,
    paddingBottom: spacing.xxxl,
  },
  section: {
    marginBottom: spacing.md,
    padding: spacing.md,
    borderRadius: 20,
    backgroundColor: 'white',
  },
  sectionHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: spacing.sm,
  },
  sectionTitle: {
    marginBottom: spacing.sm,
  },
  bio: {
    marginBottom: spacing.sm,
    lineHeight: 20,
  },
  languagesContainer: {
    flexDirection: 'row',
    marginTop: spacing.sm,
  },
  languageBadge: {
    backgroundColor: 'rgba(140, 186, 205, 0.1)',
    paddingHorizontal: spacing.sm,
    paddingVertical: spacing.xxs,
    borderRadius: 12,
    marginRight: spacing.xs,
  },
  viewAllButton: {
    paddingHorizontal: spacing.sm,
    paddingVertical: spacing.xxs,
    backgroundColor: 'rgba(140, 186, 205, 0.1)',
    borderRadius: 12,
  },
  galleryContainer: {
    marginTop: spacing.sm,
  },
  galleryImage: {
    width: 140,
    height: 140,
    borderRadius: 20,
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
    borderBottomColor: 'rgba(0,0,0,0.05)',
  },
  serviceInfo: {
    flex: 1,
  },
  serviceNameRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: spacing.xxs,
  },
  serviceName: {
    marginRight: spacing.xs,
  },
  popularTag: {
    backgroundColor: colors.primary,
    paddingHorizontal: spacing.xs,
    paddingVertical: 2,
    borderRadius: 10,
  },
  popularTagText: {
    fontSize: 10,
    fontWeight: '600',
  },
  servicePrice: {
    fontWeight: '700',
  },
  dayTabsContainer: {
    flexDirection: 'row',
    marginBottom: spacing.md,
  },
  dayTab: {
    paddingHorizontal: spacing.md,
    paddingVertical: spacing.sm,
    borderRadius: 20,
    marginRight: spacing.sm,
    backgroundColor: 'rgba(0,0,0,0.03)',
  },
  selectedDayTab: {
    backgroundColor: colors.stylistBlue,
  },
  timeSlotsContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
  },
  timeSlot: {
    paddingHorizontal: spacing.sm,
    paddingVertical: spacing.xs,
    borderRadius: 16,
    marginRight: spacing.sm,
    marginBottom: spacing.sm,
    backgroundColor: 'rgba(0,0,0,0.03)',
    borderWidth: 1,
    borderColor: 'transparent',
  },
  selectedTimeSlot: {
    backgroundColor: 'white',
    borderColor: colors.stylistBlue,
  },
  bookingButtonContainer: {
    marginTop: spacing.md,
    marginBottom: spacing.xl,
  },
  bookButton: {
    backgroundColor: colors.stylistBlue,
    borderWidth: 0,
  },
});

export default BarberProfileScreen;
