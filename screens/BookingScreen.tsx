import React, { useState, useEffect } from 'react';
import { 
  View, 
  StyleSheet, 
  TouchableOpacity, 
  Animated, 
  ScrollView,
  FlatList
} from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '../types';
import { colors, spacing } from '../constants';
import { FontAwesome } from '@expo/vector-icons';
import { useAuth } from '../state/AuthContext';
import { LinearGradient } from 'expo-linear-gradient';

// Import our custom components
import { 
  Typography, 
  Button, 
  Card, 
  ImmersiveScreen,
  Avatar
} from '../components';

type BookingScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'BookingScreen'
>;
type BookingScreenRouteProp = RouteProp<RootStackParamList, 'BookingScreen'>;

type Props = {
  navigation: BookingScreenNavigationProp;
  route: BookingScreenRouteProp;
};

// Mock data for the booking screen
const mockStylist = {
  id: 1,
  name: 'James Wilson',
  title: 'Master Barber',
  rating: 4.8,
  profileImage: { uri: 'https://randomuser.me/api/portraits/men/32.jpg' },
};

const mockService = {
  id: 1,
  name: 'Haircut',
  price: 35,
  duration: '30 min',
};

const mockTimeSlots = [
  { id: 1, time: '9:00 AM', available: true },
  { id: 2, time: '10:00 AM', available: true },
  { id: 3, time: '11:00 AM', available: false },
  { id: 4, time: '12:00 PM', available: true },
  { id: 5, time: '1:00 PM', available: true },
  { id: 6, time: '2:00 PM', available: false },
  { id: 7, time: '3:00 PM', available: true },
  { id: 8, time: '4:00 PM', available: true },
  { id: 9, time: '5:00 PM', available: false },
];

const mockDates = [
  { id: 1, day: 'Mon', date: '12', month: 'Nov', available: true },
  { id: 2, day: 'Tue', date: '13', month: 'Nov', available: true },
  { id: 3, day: 'Wed', date: '14', month: 'Nov', available: true },
  { id: 4, day: 'Thu', date: '15', month: 'Nov', available: true },
  { id: 5, day: 'Fri', date: '16', month: 'Nov', available: true },
  { id: 6, day: 'Sat', date: '17', month: 'Nov', available: false },
  { id: 7, day: 'Sun', date: '18', month: 'Nov', available: false },
  { id: 8, day: 'Mon', date: '19', month: 'Nov', available: true },
  { id: 9, day: 'Tue', date: '20', month: 'Nov', available: true },
];

const mockPaymentMethods = [
  { id: 1, type: 'credit-card', last4: '4242', brand: 'Visa', default: true },
  { id: 2, type: 'credit-card', last4: '1234', brand: 'Mastercard', default: false },
];

