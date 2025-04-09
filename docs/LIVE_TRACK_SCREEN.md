# LiveTrackScreen Implementation

This document details the implementation of the enhanced LiveTrackScreen with our new immersive, playful design language.

## Overview

The LiveTrackScreen has been completely redesigned to provide a more engaging, interactive experience for users tracking their stylist's arrival. The screen now features:

1. A map-focused interface with animated markers
2. Interactive ETA card with expandable details
3. Quick action buttons for communication and cancellation
4. Tracking updates with timeline visualization
5. Animated transitions and visual feedback
6. Booking details summary

## Key Components

### Map View with Animated Markers

The map view provides a visual representation of the stylist's location and route:

- Stylist marker with avatar and verification badge
- User marker with location indicator
- Route line connecting the markers
- Pulsing animation for the stylist marker

```jsx
{/* Stylist marker */}
<Animated.View 
  style={[
    styles.stylistMarker, 
    { transform: [{ scale: pulseAnim }] }
  ]}
>
  <View style={styles.stylistMarkerInner}>
    <Image 
      source={{ uri: stylist.avatar }} 
      style={styles.stylistAvatar}
    />
    {stylist.verified && (
      <View style={styles.verifiedBadge}>
        <FontAwesome name="check" size={8} color="white" />
      </View>
    )}
  </View>
</Animated.View>
```

### ETA Card with Expandable Details

The ETA card provides information about the stylist's arrival time and can be expanded to show more details:

- ETA countdown with visual feedback
- Stylist information with avatar and rating
- Expandable details with booking information
- Tracking updates with timeline visualization

```jsx
<Card style={styles.etaCard} variant="bubble" withShadow>
  <TouchableOpacity 
    style={styles.etaCardContent}
    onPress={toggleDetails}
    activeOpacity={0.9}
  >
    <View style={styles.etaInfo}>
      <View style={styles.etaHeader}>
        <Typography variant="subheading" style={styles.etaTitle}>
          {eta <= 0 ? 'Your stylist has arrived!' : 'Your stylist is on the way'}
        </Typography>
        <FontAwesome 
          name={showDetails ? "chevron-down" : "chevron-up"} 
          size={16} 
          color={colors.textMuted} 
        />
      </View>
      
      <View style={styles.etaTimeContainer}>
        <View style={styles.etaTimeIconContainer}>
          <FontAwesome name="clock-o" size={20} color={colors.primary} />
        </View>
        <Typography 
          variant="heading" 
          color={eta <= 0 ? colors.success : colors.primary}
          style={styles.etaTime}
        >
          {etaText}
        </Typography>
      </View>
    </View>
    
    <View style={styles.stylistInfo}>
      <Image source={{ uri: stylist.avatar }} style={styles.stylistCardAvatar} />
      <View style={styles.stylistDetails}>
        <Typography variant="bodyMedium" style={styles.stylistName}>
          {stylist.name}
        </Typography>
        <View style={styles.ratingContainer}>
          <FontAwesome name="star" size={14} color="#FFD700" />
          <Typography variant="caption" style={styles.ratingText}>
            {stylist.rating}
          </Typography>
        </View>
      </View>
    </View>
  </TouchableOpacity>
  
  {/* Expanded details */}
  {showDetails && (
    <View style={styles.expandedDetails}>
      {/* Booking details and tracking updates */}
    </View>
  )}
</Card>
```

### Quick Action Buttons

The quick action buttons provide easy access to common interactions:

- Call button to contact the stylist
- Message button to send a message
- Cancel button to cancel the booking

```jsx
<Animated.View 
  style={[
    styles.actionButtons,
    {
      opacity: fadeAnim,
      transform: [{ translateY: slideAnim }]
    }
  ]}
>
  <TouchableOpacity style={styles.actionButton} activeOpacity={0.7}>
    <View style={styles.actionButtonInner}>
      <FontAwesome name="phone" size={20} color={colors.primary} />
    </View>
    <Typography variant="caption" color={colors.textMuted} style={styles.actionText}>
      Call
    </Typography>
  </TouchableOpacity>

  <TouchableOpacity style={styles.actionButton} activeOpacity={0.7}>
    <View style={styles.actionButtonInner}>
      <FontAwesome name="comment" size={20} color={colors.primary} />
    </View>
    <Typography variant="caption" color={colors.textMuted} style={styles.actionText}>
      Message
    </Typography>
  </TouchableOpacity>

  <TouchableOpacity style={styles.actionButton} activeOpacity={0.7}>
    <View style={styles.actionButtonInner}>
      <FontAwesome name="times-circle" size={20} color={colors.error} />
    </View>
    <Typography variant="caption" color={colors.error} style={styles.actionText}>
      Cancel
    </Typography>
  </TouchableOpacity>
</Animated.View>
```

### Tracking Updates

The tracking updates provide a timeline of the booking process:

- Timeline visualization with colored dots
- Update messages with timestamps
- Conditional updates based on ETA

