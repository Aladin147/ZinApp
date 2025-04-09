import React, { useState, useEffect, useRef } from 'react';
import { 
  View, 
  StyleSheet, 
  TouchableOpacity, 
  Animated, 
  Image,
  ScrollView
} from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '../types';
import { colors, spacing } from '../constants';
import { FontAwesome } from '@expo/vector-icons';
import { LinearGradient } from 'expo-linear-gradient';
import ConfettiCannon from 'react-native-confetti-cannon';

// Import our custom components
import { Typography, Button, Card, ImmersiveScreen, Avatar } from '../components';

type Bsse7aScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'Bsse7aScreen'
>;
type Bsse7aScreenRouteProp = RouteProp<RootStackParamList, 'Bsse7aScreen'>;

type Props = {
  navigation: Bsse7aScreenNavigationProp;
  route: Bsse7aScreenRouteProp;
};

const Bsse7aScreen: React.FC<Props> = ({ navigation, route }) => {
  const bookingId = route.params?.bookingId;
  
  // Animation values
  const fadeAnim = useRef(new Animated.Value(0)).current;
  const slideAnim = useRef(new Animated.Value(50)).current;
  const scaleAnim = useRef(new Animated.Value(0.8)).current;
  
  // Confetti ref
  const confettiRef = useRef<ConfettiCannon>(null);
  
  // State for rating and tip
  const [rating, setRating] = useState<number>(0);
  const [tipAmount, setTipAmount] = useState<number | null>(null);
  
  // Mock stylist data
  const stylist = {
    id: 1,
    name: 'Hassan the Barber',
    avatar: 'https://randomuser.me/api/portraits/men/32.jpg',
  };
  
  // Mock booking data
  const booking = {
    id: bookingId,
    service: 'Haircut',
    price: 35,
    date: 'Today',
    time: '3:30 PM',
  };
  
  // Tip options
  const tipOptions = [
    { value: 5, label: '5 DH', percentage: '~15%' },
    { value: 10, label: '10 DH', percentage: '~30%' },
    { value: 15, label: '15 DH', percentage: '~45%' },
    { value: 0, label: 'No Tip', percentage: '' },
  ];
  
  // Start animations when component mounts
  useEffect(() => {
    // Trigger confetti after a short delay
    setTimeout(() => {
      if (confettiRef.current) {
        confettiRef.current.start();
      }
    }, 500);
    
    // Start animations
    Animated.parallel([
      Animated.timing(fadeAnim, {
        toValue: 1,
        duration: 800,
        useNativeDriver: true,
      }),
      Animated.timing(slideAnim, {
        toValue: 0,
        duration: 800,
        useNativeDriver: true,
      }),
      Animated.spring(scaleAnim, {
        toValue: 1,
        friction: 8,
        tension: 40,
        useNativeDriver: true,
      }),
    ]).start();
  }, []);
  
  // Handle rating selection
  const handleRating = (value: number) => {
    setRating(value);
  };
  
  // Handle tip selection
  const handleTip = (value: number) => {
    setTipAmount(value);
  };
  
  // Handle done button press
  const handleDone = () => {
    navigation.reset({
      index: 0,
      routes: [{ name: 'LandingScreen' }],
    });
  };
  
  // Handle book again button press
  const handleBookAgain = () => {
    navigation.navigate('ServiceSelectScreen');
  };
  
  return (
    <ImmersiveScreen backgroundColor={colors.success} statusBarStyle="light-content" scrollable={true}>
      {/* Confetti Cannon */}
      <ConfettiCannon
        ref={confettiRef}
        count={100}
        origin={{ x: -10, y: 0 }}
        fallSpeed={2500}
        fadeOut={true}
        autoStart={false}
        colors={[colors.primary, colors.success, colors.stylistBlue, colors.cream, 'white']}
      />
      
      {/* Header */}
      <View style={styles.header}>
        <Typography variant="heading" color="white" style={styles.headerTitle}>
          Bsse7a!
        </Typography>
        <Typography variant="body" color="white" style={styles.headerSubtitle}>
          Your haircut is complete
        </Typography>
      </View>
      
      {/* Main Content */}
      <ScrollView 
        style={styles.scrollView}
        contentContainerStyle={styles.scrollContent}
        showsVerticalScrollIndicator={false}
      >
        {/* Stylist Thank You Card */}
        <Animated.View style={[
          styles.animatedContainer,
          { 
            opacity: fadeAnim,
            transform: [
              { translateY: slideAnim },
              { scale: scaleAnim }
            ]
          }
        ]}>
          <Card style={styles.thankYouCard} variant="bubble" withShadow>
            <View style={styles.stylistContainer}>
              <Image source={{ uri: stylist.avatar }} style={styles.stylistAvatar} />
              <View style={styles.messageContainer}>
                <Typography variant="subheading" style={styles.thankYouTitle}>
                  Thank you for your visit!
                </Typography>
                <Typography variant="body" color={colors.textMuted} style={styles.thankYouMessage}>
                  I hope you enjoyed your {booking.service.toLowerCase()}. Looking forward to seeing you again!
                </Typography>
                <Typography variant="caption" style={styles.stylistSignature}>
                  - {stylist.name}
                </Typography>
              </View>
            </View>
          </Card>
          
          {/* Rating Card */}
          <Card style={styles.ratingCard} variant="bubble" withShadow>
            <Typography variant="subheading" style={styles.cardTitle}>
              How was your experience?
            </Typography>
            
            <View style={styles.starsContainer}>
              {[1, 2, 3, 4, 5].map((star) => (
                <TouchableOpacity
                  key={star}
                  onPress={() => handleRating(star)}
                  style={styles.starButton}
                  activeOpacity={0.7}
                >
                  <FontAwesome
                    name={rating >= star ? 'star' : 'star-o'}
                    size={36}
                    color={rating >= star ? '#FFD700' : colors.textMuted}
                  />
                </TouchableOpacity>
              ))}
            </View>
            
            <Typography 
              variant="body" 
              color={colors.textMuted}
              style={styles.ratingLabel}
            >
              {rating === 0 ? 'Tap to rate' : 
               rating === 1 ? 'Poor' :
               rating === 2 ? 'Fair' :
               rating === 3 ? 'Good' :
               rating === 4 ? 'Very Good' : 'Excellent!'}
            </Typography>
          </Card>
          
          {/* Tip Card */}
          <Card style={styles.tipCard} variant="bubble" withShadow>
            <Typography variant="subheading" style={styles.cardTitle}>
              Would you like to leave a tip?
            </Typography>
            
            <View style={styles.tipOptionsContainer}>
              {tipOptions.map((option) => (
                <TouchableOpacity
                  key={option.value}
                  style={[
                    styles.tipOption,
                    tipAmount === option.value && styles.selectedTipOption
                  ]}
                  onPress={() => handleTip(option.value)}
                  activeOpacity={0.7}
                >
                  <Typography 
                    variant="bodyMedium" 
                    color={tipAmount === option.value ? 'white' : colors.textMain}
                    style={styles.tipAmount}
                  >
                    {option.label}
                  </Typography>
                  {option.percentage && (
                    <Typography 
                      variant="caption" 
                      color={tipAmount === option.value ? 'white' : colors.textMuted}
                    >
                      {option.percentage}
                    </Typography>
                  )}
                </TouchableOpacity>
              ))}
            </View>
            
            <Typography 
              variant="caption" 
              color={colors.textMuted}
              style={styles.tipNote}
            >
              100% of your tip goes directly to your stylist
            </Typography>
          </Card>
          
          {/* Booking Summary Card */}
          <Card style={styles.summaryCard} variant="bubble" withShadow>
            <Typography variant="subheading" style={styles.cardTitle}>
              Booking Summary
            </Typography>
            
            <View style={styles.summaryItem}>
              <Typography variant="body" color={colors.textMuted}>
                Service
              </Typography>
              <Typography variant="bodyMedium">
                {booking.service}
              </Typography>
            </View>
            
            <View style={styles.summaryItem}>
              <Typography variant="body" color={colors.textMuted}>
                Date & Time
              </Typography>
              <Typography variant="bodyMedium">
                {booking.date}, {booking.time}
              </Typography>
            </View>
            
            <View style={styles.summaryItem}>
              <Typography variant="body" color={colors.textMuted}>
                Stylist
              </Typography>
              <Typography variant="bodyMedium">
                {stylist.name}
              </Typography>
            </View>
            
            <View style={styles.divider} />
            
            <View style={styles.summaryItem}>
              <Typography variant="bodyMedium" color={colors.textMuted}>
                Service Fee
              </Typography>
              <Typography variant="bodyMedium">
                {booking.price} DH
              </Typography>
            </View>
            
            {tipAmount !== null && tipAmount > 0 && (
              <View style={styles.summaryItem}>
                <Typography variant="bodyMedium" color={colors.textMuted}>
                  Tip
                </Typography>
                <Typography variant="bodyMedium">
                  {tipAmount} DH
                </Typography>
              </View>
            )}
            
            <View style={styles.summaryItem}>
              <Typography variant="subheading">
                Total
              </Typography>
              <Typography variant="subheading" color={colors.primary}>
                {booking.price + (tipAmount || 0)} DH
              </Typography>
            </View>
          </Card>
          
          {/* Action Buttons */}
          <View style={styles.actionButtons}>
            <Button
              title="Book Again"
              variant="outline"
              size="medium"
              iconName="calendar"
              iconPosition="left"
              style={styles.bookAgainButton}
              textStyle={styles.bookAgainText}
              onPress={handleBookAgain}
            />
            
            <Button
              title="Done"
              variant="primary"
              size="medium"
              iconName="check"
              iconPosition="right"
              style={styles.doneButton}
              onPress={handleDone}
            />
          </View>
          
          {/* Share Experience Button */}
          <TouchableOpacity style={styles.shareButton} activeOpacity={0.7}>
            <FontAwesome name="share-alt" size={16} color={colors.textMuted} style={styles.shareIcon} />
            <Typography variant="body" color={colors.textMuted}>
              Share your experience
            </Typography>
          </TouchableOpacity>
        </Animated.View>
      </ScrollView>
      
      {/* Decorative Elements */}
      <View style={styles.decorativeCircle1} />
      <View style={styles.decorativeCircle2} />
      <View style={styles.decorativeDot1} />
      <View style={styles.decorativeDot2} />
      <View style={styles.decorativeDot3} />
    </ImmersiveScreen>
  );
};