const BookingScreen: React.FC<Props> = ({ navigation, route }) => {
  const { stylistId, serviceId } = route.params;
  const { isVerified } = useAuth();

  // Animation values
  const fadeAnim = React.useRef(new Animated.Value(0)).current;
  const slideAnim = React.useRef(new Animated.Value(50)).current;

  // State for booking process
  const [currentStep, setCurrentStep] = useState(1);
  const [selectedDate, setSelectedDate] = useState<number | null>(1);
  const [selectedTime, setSelectedTime] = useState<number | null>(null);
  const [selectedPayment, setSelectedPayment] = useState<number | null>(1);
  const [payLater, setPayLater] = useState(false);
  const [specialRequests, setSpecialRequests] = useState('');
  const [showSpecialRequests, setShowSpecialRequests] = useState(false);

  // Start animations when component mounts
  useEffect(() => {
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
  }, []);

  // Function to handle step changes
  const handleNextStep = () => {
    if (currentStep < 3) {
      setCurrentStep(currentStep + 1);
    } else {
      // Final step - confirm booking
      navigation.navigate('LiveTrackScreen', { bookingId: 101 });
    }
  };

  const handlePrevStep = () => {
    if (currentStep > 1) {
      setCurrentStep(currentStep - 1);
    } else {
      navigation.goBack();
    }
  };

  // Function to check if current step is complete
  const isStepComplete = () => {
    switch (currentStep) {
      case 1:
        return selectedDate !== null;
      case 2:
        return selectedTime !== null;
      case 3:
        return isVerified ? true : selectedPayment !== null;
      default:
        return false;
    }
  };

  // Render the step indicator
  const renderStepIndicator = () => {
    return (
      <View style={styles.stepIndicator}>
        {[1, 2, 3].map((step) => (
          <View key={step} style={styles.stepContainer}>
            <View 
              style={[
                styles.stepCircle, 
                currentStep === step ? styles.activeStepCircle : 
                currentStep > step ? styles.completedStepCircle : {}
              ]}
            >
              {currentStep > step ? (
                <FontAwesome name="check" size={14} color="white" />
              ) : (
                <Typography 
                  variant="caption" 
                  color={currentStep === step ? 'white' : colors.textMuted}
                >
                  {step}
                </Typography>
              )}
            </View>
            <Typography 
              variant="caption" 
              color={currentStep === step ? colors.primary : colors.textMuted}
              style={styles.stepLabel}
            >
              {step === 1 ? 'Date' : step === 2 ? 'Time' : 'Payment'}
            </Typography>
          </View>
        ))}
        <View style={styles.stepConnector} />
      </View>
    );
  };

  // Render the date selection step
  const renderDateSelection = () => {
    return (
      <Card style={styles.stepCard} variant="bubble" withShadow>
        <Typography variant="subheading" style={styles.stepTitle}>
          Select Date
        </Typography>
        
        <FlatList
          data={mockDates}
          horizontal
          showsHorizontalScrollIndicator={false}
          renderItem={({ item }) => (
            <TouchableOpacity
              style={[
                styles.dateItem,
                !item.available && styles.unavailableDateItem,
                selectedDate === item.id && styles.selectedDateItem
              ]}
              disabled={!item.available}
              onPress={() => setSelectedDate(item.id)}
              activeOpacity={0.7}
            >
              <Typography 
                variant="caption" 
                color={
                  !item.available ? colors.textMuted : 
                  selectedDate === item.id ? 'white' : colors.textMain
                }
              >
                {item.day}
              </Typography>
              <Typography 
                variant="subheading" 
                color={
                  !item.available ? colors.textMuted : 
                  selectedDate === item.id ? 'white' : colors.textMain
                }
                style={styles.dateNumber}
              >
                {item.date}
              </Typography>
              <Typography 
                variant="caption" 
                color={
                  !item.available ? colors.textMuted : 
                  selectedDate === item.id ? 'white' : colors.textMain
                }
              >
                {item.month}
              </Typography>
            </TouchableOpacity>
          )}
          keyExtractor={(item) => item.id.toString()}
          contentContainerStyle={styles.dateList}
        />
      </Card>
    );
  };

  // Render the time selection step
  const renderTimeSelection = () => {
    return (
      <Card style={styles.stepCard} variant="bubble" withShadow>
        <Typography variant="subheading" style={styles.stepTitle}>
          Select Time
        </Typography>
        
        <View style={styles.timeGrid}>
          {mockTimeSlots.map((slot) => (
            <TouchableOpacity
              key={slot.id}
              style={[
                styles.timeItem,
                !slot.available && styles.unavailableTimeItem,
                selectedTime === slot.id && styles.selectedTimeItem
              ]}
              disabled={!slot.available}
              onPress={() => setSelectedTime(slot.id)}
              activeOpacity={0.7}
            >
              <Typography 
                variant="body" 
                color={
                  !slot.available ? colors.textMuted : 
                  selectedTime === slot.id ? 'white' : colors.textMain
                }
              >
                {slot.time}
              </Typography>
            </TouchableOpacity>
          ))}
        </View>
      </Card>
    );
  };

  // Render the payment selection step
  const renderPaymentSelection = () => {
    return (
      <Card style={styles.stepCard} variant="bubble" withShadow>
        <Typography variant="subheading" style={styles.stepTitle}>
          Payment Method
        </Typography>
        
        {isVerified ? (
          <>
            <View style={styles.paymentMethods}>
              {mockPaymentMethods.map((method) => (
                <TouchableOpacity
                  key={method.id}
                  style={[
                    styles.paymentItem,
                    selectedPayment === method.id && styles.selectedPaymentItem
                  ]}
                  onPress={() => {
                    setSelectedPayment(method.id);
                    setPayLater(false);
                  }}
                  activeOpacity={0.7}
                >
                  <View style={styles.paymentIconContainer}>
                    <FontAwesome 
                      name={method.brand.toLowerCase() === 'visa' ? 'cc-visa' : 'cc-mastercard'} 
                      size={24} 
                      color={selectedPayment === method.id ? colors.primary : colors.textMuted} 
                    />
                  </View>
                  <View style={styles.paymentDetails}>
                    <Typography variant="bodyMedium" color={colors.textMain}>
                      {method.brand} •••• {method.last4}
                    </Typography>
                    {method.default && (
                      <Typography variant="caption" color={colors.textMuted}>
                        Default
                      </Typography>
                    )}
                  </View>
                  <View style={[
                    styles.paymentCheckbox,
                    selectedPayment === method.id && styles.selectedPaymentCheckbox
                  ]}>
                    {selectedPayment === method.id && (
                      <FontAwesome name="check" size={12} color="white" />
                    )}
                  </View>
                </TouchableOpacity>
              ))}
            </View>
            
            <TouchableOpacity
              style={[
                styles.payLaterOption,
                payLater && styles.selectedPayLaterOption
              ]}
              onPress={() => {
                setPayLater(true);
                setSelectedPayment(null);
              }}
              activeOpacity={0.7}
            >
              <View style={styles.paymentIconContainer}>
                <FontAwesome 
                  name="money" 
                  size={24} 
                  color={payLater ? colors.primary : colors.textMuted} 
                />
              </View>
              <View style={styles.paymentDetails}>
                <Typography variant="bodyMedium" color={colors.textMain}>
                  Pay Later (Cash)
                </Typography>
                <Typography variant="caption" color={colors.textMuted}>
                  Pay directly to your stylist
                </Typography>
              </View>
              <View style={[
                styles.paymentCheckbox,
                payLater && styles.selectedPaymentCheckbox
              ]}>
                {payLater && (
                  <FontAwesome name="check" size={12} color="white" />
                )}
              </View>
            </TouchableOpacity>
          </>
        ) : (
          <View style={styles.guestPaymentContainer}>
            <FontAwesome name="credit-card" size={40} color={colors.textMuted} style={styles.guestPaymentIcon} />
            <Typography variant="body" color={colors.textMuted} style={styles.guestPaymentText}>
              Please sign in to access payment options or continue as guest to pay in cash.
            </Typography>
            <Button
              title="Sign In"
              variant="outline"
              size="medium"
              style={styles.signInButton}
              onPress={() => navigation.navigate('LoginScreen')}
            />
          </View>
        )}
        
        <TouchableOpacity 
          style={styles.specialRequestsToggle}
          onPress={() => setShowSpecialRequests(!showSpecialRequests)}
          activeOpacity={0.7}
        >
          <Typography variant="bodyMedium" color={colors.primary}>
            {showSpecialRequests ? 'Hide Special Requests' : 'Add Special Requests'}
          </Typography>
          <FontAwesome 
            name={showSpecialRequests ? 'chevron-up' : 'chevron-down'} 
            size={14} 
            color={colors.primary} 
            style={styles.toggleIcon}
          />
        </TouchableOpacity>
        
        {showSpecialRequests && (
          <View style={styles.specialRequestsContainer}>
            <Typography variant="caption" color={colors.textMuted} style={styles.specialRequestsLabel}>
              Any special requests for your stylist?
            </Typography>
            <TouchableOpacity style={styles.specialRequestsInput}>
              <Typography variant="body" color={colors.textMuted}>
                Tap to add special requests...
              </Typography>
            </TouchableOpacity>
          </View>
        )}
      </Card>
    );
  };

  // Render the booking summary
  const renderBookingSummary = () => {
    return (
      <Card style={styles.summaryCard} variant="bubble" withShadow>
        <View style={styles.summaryHeader}>
          <Typography variant="subheading" style={styles.summaryTitle}>
            Booking Summary
          </Typography>
          {currentStep === 3 && (
            <TouchableOpacity style={styles.editButton}>
              <Typography variant="caption" color={colors.primary}>
                Edit
              </Typography>
            </TouchableOpacity>
          )}
        </View>
        
        <View style={styles.summaryContent}>
          <View style={styles.stylistInfo}>
            <Avatar
              source={mockStylist.profileImage}
              size="small"
              style={styles.stylistAvatar}
            />
            <View style={styles.stylistDetails}>
              <Typography variant="bodyMedium" color={colors.textMain}>
                {mockStylist.name}
              </Typography>
              <Typography variant="caption" color={colors.textMuted}>
                {mockStylist.title}
              </Typography>
            </View>
          </View>
          
          <View style={styles.divider} />
          
          <View style={styles.serviceInfo}>
            <Typography variant="bodyMedium" color={colors.textMain}>
              {mockService.name}
            </Typography>
            <Typography variant="bodyMedium" color={colors.primary}>
              ${mockService.price}
            </Typography>
          </View>
          
          <View style={styles.serviceDetails}>
            <View style={styles.serviceDetailItem}>
              <FontAwesome name="clock-o" size={14} color={colors.textMuted} />
              <Typography variant="caption" color={colors.textMuted} style={styles.serviceDetailText}>
                {mockService.duration}
              </Typography>
            </View>
            
            {selectedDate && selectedTime && (
              <View style={styles.serviceDetailItem}>
                <FontAwesome name="calendar" size={14} color={colors.textMuted} />
                <Typography variant="caption" color={colors.textMuted} style={styles.serviceDetailText}>
                  {mockDates.find(d => d.id === selectedDate)?.day}, {mockDates.find(d => d.id === selectedDate)?.date} {mockDates.find(d => d.id === selectedDate)?.month} at {mockTimeSlots.find(t => t.id === selectedTime)?.time}
                </Typography>
              </View>
            )}
            
            {(selectedPayment || payLater) && currentStep === 3 && (
              <View style={styles.serviceDetailItem}>
                <FontAwesome name={payLater ? "money" : "credit-card"} size={14} color={colors.textMuted} />
                <Typography variant="caption" color={colors.textMuted} style={styles.serviceDetailText}>
                  {payLater ? "Pay Later (Cash)" : `${mockPaymentMethods.find(p => p.id === selectedPayment)?.brand} •••• ${mockPaymentMethods.find(p => p.id === selectedPayment)?.last4}`}
                </Typography>
              </View>
            )}
          </View>
        </View>
      </Card>
    );
  };

  return (
    <ImmersiveScreen backgroundColor={colors.primary} statusBarStyle="light-content">
      {/* Header */}
      <View style={styles.header}>
        <TouchableOpacity 
          style={styles.backButton}
          onPress={handlePrevStep}
          activeOpacity={0.7}
        >
          <FontAwesome name="arrow-left" size={18} color="white" />
        </TouchableOpacity>
        <Typography variant="heading" color="white" style={styles.headerTitle}>
          Book Appointment
        </Typography>
        <View style={styles.headerRight} />
      </View>
      
      {/* Step Indicator */}
      {renderStepIndicator()}
      
      {/* Main Content */}
      <ScrollView 
        style={styles.scrollView}
        contentContainerStyle={styles.scrollContent}
        showsVerticalScrollIndicator={false}
      >
        <Animated.View style={[
          styles.animatedContainer,
          { 
            opacity: fadeAnim,
            transform: [{ translateY: slideAnim }]
          }
        ]}>
          {/* Booking Summary */}
          {renderBookingSummary()}
          
          {/* Step Content */}
          {currentStep === 1 && renderDateSelection()}
          {currentStep === 2 && renderTimeSelection()}
          {currentStep === 3 && renderPaymentSelection()}
          
          {/* Next Button */}
          <Button
            title={currentStep === 3 ? "Confirm Booking" : "Continue"}
            variant="primary"
            size="large"
            iconName={currentStep === 3 ? "check" : "arrow-right"}
            iconPosition="right"
            style={styles.nextButton}
            disabled={!isStepComplete()}
            onPress={handleNextStep}
          />
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
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: spacing.md,
    paddingTop: spacing.lg,
    paddingBottom: spacing.md,
  },
  backButton: {
    width: 36,
    height: 36,
    borderRadius: 18,
    backgroundColor: 'rgba(255,255,255,0.2)',
    alignItems: 'center',
    justifyContent: 'center',
  },
  headerTitle: {
    textAlign: 'center',
    textShadowColor: 'rgba(0,0,0,0.1)',
    textShadowOffset: { width: 0, height: 1 },
    textShadowRadius: 2,
  },
  headerRight: {
    width: 36,
  },
  stepIndicator: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: spacing.xl,
    marginBottom: spacing.md,
    position: 'relative',
  },
  stepContainer: {
    alignItems: 'center',
    zIndex: 1,
  },
  stepCircle: {
    width: 28,
    height: 28,
    borderRadius: 14,
    backgroundColor: 'rgba(255,255,255,0.2)',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: spacing.xs,
  },
  activeStepCircle: {
    backgroundColor: colors.primary,
    borderWidth: 2,
    borderColor: 'white',
  },
  completedStepCircle: {
    backgroundColor: colors.success,
  },
  stepLabel: {
    textAlign: 'center',
  },
  stepConnector: {
    position: 'absolute',
    top: 14,
    left: spacing.xl + 14,
    right: spacing.xl + 14,
    height: 2,
    backgroundColor: 'rgba(255,255,255,0.2)',
    zIndex: 0,
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
  stepCard: {
    padding: spacing.md,
    marginBottom: spacing.md,
    backgroundColor: 'white',
  },
  stepTitle: {
    marginBottom: spacing.md,
  },
  dateList: {
    paddingVertical: spacing.sm,
  },
  dateItem: {
    width: 60,
    height: 80,
    borderRadius: 12,
    backgroundColor: 'rgba(0,0,0,0.03)',
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: spacing.sm,
    borderWidth: 1,
    borderColor: 'transparent',
  },
  unavailableDateItem: {
    backgroundColor: 'rgba(0,0,0,0.02)',
    opacity: 0.5,
  },
  selectedDateItem: {
    backgroundColor: colors.primary,
    borderColor: colors.primary,
  },
  dateNumber: {
    fontSize: 20,
    fontWeight: 'bold',
    marginVertical: spacing.xxs,
  },
  timeGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  timeItem: {
    width: '31%',
    height: 44,
    borderRadius: 10,
    backgroundColor: 'rgba(0,0,0,0.03)',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: spacing.sm,
    borderWidth: 1,
    borderColor: 'transparent',
  },
  unavailableTimeItem: {
    backgroundColor: 'rgba(0,0,0,0.02)',
    opacity: 0.5,
  },
  selectedTimeItem: {
    backgroundColor: colors.primary,
    borderColor: colors.primary,
  },
  paymentMethods: {
    marginBottom: spacing.md,
  },
  paymentItem: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: spacing.sm,
    borderRadius: 12,
    backgroundColor: 'rgba(0,0,0,0.03)',
    marginBottom: spacing.sm,
    borderWidth: 1,
    borderColor: 'transparent',
  },
  selectedPaymentItem: {
    borderColor: colors.primary,
    backgroundColor: 'rgba(244, 128, 93, 0.05)',
  },
  paymentIconContainer: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'white',
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: spacing.sm,
    shadowColor: 'rgba(0,0,0,0.1)',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.2,
    shadowRadius: 2,
    elevation: 2,
  },
  paymentDetails: {
    flex: 1,
  },
  paymentCheckbox: {
    width: 20,
    height: 20,
    borderRadius: 10,
    borderWidth: 1,
    borderColor: colors.textMuted,
    alignItems: 'center',
    justifyContent: 'center',
  },
  selectedPaymentCheckbox: {
    backgroundColor: colors.primary,
    borderColor: colors.primary,
  },
  payLaterOption: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: spacing.sm,
    borderRadius: 12,
    backgroundColor: 'rgba(0,0,0,0.03)',
    marginBottom: spacing.md,
    borderWidth: 1,
    borderColor: 'transparent',
  },
  selectedPayLaterOption: {
    borderColor: colors.primary,
    backgroundColor: 'rgba(244, 128, 93, 0.05)',
  },
  guestPaymentContainer: {
    alignItems: 'center',
    padding: spacing.md,
  },
  guestPaymentIcon: {
    marginBottom: spacing.sm,
  },
  guestPaymentText: {
    textAlign: 'center',
    marginBottom: spacing.md,
  },
  signInButton: {
    marginTop: spacing.sm,
  },
  specialRequestsToggle: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: spacing.sm,
  },
  toggleIcon: {
    marginLeft: spacing.xs,
  },
  specialRequestsContainer: {
    marginTop: spacing.sm,
  },
  specialRequestsLabel: {
    marginBottom: spacing.xs,
  },
  specialRequestsInput: {
    padding: spacing.sm,
    borderRadius: 8,
    backgroundColor: 'rgba(0,0,0,0.03)',
    minHeight: 80,
  },
  summaryCard: {
    padding: spacing.md,
    marginBottom: spacing.md,
    backgroundColor: 'white',
  },
  summaryHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: spacing.sm,
  },
  summaryTitle: {
    marginBottom: 0,
  },
  editButton: {
    padding: spacing.xs,
  },
  summaryContent: {
    
  },
  stylistInfo: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: spacing.sm,
  },
  stylistAvatar: {
    marginRight: spacing.sm,
  },
  stylistDetails: {
    flex: 1,
  },
  divider: {
    height: 1,
    backgroundColor: 'rgba(0,0,0,0.05)',
    marginVertical: spacing.sm,
  },
  serviceInfo: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: spacing.xs,
  },
  serviceDetails: {
    
  },
  serviceDetailItem: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: spacing.xs,
  },
  serviceDetailText: {
    marginLeft: spacing.xs,
  },
  nextButton: {
    marginTop: spacing.md,
    backgroundColor: colors.cream,
    borderWidth: 0,
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

export default BookingScreen;
