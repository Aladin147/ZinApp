# Development Journal

This document serves as a running log of development decisions, challenges, and solutions encountered during the ZinApp project.

## July 15, 2023 - UI Component Implementation

### Logo Component Implementation

Today we implemented a versatile Logo component that can display the ZinApp logo in three different variants:

1. **Normal Logo** - The standard logo with dark text for light backgrounds
2. **Inverted Logo** - The logo with light text for dark backgrounds
3. **Standalone Logo** - Just the icon without text

The implementation required setting up SVG support in the project:

```javascript
// metro.config.js
config.transformer = {
  ...transformer,
  babelTransformerPath: require.resolve('react-native-svg-transformer'),
};

config.resolver = {
  ...resolver,
  assetExts: resolver.assetExts.filter((ext) => ext !== 'svg'),
  sourceExts: [...resolver.sourceExts, 'svg'],
};
```

We also created a type declaration file for SVG files:

```typescript
// types/svg.d.ts
declare module '*.svg' {
  import React from 'react';
  import { SvgProps } from 'react-native-svg';
  const content: React.FC<SvgProps>;
  export default content;
}
```

The Logo component itself was designed to be flexible, with support for different sizes and automatic aspect ratio calculation:

```typescript
const Logo: React.FC<LogoProps> = ({
  variant = 'normal',
  width = 150,
  height,
  style,
}) => {
  // Calculate height based on aspect ratio if not provided
  const getHeight = () => {
    if (height) return height;

    // Default aspect ratios for each variant
    switch (variant) {
      case 'normal':
      case 'inverted':
        return width * 0.35; // Approximate aspect ratio for full logo
      case 'standalone':
        return width; // Standalone logo is roughly square
      default:
        return width * 0.35;
    }
  };

  // Get the appropriate logo component based on variant
  const LogoComponent = (): React.FC<SvgProps> => {
    switch (variant) {
      case 'normal':
        return NormalLogo;
      case 'inverted':
        return InvertedLogo;
      case 'standalone':
        return StandaloneLogo;
      default:
        return NormalLogo;
    }
  };

  const SelectedLogo = LogoComponent();
  const calculatedHeight = getHeight();

  return (
    <View style={[styles.container, style]}>
      <SelectedLogo width={width} height={calculatedHeight} />
    </View>
  );
};
```

We also created a LogoShowcaseScreen to demonstrate all logo variants and sizes, which serves as both a demonstration and a reference for developers.

### RatingStars Component Implementation

We implemented a flexible star rating component that supports different sizes, animations, and half-star ratings:

```typescript
const RatingStars: React.FC<RatingStarsProps> = ({
  rating,
  maxRating = 5,
  size = 'medium',
  animated = true,
  style,
  activeColor = colors.primary,
  inactiveColor = colors.gray300,
}) => {
  // Animation values for each star
  const animatedValues = React.useRef(
    Array(maxRating).fill(0).map(() => new Animated.Value(0))
  ).current;

  // Animate stars when component mounts
  useEffect(() => {
    if (animated) {
      const animations = animatedValues.map((value, index) => {
        return Animated.timing(value, {
          toValue: 1,
          duration: 300,
          delay: index * 100, // Stagger the animations
          easing: Easing.out(Easing.back(1.5)),
          useNativeDriver: true,
        });
      });

      Animated.stagger(50, animations).start();
    } else {
      // If not animated, set all values to 1 immediately
      animatedValues.forEach(value => value.setValue(1));
    }
  }, [animated, animatedValues]);

  // Render a single star
  const renderStar = (index: number) => {
    const isFilled = index < Math.floor(rating);
    const isHalfFilled = !isFilled && index < Math.ceil(rating) && rating % 1 !== 0;

    // Determine which icon to use based on the rating
    const iconName = isFilled ? 'star' : (isHalfFilled ? 'star-half-o' : 'star-o');

    return (
      <Animated.View
        key={`star-${index}`}
        style={[styles.starContainer, animatedStyle]}
      >
        <Icon
          name={iconName}
          size={starSize}
          color={isFilled || isHalfFilled ? activeColor : inactiveColor}
          style={styles.starIcon}
        />
      </Animated.View>
    );
  };

  return (
    <View style={[
      styles.container,
      { gap: getStarSpacing() },
      style
    ]}>
      {Array(maxRating).fill(0).map((_, index) => renderStar(index))}
    </View>
  );
};
```