const styles = StyleSheet.create({
  header: {
    alignItems: 'center',
    paddingTop: spacing.xl,
    paddingBottom: spacing.lg,
  },
  headerTitle: {
    fontSize: 32,
    fontWeight: 'bold',
    textShadowColor: 'rgba(0,0,0,0.1)',
    textShadowOffset: { width: 0, height: 1 },
    textShadowRadius: 2,
    marginBottom: spacing.xs,
  },
  headerSubtitle: {
    opacity: 0.9,
    textShadowColor: 'rgba(0,0,0,0.1)',
    textShadowOffset: { width: 0, height: 1 },
    textShadowRadius: 2,
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    paddingHorizontal: spacing.md,
    paddingBottom: spacing.xxxl,
  },
  animatedContainer: {
    width: '100%',
  },
  thankYouCard: {
    padding: spacing.md,
    marginBottom: spacing.md,
    backgroundColor: 'white',
  },
  stylistContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  stylistAvatar: {
    width: 60,
    height: 60,
    borderRadius: 30,
    marginRight: spacing.md,
  },
  messageContainer: {
    flex: 1,
  },
  thankYouTitle: {
    marginBottom: spacing.xs,
  },
  thankYouMessage: {
    marginBottom: spacing.xs,
  },
  stylistSignature: {
    fontStyle: 'italic',
    alignSelf: 'flex-end',
    color: colors.success,
  },
  ratingCard: {
    padding: spacing.md,
    marginBottom: spacing.md,
    backgroundColor: 'white',
    alignItems: 'center',
  },
  cardTitle: {
    marginBottom: spacing.md,
    textAlign: 'center',
  },
  starsContainer: {
    flexDirection: 'row',
    justifyContent: 'center',
    marginBottom: spacing.sm,
  },
  starButton: {
    padding: spacing.xs,
  },
  ratingLabel: {
    marginTop: spacing.xs,
  },
  tipCard: {
    padding: spacing.md,
    marginBottom: spacing.md,
    backgroundColor: 'white',
    alignItems: 'center',
  },
  tipOptionsContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'center',
    marginBottom: spacing.sm,
  },
  tipOption: {
    width: '45%',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'rgba(0,0,0,0.03)',
    borderRadius: 12,
    padding: spacing.sm,
    margin: '2.5%',
    borderWidth: 1,
    borderColor: 'transparent',
  },
  selectedTipOption: {
    backgroundColor: colors.success,
    borderColor: colors.success,
  },
  tipAmount: {
    fontWeight: '600',
  },
  tipNote: {
    marginTop: spacing.sm,
    textAlign: 'center',
  },
  summaryCard: {
    padding: spacing.md,
    marginBottom: spacing.md,
    backgroundColor: 'white',
  },
  summaryItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: spacing.sm,
  },
  divider: {
    height: 1,
    backgroundColor: 'rgba(0,0,0,0.05)',
    marginVertical: spacing.sm,
  },
  actionButtons: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: spacing.md,
  },
  bookAgainButton: {
    flex: 1,
    marginRight: spacing.sm,
    borderColor: 'white',
  },
  bookAgainText: {
    color: 'white',
  },
  doneButton: {
    flex: 1,
    marginLeft: spacing.sm,
    backgroundColor: 'white',
  },
  shareButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    padding: spacing.md,
    marginBottom: spacing.md,
  },
  shareIcon: {
    marginRight: spacing.xs,
  },
  decorativeCircle1: {
    position: 'absolute',
    width: 200,
    height: 200,
    borderRadius: 100,
    backgroundColor: 'transparent',
    borderWidth: 1,
    borderColor: 'rgba(255,255,255,0.1)',
    top: -50,
    right: -50,
  },
  decorativeCircle2: {
    position: 'absolute',
    width: 150,
    height: 150,
    borderRadius: 75,
    backgroundColor: 'transparent',
    borderWidth: 1,
    borderColor: 'rgba(255,255,255,0.1)',
    bottom: 100,
    left: -50,
  },
  decorativeDot1: {
    position: 'absolute',
    width: 8,
    height: 8,
    borderRadius: 4,
    backgroundColor: 'rgba(255,255,255,0.2)',
    top: '20%',
    right: '15%',
  },
  decorativeDot2: {
    position: 'absolute',
    width: 6,
    height: 6,
    borderRadius: 3,
    backgroundColor: 'rgba(255,255,255,0.2)',
    bottom: '30%',
    right: '40%',
  },
  decorativeDot3: {
    position: 'absolute',
    width: 10,
    height: 10,
    borderRadius: 5,
    backgroundColor: 'rgba(255,255,255,0.2)',
    top: '40%',
    left: '10%',
  },
});

export default Bsse7aScreen;