```jsx
<View style={styles.trackingUpdates}>
  <Typography variant="bodyMedium" style={styles.trackingTitle}>
    Tracking Updates
  </Typography>
  
  <View style={styles.updateItem}>
    <View style={[styles.updateDot, { backgroundColor: colors.success }]} />
    <View style={styles.updateContent}>
      <Typography variant="body" style={styles.updateText}>
        Hassan has accepted your booking
      </Typography>
      <Typography variant="caption" color={colors.textMuted}>
        15 minutes ago
      </Typography>
    </View>
  </View>
  
  <View style={styles.updateItem}>
    <View style={[styles.updateDot, { backgroundColor: colors.primary }]} />
    <View style={styles.updateContent}>
      <Typography variant="body" style={styles.updateText}>
        Hassan is on the way to your location
      </Typography>
      <Typography variant="caption" color={colors.textMuted}>
        10 minutes ago
      </Typography>
    </View>
  </View>
  
  {eta <= 5 && (
    <View style={styles.updateItem}>
      <View style={[styles.updateDot, { backgroundColor: colors.info }]} />
      <View style={styles.updateContent}>
        <Typography variant="body" style={styles.updateText}>
          Hassan is almost at your location
        </Typography>
        <Typography variant="caption" color={colors.textMuted}>
          Just now
        </Typography>
      </View>
    </View>
  )}
</View>
```

## Animations

The screen includes smooth animations for a more engaging experience:

```jsx
// Animation values
const fadeAnim = useRef(new Animated.Value(0)).current;
const slideAnim = useRef(new Animated.Value(50)).current;
const pulseAnim = useRef(new Animated.Value(1)).current;

// Start animations when component mounts
useEffect(() => {
  // Start fade and slide animations
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

  // Start pulse animation
  Animated.loop(
    Animated.sequence([
      Animated.timing(pulseAnim, {
        toValue: 1.1,
        duration: 1000,
        useNativeDriver: true,
      }),
      Animated.timing(pulseAnim, {
        toValue: 1,
        duration: 1000,
        useNativeDriver: true,
      }),
    ])
  ).start();
}, []);
```

## State Management

The screen uses several state variables to manage the tracking process:

```jsx
// State for ETA countdown
const [eta, setEta] = useState(15); // Start with 15 minutes
const [etaText, setEtaText] = useState('15 min');
const [showDetails, setShowDetails] = useState(false);
```

## Countdown Logic

The screen includes countdown logic for the ETA:

```jsx
// Countdown ETA
useEffect(() => {
  if (eta <= 0) return;

  const timer = setTimeout(() => {
    setEta(prevEta => {
      const newEta = prevEta - 1;
      
      // Update ETA text
      if (newEta <= 0) {
        setEtaText('Arrived!');
      } else if (newEta === 1) {
        setEtaText('1 min');
      } else {
        setEtaText(`${newEta} mins`);
      }
      
      return newEta;
    });
  }, 60000); // Update every minute

  // For demo purposes, update more frequently
  const demoTimer = setTimeout(() => {
    if (eta > 0) {
      setEtaText(`${eta} min${eta !== 1 ? 's' : ''}`);
    }
  }, 5000);

  return () => {
    clearTimeout(timer);
    clearTimeout(demoTimer);
  };
}, [eta]);
```

## Styling

The styling uses our new design language with:

- Map-focused interface with animated markers
- Bubble-style cards with shadows
- Interactive elements with visual feedback
- Clear visual hierarchy
- Consistent spacing and typography

```jsx
const styles = StyleSheet.create({
  // Map styles
  mapContainer: {
    flex: 1,
    position: 'relative',
  },
  mapPlaceholder: {
    flex: 1,
    backgroundColor: '#f2f2f2',
    position: 'relative',
  },
  
  // Marker styles
  stylistMarker: {
    position: 'absolute',
    top: '40%',
    left: '30%',
    width: 50,
    height: 50,
    justifyContent: 'center',
    alignItems: 'center',
    zIndex: 2,
  },
  
  // Action button styles
  actionButtons: {
    position: 'absolute',
    top: spacing.lg,
    left: spacing.md,
    right: spacing.md,
    flexDirection: 'row',
    justifyContent: 'space-between',
    backgroundColor: 'white',
    borderRadius: 20,
    padding: spacing.sm,
    shadowColor: 'rgba(0,0,0,0.1)',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 4,
    elevation: 3,
    zIndex: 10,
  },
  
  // ETA card styles
  etaCardContainer: {
    position: 'absolute',
    bottom: spacing.lg,
    left: spacing.md,
    right: spacing.md,
    zIndex: 10,
  },
  etaCard: {
    borderRadius: 20,
    backgroundColor: 'white',
    overflow: 'hidden',
  },
  
  // Tracking updates styles
  trackingUpdates: {
    marginTop: spacing.xs,
  },
  updateItem: {
    flexDirection: 'row',
    marginBottom: spacing.sm,
  },
  updateDot: {
    width: 12,
    height: 12,
    borderRadius: 6,
    marginTop: 4,
    marginRight: spacing.sm,
  },
});
```

## User Flow

1. User arrives at the LiveTrackScreen after booking an appointment
2. The screen shows a map with the stylist's location and route
3. The ETA card shows the estimated time of arrival
4. User can tap the ETA card to see more details
5. User can use the action buttons to call, message, or cancel
6. When the stylist arrives, the user is navigated to the Bsse7aScreen

## Future Enhancements

1. Implement real-time location tracking with MapView
2. Add push notifications for tracking updates
3. Implement real-time chat functionality
4. Add route optimization suggestions
5. Implement voice call functionality
6. Add ability to share tracking link with others
7. Implement traffic information for more accurate ETA
8. Add weather information for context

## Implementation Notes

- The screen uses a placeholder map for demo purposes
- In a real app, this would use the MapTracker component with real-time location tracking
- The ETA countdown is simulated for demo purposes
- The tracking updates are static for demo purposes
- The action buttons are non-functional for demo purposes
- The screen includes a "Simulate Arrival" button for demo purposes
- The screen is designed to be visually engaging and informative
- The expandable details provide more information without cluttering the main view
- The timeline visualization provides context for the tracking process
