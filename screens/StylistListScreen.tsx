import React, { useState, useEffect } from 'react';
import { View, FlatList, ActivityIndicator, StyleSheet, TouchableOpacity } from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '../types';
import { colors, spacing } from '../constants'; // Use relative path for now
import { FontAwesome } from '@expo/vector-icons';
// import { MotiView } from 'moti'; // Comment out Moti

// Import our custom components
import { ImmersiveScreen, Header, Typography, Card } from '../components'; // Use relative path for now

type StylistListScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'StylistListScreen'
>;
type StylistListScreenRouteProp = RouteProp<
  RootStackParamList,
  'StylistListScreen'
>;

type Props = {
  navigation: StylistListScreenNavigationProp;
  route: StylistListScreenRouteProp;
};

// Mock stylist data
const mockStylists = [
  {
    id: 1,
    name: 'Hassan the Barber',
    rating: 4.9,
    distance_km: 2.1,
    verified: true,
    profile_picture: 'https://randomuser.me/api/portraits/men/32.jpg'
  },
  {
    id: 2,
    name: 'Yasin Styles',
    rating: 4.7,
    distance_km: 3.4,
    verified: false,
    profile_picture: 'https://randomuser.me/api/portraits/men/44.jpg'
  },
  {
    id: 3,
    name: 'Fatima Braids',
    rating: 4.8,
    distance_km: 1.8,
    verified: true,
    profile_picture: 'https://randomuser.me/api/portraits/women/65.jpg'
  },
];

const StylistListScreen: React.FC<Props> = ({ navigation, route }) => {
  const serviceId = route.params?.serviceId;
  const [loading, setLoading] = useState(true);
  const [stylists, setStylists] = useState<typeof mockStylists>([]);

  // Simulate API call
  useEffect(() => {
    // Simulate network delay
    const timer = setTimeout(() => {
      setStylists(mockStylists);
      setLoading(false);
    }, 1000);

    return () => clearTimeout(timer);
  }, []);

  const handleStylistSelect = (stylistId: number) => {
    navigation.navigate('BarberProfileScreen', { stylistId });
  };

  // Get service name based on ID
  const getServiceName = (id?: number) => {
    if (!id) return 'All Services';

    switch(id) {
      case 1: return 'Haircut';
      case 2: return 'Beard Trim';
      case 3: return 'Braids';
      case 4: return 'Full Service';
      default: return `Service ${id}`;
    }
  };

  // Get service color based on ID
  const getServiceColor = (id?: number) => {
    if (!id) return colors.primary;

    switch(id) {
      case 1: return colors.primary;
      case 2: return colors.stylistBlue;
      case 3: return colors.success;
      case 4: return colors.info;
      default: return colors.primary;
    }
  };

  return (
    <ImmersiveScreen backgroundColor={getServiceColor(serviceId)} statusBarStyle="light-content">
      <Header
        title={`${getServiceName(serviceId)} Stylists`}
        showBackButton
        style={styles.header}
        titleAlign="center"
      />

      {/* Service Info Card */}
      <Card style={styles.serviceInfoCard} variant="bubble" withShadow>
        <View style={styles.serviceIconContainer}>
          <FontAwesome
            name={serviceId === 2 ? 'user' : serviceId === 3 ? 'paint-brush' : serviceId === 4 ? 'star' : 'scissors'}
            size={24}
            color={getServiceColor(serviceId)}
          />
        </View>
        <Typography variant="subheading" style={styles.serviceTitle}>
          {getServiceName(serviceId)}
        </Typography>
        <Typography variant="caption" color={colors.textMuted}>
          Find the perfect stylist for your needs
        </Typography>
      </Card>

      <View style={styles.container}>
        {loading ? (
          <View style={styles.centerContent}>
            <ActivityIndicator size="large" color="white" />
            <Typography variant="caption" color="white" style={styles.loadingText}>
              Finding stylists near you...
            </Typography>
          </View>
        ) : stylists.length === 0 ? (
          // Empty State
          <View style={styles.centerContent}>
            <Card style={styles.emptyCard} variant="bubble" withShadow>
              <FontAwesome name="search" size={32} color={colors.textMuted} style={styles.emptyIcon} />
              <Typography variant="subheading" color={colors.textMuted} align="center">
                No stylists found
              </Typography>
              <Typography variant="caption" color={colors.textMuted} align="center" style={styles.emptyText}>
                No stylists found for this service in your area yet.
              </Typography>
              <TouchableOpacity style={styles.tryAgainButton} onPress={() => navigation.goBack()}>
                <Typography variant="button" color={colors.primary}>
                  Try Another Service
                </Typography>
              </TouchableOpacity>
            </Card>
          </View>
        ) : (
          // List State
          <>
            <View style={styles.listHeader}>
              <Typography variant="bodyMedium" color="white" style={styles.availableText}>
                {stylists.length} stylists available in your area
              </Typography>
              <TouchableOpacity style={styles.filterButton}>
                <FontAwesome name="sliders" size={16} color="white" />
                <Typography variant="caption" color="white" style={styles.filterText}>
                  Filter
                </Typography>
              </TouchableOpacity>
            </View>

            <FlatList
              data={stylists}
              keyExtractor={(item) => item.id.toString()}
              renderItem={({ item }) => (
                <TouchableOpacity activeOpacity={0.8} onPress={() => handleStylistSelect(item.id)}>
                  <Card style={styles.stylistCard} variant="bubble" withShadow>
                    <View style={styles.stylistCardContent}>
                      <View style={styles.stylistImagePlaceholder}>
                        <FontAwesome name="user" size={32} color={colors.primary} />
                      </View>
                      <View style={styles.stylistInfo}>
                        <Typography variant="bodyMedium" style={styles.stylistName}>
                          {item.name}
                        </Typography>
                        <View style={styles.ratingContainer}>
                          <FontAwesome name="star" size={14} color="#FFD700" />
                          <Typography variant="caption" style={styles.ratingText}>
                            {item.rating.toFixed(1)}
                          </Typography>
                        </View>
                        <View style={styles.distanceContainer}>
                          <FontAwesome name="map-marker" size={14} color={colors.textMuted} />
                          <Typography variant="caption" color={colors.textMuted} style={styles.distanceText}>
                            {item.distance_km.toFixed(1)} km away
                          </Typography>
                        </View>
                      </View>
                      <TouchableOpacity style={styles.bookButton}>
                        <Typography variant="caption" color={colors.primary} style={styles.bookText}>
                          Book
                        </Typography>
                      </TouchableOpacity>
                    </View>
                  </Card>
                </TouchableOpacity>
              )}
              showsVerticalScrollIndicator={false}
              contentContainerStyle={styles.listContent}
            />
          </>
        )}
      </View>
    </ImmersiveScreen>
  );
};

