# BookingScreen Implementation

This document details the implementation of the enhanced BookingScreen with our new immersive, playful design language.

## Overview

The BookingScreen has been completely redesigned to provide a more engaging, interactive experience for users booking appointments. The screen now features:

1. A step-by-step booking process with visual indicators
2. Full-color background with decorative elements
3. Animated transitions between steps
4. Interactive date and time selection
5. Enhanced payment method selection
6. Booking summary with stylist and service details
7. Special requests option

## Key Components

### Step Indicator

The step indicator provides a visual representation of the booking process:

- Shows the current step (Date, Time, Payment)
- Highlights completed steps with a checkmark
- Connects steps with a line to show progress

```jsx
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
```

### Date Selection

The date selection component allows users to choose a date for their appointment:

- Horizontal scrollable list of dates
- Visual indication of selected date
- Disabled state for unavailable dates

```jsx
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
```

### Time Selection

The time selection component allows users to choose a time for their appointment:

- Grid layout of time slots
- Visual indication of selected time
- Disabled state for unavailable times

```jsx
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
```

### Payment Selection

The payment selection component allows users to choose a payment method:

- List of saved payment methods
- Pay later option
- Visual indication of selected payment method
- Special requests option
- Different view for guest users

```jsx
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
```

### Booking Summary

The booking summary component provides a summary of the booking details:

- Stylist information with avatar
- Service details with price and duration
- Date and time information
- Payment method information

```jsx
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
      {/* Service details */}
    </View>
  </View>
</Card>
```

## Animations

The screen includes smooth animations for a more engaging experience:

```jsx
// Animation values
const fadeAnim = React.useRef(new Animated.Value(0)).current;
const slideAnim = React.useRef(new Animated.Value(50)).current;

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
```

## State Management

The screen uses several state variables to manage the booking process:

```jsx
// State for booking process
const [currentStep, setCurrentStep] = useState(1);
const [selectedDate, setSelectedDate] = useState<number | null>(1);
const [selectedTime, setSelectedTime] = useState<number | null>(null);
const [selectedPayment, setSelectedPayment] = useState<number | null>(1);
const [payLater, setPayLater] = useState(false);
const [specialRequests, setSpecialRequests] = useState('');
const [showSpecialRequests, setShowSpecialRequests] = useState(false);
```

## Navigation

The screen includes navigation functions for moving between steps:

```jsx
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
```

## Styling

The styling uses our new design language with:

- Full-color background with decorative elements
- Bubble-style cards with shadows
- Interactive elements with visual feedback
- Clear visual hierarchy
- Consistent spacing and typography

```jsx
const styles = StyleSheet.create({
  // Header styles
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: spacing.md,
    paddingTop: spacing.lg,
    paddingBottom: spacing.md,
  },
  
  // Step indicator styles
  stepIndicator: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: spacing.xl,
    marginBottom: spacing.md,
    position: 'relative',
  },
  
  // Date selection styles
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
  
  // Time selection styles
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
  
  // Payment selection styles
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
  
  // Decorative elements
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
});
```

## User Flow

1. User arrives at the BookingScreen
2. The screen shows the first step (Date selection)
3. User selects a date and taps Continue
4. The screen shows the second step (Time selection)
5. User selects a time and taps Continue
6. The screen shows the third step (Payment selection)
7. User selects a payment method and taps Confirm Booking
8. User is navigated to the LiveTrackScreen

## Future Enhancements

1. Add calendar view for date selection
2. Implement real-time availability checking
3. Add ability to add new payment methods
4. Implement special requests input
5. Add booking confirmation animation
6. Implement promo code functionality
7. Add ability to book multiple services
8. Implement recurring booking options

## Implementation Notes

- The screen uses the ImmersiveScreen component for the full-color background
- All text on colored backgrounds has appropriate contrast for readability
- The screen is fully scrollable to accommodate various device sizes
- Animations are optimized for performance using useNativeDriver
- The booking process is broken down into clear, manageable steps
- The booking summary provides context throughout the process
- The next button is disabled until the current step is complete