### MapTracker Component Implementation

We implemented a map tracking component with route visualization, ETA display, and stylist information:

```typescript
const MapTracker: React.FC<MapTrackerProps> = ({
  stylistLocation,
  userLocation,
  eta,
  stylistAvatar,
  stylistName = 'Your Stylist',
  isVerified = false,
  waypoints = [],
  onArrival,
}) => {
  // Reference to the map view
  const mapRef = useRef<MapView>(null);

  // Animation value for the pulsing effect on the user marker
  const pulseAnim = useRef(new Animated.Value(0.5)).current;

  // State to track if the stylist has arrived
  const [hasArrived, setHasArrived] = useState(false);

  // Calculate the route coordinates including waypoints
  const routeCoordinates = [
    stylistLocation,
    ...waypoints,
    userLocation,
  ];

  // Start the pulsing animation for the user marker
  useEffect(() => {
    Animated.loop(
      Animated.sequence([
        Animated.timing(pulseAnim, {
          toValue: 1,
          duration: 1000,
          useNativeDriver: true,
        }),
        Animated.timing(pulseAnim, {
          toValue: 0.5,
          duration: 1000,
          useNativeDriver: true,
        }),
      ])
    ).start();
  }, [pulseAnim]);

  // Check if the stylist has arrived (when ETA reaches 0)
  useEffect(() => {
    if (eta <= 0 && !hasArrived) {
      setHasArrived(true);
      if (onArrival) {
        onArrival();
      }
    }
  }, [eta, hasArrived, onArrival]);

  // Fit the map to show both markers when the component mounts
  useEffect(() => {
    if (mapRef.current) {
      mapRef.current.fitToCoordinates(routeCoordinates, {
        edgePadding: { top: 50, right: 50, bottom: 50, left: 50 },
        animated: true,
      });
    }
  }, [routeCoordinates]);

  return (
    <View style={styles.container}>
      {/* Map View */}
      <MapView
        ref={mapRef}
        style={styles.map}
        provider={PROVIDER_GOOGLE}
        initialRegion={{
          latitude: userLocation.latitude,
          longitude: userLocation.longitude,
          latitudeDelta: 0.01,
          longitudeDelta: 0.01,
        }}
      >
        {/* Stylist Marker */}
        <Marker
          coordinate={stylistLocation}
          title={stylistName}
          description={hasArrived ? 'Has arrived' : `${eta} min away`}
        >
          <View style={styles.stylistMarker}>
            <Image
              source={avatarSource}
              style={styles.stylistAvatar}
              resizeMode="cover"
            />
            {isVerified && (
              <View style={styles.verifiedBadge}>
                <Typography variant="caption" color="white" style={styles.verifiedText}>
                  ✓
                </Typography>
              </View>
            )}
          </View>
        </Marker>

        {/* User Marker (Destination) */}
        <Marker coordinate={userLocation} title="Your Location">
          <Animated.View
            style={[
              styles.userMarker,
              {
                transform: [{ scale: pulseAnim }],
              },
            ]}
          >
            <View style={styles.userMarkerInner} />
          </Animated.View>
        </Marker>

        {/* Route Line */}
        <Polyline
          coordinates={routeCoordinates}
          strokeWidth={4}
          strokeColor={colors.primary}
          lineDashPattern={[1, 0]}
        />
      </MapView>

      {/* ETA Card */}
      <Card
        variant="elevated"
        padding="medium"
        style={styles.etaCard}
      >
        <View style={styles.etaHeader}>
          <Typography variant="sectionHeader">
            {hasArrived ? 'Stylist has arrived!' : `ETA: ${eta} minutes`}
          </Typography>
          <View style={styles.etaIcon}>
            <Icon name="clock-o" size={20} color={colors.primary} />
          </View>
        </View>

        <View style={styles.stylistInfo}>
          <Image
            source={avatarSource}
            style={styles.cardAvatar}
            resizeMode="cover"
          />
          <View style={styles.stylistDetails}>
            <Typography variant="body">
              {stylistName}
            </Typography>
            <Typography variant="caption" color={colors.textMuted}>
              {hasArrived ? 'Ready to start' : 'On the way'}
            </Typography>
          </View>
        </View>
      </Card>
    </View>
  );
};
```