const styles = StyleSheet.create({
  header: {
    backgroundColor: 'transparent',
  },
  container: {
    flex: 1,
    padding: spacing.md,
  },
  serviceInfoCard: {
    marginHorizontal: spacing.md,
    marginBottom: spacing.md,
    padding: spacing.md,
    backgroundColor: colors.cream,
    alignItems: 'center',
  },
  serviceIconContainer: {
    width: 48,
    height: 48,
    borderRadius: 24,
    backgroundColor: 'rgba(244, 128, 93, 0.1)',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: spacing.xs,
  },
  serviceTitle: {
    marginBottom: spacing.xs,
    fontWeight: '600',
  },
  centerContent: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  loadingText: {
    marginTop: spacing.sm,
    textShadowColor: 'rgba(0, 0, 0, 0.2)',
    textShadowOffset: { width: 0, height: 1 },
    textShadowRadius: 2,
  },
  emptyCard: {
    padding: spacing.lg,
    alignItems: 'center',
    backgroundColor: colors.cream,
    width: '100%',
  },
  emptyIcon: {
    marginBottom: spacing.md,
  },
  emptyText: {
    marginTop: spacing.xs,
    marginBottom: spacing.md,
  },
  tryAgainButton: {
    paddingVertical: spacing.sm,
    paddingHorizontal: spacing.md,
    backgroundColor: 'rgba(244, 128, 93, 0.1)',
    borderRadius: 20,
    marginTop: spacing.sm,
  },
  listHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: spacing.md,
  },
  availableText: {
    textShadowColor: 'rgba(0, 0, 0, 0.2)',
    textShadowOffset: { width: 0, height: 1 },
    textShadowRadius: 2,
  },
  filterButton: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    paddingVertical: spacing.xs,
    paddingHorizontal: spacing.sm,
    borderRadius: 16,
  },
  filterText: {
    marginLeft: spacing.xs,
  },
  listContent: {
    paddingBottom: spacing.xl,
  },
  stylistCard: {
    marginBottom: spacing.md,
    padding: spacing.sm,
    backgroundColor: colors.cream,
  },
  stylistCardContent: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  stylistImagePlaceholder: {
    width: 60,
    height: 60,
    borderRadius: 30,
    backgroundColor: 'rgba(244, 128, 93, 0.1)',
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: spacing.md,
  },
  stylistInfo: {
    flex: 1,
  },
  stylistName: {
    fontWeight: '600',
    marginBottom: spacing.xs,
  },
  ratingContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: spacing.xs,
  },
  ratingText: {
    marginLeft: spacing.xs,
  },
  distanceContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  distanceText: {
    marginLeft: spacing.xs,
  },
  bookButton: {
    paddingVertical: spacing.xs,
    paddingHorizontal: spacing.sm,
    backgroundColor: 'rgba(244, 128, 93, 0.1)',
    borderRadius: 16,
  },
  bookText: {
    fontWeight: '600',
  },
});

export default StylistListScreen;