### BookingCard Component Implementation

We implemented a comprehensive booking card component with support for different booking statuses, stylist information, and action buttons:

```typescript
const BookingCard: React.FC<BookingCardProps> = ({
  booking,
  stylist,
  service,
  onPress,
}) => {
  // Format date and time for display
  const bookingDate = new Date(booking.datetime).toLocaleDateString('en-US', {
    weekday: 'short',
    month: 'short',
    day: 'numeric'
  });

  const bookingTime = new Date(booking.datetime).toLocaleTimeString('en-US', {
    hour: '2-digit',
    minute: '2-digit',
    hour12: true
  });

  // Determine if booking is completed
  const isCompleted = booking.status === 'completed';

  // Determine if booking is active (en_route or arrived)
  const isActive = booking.status === 'en_route' || booking.status === 'arrived';

  // Get status color based on booking status
  const getStatusColor = () => {
    switch (booking.status) {
      case 'confirmed':
        return colors.info;
      case 'en_route':
      case 'arrived':
        return colors.primary;
      case 'completed':
        return colors.success;
      case 'canceled':
        return colors.error;
      default:
        return colors.textMuted;
    }
  };

  return (
    <Card
      variant="warm"
      padding="medium"
      style={styles.card}
      onPress={onPress}
    >
      {/* Header with stylist info and status */}
      <View style={styles.header}>
        <View style={styles.stylistContainer}>
          <View style={styles.avatarContainer}>
            <Image
              source={imageSource}
              style={styles.avatar}
              resizeMode="cover"
            />
            {stylist?.verified && (
              <View style={styles.verifiedBadge}>
                <Typography variant="caption" color="white" align="center" style={styles.verifiedText}>
                  ✓
                </Typography>
              </View>
            )}
          </View>

          <View style={styles.stylistInfo}>
            <Typography variant="sectionHeader">
              {stylist?.name || `Stylist #${booking.stylist_id}`}
            </Typography>

            {stylist?.rating && (
              <View style={styles.ratingContainer}>
                <RatingStars rating={stylist.rating} size="small" />
                <Typography variant="caption" style={styles.ratingText}>
                  {stylist.rating.toFixed(1)}
                </Typography>
              </View>
            )}
          </View>
        </View>

        <View style={[styles.statusBadge, { backgroundColor: getStatusColor() }]}>
          <Typography variant="caption" color="white">
            {getStatusText()}
          </Typography>
        </View>
      </View>

      {/* Service details */}
      <View style={styles.serviceContainer}>
        <View style={styles.serviceInfo}>
          <Typography variant="body">
            {service?.name || `Service #${booking.service_id}`}
          </Typography>

          <Typography variant="caption" color={colors.textMuted}>
            {bookingDate} at {bookingTime}
          </Typography>
        </View>

        {service?.price && (
          <Typography variant="bodyMedium">
            {service.price} MAD
          </Typography>
        )}
      </View>

      {/* Footer with action buttons for completed bookings */}
      {isCompleted && (
        <View style={styles.footer}>
          <Button
            title="Rebook"
            variant="primary"
            size="small"
            iconName="refresh"
            iconPosition="left"
            onPress={handleRebook}
          />

          {!booking.rating_given && (
            <Button
              title="Rate"
              variant="outline"
              size="small"
              iconName="star"
              iconPosition="left"
              onPress={onPress}
              style={styles.rateButton}
            />
          )}
        </View>
      )}

      {/* Active booking indicator */}
      {isActive && (
        <View style={styles.activeIndicator}>
          <Icon name="location-arrow" size={14} color={colors.primary} style={styles.activeIcon} />
          <Typography variant="caption" color={colors.primary}>
            Track your stylist
          </Typography>
        </View>
      )}
    </Card>
  );
};
```

## Challenges and Solutions

### SVG Support

**Challenge**: Setting up SVG support in React Native can be tricky, especially with TypeScript.

**Solution**: We used react-native-svg-transformer to transform SVG files into React components, and created a type declaration file to avoid TypeScript errors.

### Component Flexibility

**Challenge**: Creating components that are flexible enough to handle different use cases while maintaining a consistent design.

**Solution**: We used a props-based approach with sensible defaults, allowing components to be customized while maintaining design consistency.

### Animation Performance

**Challenge**: Ensuring smooth animations, especially on older devices.

**Solution**: We used React Native's Animated API with useNativeDriver: true for better performance, and implemented staggered animations to reduce the load on the JavaScript thread.

## July 16, 2023 - Avatar Component Implementation

Today we implemented the Avatar component to display user profile images with verification badges. This component is a key part of the UI enhancement plan, providing a consistent way to display user avatars throughout the app.

### Avatar Component Implementation

The Avatar component was designed to be flexible and reusable, with support for different sizes, verification badges, and custom styling:

```typescript
const Avatar: React.FC<AvatarProps> = ({
  source,
  size = 'medium',
  verified = false,
  style,
  imageStyle,
  backgroundColor = colors.gray200,
  borderColor,
}) => {
  // Get size dimensions based on size prop
  const getDimensions = () => {
    switch (size) {
      case 'small':
        return {
          container: 40,
          badge: 16,
          badgeText: 10,
        };
      case 'medium':
        return {
          container: 60,
          badge: 20,
          badgeText: 12,
        };
      case 'large':
        return {
          container: 100,
          badge: 24,
          badgeText: 14,
        };
      default:
        return {
          container: 60,
          badge: 20,
          badgeText: 12,
        };
    }
  };

  const dimensions = getDimensions();

  return (
    <View style={[styles.container, containerStyle, style]}>
      <Image
        source={source}
        style={[styles.image, imageDimensions, imageStyle]}
        resizeMode="cover"
      />

      {verified && (
        <View style={[styles.verifiedBadge, badgeStyle]}>
          <Typography
            variant="caption"
            color="white"
            align="center"
            style={{ fontSize: dimensions.badgeText }}
          >
            ✓
          </Typography>
        </View>
      )}
    </View>
  );
};
```

We also created an AvatarShowcaseScreen to demonstrate the different variants and sizes of the Avatar component. This screen serves as both a demonstration and a reference for developers.

### Key Features

1. **Size Variants**: The Avatar component supports three sizes - small (40px), medium (60px), and large (100px).
2. **Verification Badge**: A blue verification badge can be displayed for verified users, following the design specification that Cool Blue Slate should be used for stylist-related elements.
3. **Custom Styling**: The component supports custom background and border colors, allowing for flexible usage in different contexts.
4. **Consistent Design**: The component follows the design specifications with circular avatars and proper styling for the verification badge.

### Next Steps

1. **Replace Image Instances**: Replace all image instances for avatars with the Avatar component throughout the app.
2. **QRScanner Component**: Implement the QRScanner component using the Expo Camera or Barcode Scanner API.
3. **Update Remaining Screens**: Complete the BarberProfileScreen, BookingScreen, and Bsse7aScreen.
4. **Animation System**: Implement a consistent animation system using Reanimated 2.
5. **Typography Improvements**: Fix font family to use Uber Move with fallbacks to Inter/Satoshi.
6. **Demo Mode Indicator**: Add a visual indicator for demo mode.
