# ZinApp V2 Interaction Patterns

This document provides guidelines on micro-interactions, gestures, button tap feedback, and other interactive elements in ZinApp V2.

## Interaction Philosophy

ZinApp V2 interactions are designed to be:

1. **Responsive**: Provide immediate feedback to user actions
2. **Intuitive**: Follow platform conventions and user expectations
3. **Delightful**: Add subtle animations and effects that enhance the experience
4. **Consistent**: Maintain the same interaction patterns throughout the app
5. **Accessible**: Ensure all interactions are accessible to all users

## Touch Feedback

### Button Press Feedback

All interactive elements should provide visual feedback when pressed:

#### Standard Button Press

- **Visual Change**: Scale to 0.98 of original size
- **Color Change**: Slight darkening of background color (10-15%)
- **Duration**: 100ms for press in, 200ms for release
- **Easing**: Spring effect on release for subtle bounce back

```typescript
// Button press animation
const ButtonPressAnimation = ({ children }) => {
  const scale = useRef(new Animated.Value(1)).current;
  const opacity = useRef(new Animated.Value(1)).current;

  const handlePressIn = () => {
    Animated.parallel([
      Animated.spring(scale, {
        toValue: 0.98,
        tension: 300,
        friction: 10,
        useNativeDriver: true
      }),
      Animated.timing(opacity, {
        toValue: 0.9,
        duration: 100,
        useNativeDriver: true
      })
    ]).start();
  };

  const handlePressOut = () => {
    Animated.parallel([
      Animated.spring(scale, {
        toValue: 1,
        tension: 200,
        friction: 15,
        useNativeDriver: true
      }),
      Animated.timing(opacity, {
        toValue: 1,
        duration: 200,
        useNativeDriver: true
      })
    ]).start();
  };

  return (
    <Pressable
      onPressIn={handlePressIn}
      onPressOut={handlePressOut}
    >
      <Animated.View
        style={{
          transform: [{ scale }],
          opacity
        }}
      >
        {children}
      </Animated.View>
    </Pressable>
  );
};
```

#### Primary CTA Button Press

- **Visual Change**: Scale to 0.97 of original size
- **Color Change**: Darkening of background color (15-20%)
- **Duration**: 100ms for press in, 300ms for release
- **Easing**: Spring effect on release with more pronounced bounce
- **Additional Effect**: Optional highlight pulse after successful action

```typescript
// Primary CTA button press animation
const PrimaryCTAButtonPressAnimation = ({ children, onPress, onSuccess }) => {
  const scale = useRef(new Animated.Value(1)).current;
  const backgroundColor = useRef(new Animated.Value(0)).current;
  const successPulse = useRef(new Animated.Value(1)).current;

  const handlePressIn = () => {
    Animated.parallel([
      Animated.spring(scale, {
        toValue: 0.97,
        tension: 300,
        friction: 10,
        useNativeDriver: true
      }),
      Animated.timing(backgroundColor, {
        toValue: 1,
        duration: 100,
        useNativeDriver: false
      })
    ]).start();
  };

  const handlePressOut = () => {
    Animated.parallel([
      Animated.spring(scale, {
        toValue: 1,
        tension: 200,
        friction: 15,
        useNativeDriver: true
      }),
      Animated.timing(backgroundColor, {
        toValue: 0,
        duration: 300,
        useNativeDriver: false
      })
    ]).start();
  };

  const handlePress = () => {
    onPress();
    // If action is successful, trigger success animation
    if (onSuccess) {
      Animated.sequence([
        Animated.timing(successPulse, {
          toValue: 1.1,
          duration: 150,
          useNativeDriver: true
        }),
        Animated.timing(successPulse, {
          toValue: 1,
          duration: 300,
          useNativeDriver: true
        })
      ]).start();
    }
  };

  const interpolatedBackgroundColor = backgroundColor.interpolate({
    inputRange: [0, 1],
    outputRange: [colors.primary, colors.primary.darken(0.2)]
  });

  return (
    <Pressable
      onPressIn={handlePressIn}
      onPressOut={handlePressOut}
      onPress={handlePress}
    >
      <Animated.View
        style={{
          transform: [
            { scale },
            { scale: successPulse }
          ],
          backgroundColor: interpolatedBackgroundColor
        }}
      >
        {children}
      </Animated.View>
    </Pressable>
  );
};
```

### Card Press Feedback

Interactive cards should provide visual feedback when pressed:

- **Visual Change**: Scale to 0.98 of original size
- **Elevation Change**: Increase shadow elevation slightly
- **Duration**: 100ms for press in, 200ms for release
- **Easing**: Spring effect on release

```typescript
// Card press animation
const CardPressAnimation = ({ children, onPress }) => {
  const scale = useRef(new Animated.Value(1)).current;
  const elevation = useRef(new Animated.Value(1)).current;

  const handlePressIn = () => {
    Animated.parallel([
      Animated.spring(scale, {
        toValue: 0.98,
        tension: 300,
        friction: 10,
        useNativeDriver: true
      }),
      Animated.timing(elevation, {
        toValue: 2,
        duration: 100,
        useNativeDriver: false
      })
    ]).start();
  };

  const handlePressOut = () => {
    Animated.parallel([
      Animated.spring(scale, {
        toValue: 1,
        tension: 200,
        friction: 15,
        useNativeDriver: true
      }),
      Animated.timing(elevation, {
        toValue: 1,
        duration: 200,
        useNativeDriver: false
      })
    ]).start();
  };

  return (
    <Pressable
      onPressIn={handlePressIn}
      onPressOut={handlePressOut}
      onPress={onPress}
    >
      <Animated.View
        style={{
          transform: [{ scale }],
          ...getElevation(elevation)
        }}
      >
        {children}
      </Animated.View>
    </Pressable>
  );
};

// Helper function to get elevation style
const getElevation = (elevation) => {
  const interpolatedElevation = elevation.interpolate({
    inputRange: [1, 2],
    outputRange: [2, 4]
  });

  return {
    shadowOpacity: 0.15,
    shadowRadius: interpolatedElevation,
    shadowOffset: {
      width: 0,
      height: interpolatedElevation / 2
    },
    elevation: interpolatedElevation
  };
};
```

### List Item Press Feedback

List items should provide visual feedback when pressed:

- **Visual Change**: Background color change
- **Duration**: 100ms for press in, 200ms for release
- **Easing**: Ease in/out

```typescript
// List item press animation
const ListItemPressAnimation = ({ children, onPress }) => {
  const backgroundColor = useRef(new Animated.Value(0)).current;

  const handlePressIn = () => {
    Animated.timing(backgroundColor, {
      toValue: 1,
      duration: 100,
      useNativeDriver: false
    }).start();
  };

  const handlePressOut = () => {
    Animated.timing(backgroundColor, {
      toValue: 0,
      duration: 200,
      useNativeDriver: false
    }).start();
  };

  const interpolatedBackgroundColor = backgroundColor.interpolate({
    inputRange: [0, 1],
    outputRange: ['transparent', 'rgba(210, 255, 77, 0.1)']
  });

  return (
    <Pressable
      onPressIn={handlePressIn}
      onPressOut={handlePressOut}
      onPress={onPress}
    >
      <Animated.View
        style={{
          backgroundColor: interpolatedBackgroundColor
        }}
      >
        {children}
      </Animated.View>
    </Pressable>
  );
};
```

## Gesture Interactions

### Swipe Gestures

#### Swipe to Dismiss

Used for dismissing cards, notifications, or modals:

- **Trigger**: Horizontal swipe beyond threshold (40% of width)
- **Feedback**: Card follows finger with slight resistance
- **Completion**: Card continues off-screen with acceleration
- **Cancellation**: Card springs back to original position if below threshold

```typescript
// Swipe to dismiss animation
const SwipeToDismiss = ({ children, onDismiss }) => {
  const translateX = useRef(new Animated.Value(0)).current;
  const panResponder = useRef(
    PanResponder.create({
      onMoveShouldSetPanResponder: (_, gestureState) => {
        return Math.abs(gestureState.dx) > 10;
      },
      onPanResponderMove: (_, gestureState) => {
        translateX.setValue(gestureState.dx);
      },
      onPanResponderRelease: (_, gestureState) => {
        const threshold = width * 0.4;

        if (Math.abs(gestureState.dx) > threshold) {
          // Dismiss
          Animated.timing(translateX, {
            toValue: gestureState.dx > 0 ? width : -width,
            duration: 300,
            useNativeDriver: true
          }).start(onDismiss);
        } else {
          // Return to original position
          Animated.spring(translateX, {
            toValue: 0,
            tension: 120,
            friction: 12,
            useNativeDriver: true
          }).start();
        }
      }
    })
  ).current;

  return (
    <Animated.View
      {...panResponder.panHandlers}
      style={{
        transform: [{ translateX }]
      }}
    >
      {children}
    </Animated.View>
  );
};
```

#### Swipe to Reveal Actions

Used for revealing actions on list items:

- **Trigger**: Horizontal swipe
- **Feedback**: Item slides to reveal actions underneath
- **Threshold**: Actions fully revealed at 30% of width
- **Cancellation**: Item springs back if released before threshold

```typescript
// Swipe to reveal actions
const SwipeToRevealActions = ({ children, leftActions, rightActions }) => {
  const translateX = useRef(new Animated.Value(0)).current;
  const panResponder = useRef(
    PanResponder.create({
      onMoveShouldSetPanResponder: (_, gestureState) => {
        return Math.abs(gestureState.dx) > 10;
      },
      onPanResponderMove: (_, gestureState) => {
        // Limit the swipe distance
        const maxSwipe = rightActions ? 100 : 0;
        const minSwipe = leftActions ? -100 : 0;

        let newX = gestureState.dx;
        if (newX > maxSwipe) newX = maxSwipe;
        if (newX < minSwipe) newX = minSwipe;

        translateX.setValue(newX);
      },
      onPanResponderRelease: (_, gestureState) => {
        const threshold = 30;

        if (gestureState.dx > threshold && rightActions) {
          // Snap to right actions
          Animated.spring(translateX, {
            toValue: 100,
            tension: 120,
            friction: 12,
            useNativeDriver: true
          }).start();
        } else if (gestureState.dx < -threshold && leftActions) {
          // Snap to left actions
          Animated.spring(translateX, {
            toValue: -100,
            tension: 120,
            friction: 12,
            useNativeDriver: true
          }).start();
        } else {
          // Return to original position
          Animated.spring(translateX, {
            toValue: 0,
            tension: 120,
            friction: 12,
            useNativeDriver: true
          }).start();
        }
      }
    })
  ).current;

  return (
    <View style={{ position: 'relative' }}>
      {leftActions && (
        <View style={{ position: 'absolute', right: 0, top: 0, bottom: 0 }}>
          {leftActions}
        </View>
      )}
      {rightActions && (
        <View style={{ position: 'absolute', left: 0, top: 0, bottom: 0 }}>
          {rightActions}
        </View>
      )}
      <Animated.View
        {...panResponder.panHandlers}
        style={{
          transform: [{ translateX }],
          zIndex: 1
        }}
      >
        {children}
      </Animated.View>
    </View>
  );
};
```

### Pull to Refresh

Used for refreshing content:

- **Trigger**: Pull down from top of scrollable content
- **Feedback**: Visual indicator shows pull progress
- **Threshold**: Refresh triggered at specific pull distance
- **Animation**: Loading spinner animation during refresh
- **Completion**: Content slides back into place with spring effect

```typescript
// Custom pull to refresh component
const PullToRefresh = ({ onRefresh, children }) => {
  const scrollY = useRef(new Animated.Value(0)).current;
  const refreshing = useRef(new Animated.Value(0)).current;

  const handleScroll = Animated.event(
    [{ nativeEvent: { contentOffset: { y: scrollY } } }],
    { useNativeDriver: true }
  );

  const handleRelease = () => {
    if (scrollY._value < -60) {
      // Trigger refresh
      refreshing.setValue(1);
      onRefresh().then(() => {
        Animated.timing(refreshing, {
          toValue: 0,
          duration: 300,
          useNativeDriver: true
        }).start();
      });
    }
  };

  const indicatorOpacity = scrollY.interpolate({
    inputRange: [-100, -50, 0],
    outputRange: [1, 1, 0],
    extrapolate: 'clamp'
  });

  const indicatorRotation = scrollY.interpolate({
    inputRange: [-100, 0],
    outputRange: ['180deg', '0deg'],
    extrapolate: 'clamp'
  });

  return (
    <View style={{ flex: 1 }}>
      <Animated.View
        style={{
          position: 'absolute',
          top: 10,
          left: 0,
          right: 0,
          alignItems: 'center',
          opacity: indicatorOpacity,
          transform: [{ rotate: indicatorRotation }]
        }}
      >
        <RefreshIndicator refreshing={refreshing} />
      </Animated.View>

      <ScrollView
        onScroll={handleScroll}
        onScrollEndDrag={handleRelease}
        scrollEventThrottle={16}
        contentContainerStyle={{
          paddingTop: 10
        }}
      >
        {children}
      </ScrollView>
    </View>
  );
};

// Refresh indicator component
const RefreshIndicator = ({ refreshing }) => {
  const rotation = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    if (refreshing._value === 1) {
      Animated.loop(
        Animated.timing(rotation, {
          toValue: 1,
          duration: 1000,
          easing: Easing.linear,
          useNativeDriver: true
        })
      ).start();
    } else {
      rotation.setValue(0);
    }
  }, [refreshing._value]);

  const spin = rotation.interpolate({
    inputRange: [0, 1],
    outputRange: ['0deg', '360deg']
  });

  return (
    <Animated.View
      style={{
        transform: [{ rotate: spin }]
      }}
    >
      <Icon name="refresh" size={24} color={colors.primary} />
    </Animated.View>
  );
};

### Drag and Drop

Used for reordering items or moving items between containers:

- **Trigger**: Long press followed by drag
- **Feedback**: Item scales up slightly and increases elevation
- **During Drag**: Item follows finger with slight lag for natural feel
- **Drop Zones**: Highlight potential drop areas when item is dragged over
- **Completion**: Item animates to final position with spring effect

```typescript
// Drag and drop component
const DragAndDrop = ({ items, onReorder }) => {
  const [dragging, setDragging] = useState(null);
  const itemRefs = useRef({});
  const panResponder = useRef(
    PanResponder.create({
      onStartShouldSetPanResponder: () => false,
      onMoveShouldSetPanResponder: () => false,
      onStartShouldSetPanResponderCapture: () => false,
      onMoveShouldSetPanResponderCapture: () => false,
      onLongPress: (_, gestureState) => {
        // Find which item was long-pressed
        Object.keys(itemRefs.current).forEach(key => {
          itemRefs.current[key].measure((x, y, width, height, pageX, pageY) => {
            if (
              gestureState.x0 >= pageX &&
              gestureState.x0 <= pageX + width &&
              gestureState.y0 >= pageY &&
              gestureState.y0 <= pageY + height
            ) {
              setDragging(key);
            }
          });
        });
      },
      onPanResponderMove: (_, gestureState) => {
        if (dragging) {
          // Update position of dragged item
          // Check for potential drop zones
        }
      },
      onPanResponderRelease: () => {
        if (dragging) {
          // Finalize the reorder
          onReorder(dragging, newPosition);
          setDragging(null);
        }
      }
    })
  ).current;

  return (
    <View {...panResponder.panHandlers}>
      {items.map((item, index) => (
        <Animated.View
          key={item.id}
          ref={ref => (itemRefs.current[item.id] = ref)}
          style={{
            transform: [
              { scale: dragging === item.id ? 1.05 : 1 },
              { translateX: dragging === item.id ? dragX : 0 },
              { translateY: dragging === item.id ? dragY : 0 }
            ],
            zIndex: dragging === item.id ? 1 : 0,
            ...getElevation(dragging === item.id ? 3 : 1)
          }}
        >
          {item.content}
        </Animated.View>
      ))}
    </View>
  );
};

### Pinch to Zoom

Used for zooming images or maps:

- **Trigger**: Two-finger pinch gesture
- **Feedback**: Content scales according to pinch distance
- **Constraints**: Minimum and maximum zoom levels
- **Reset**: Double-tap to reset zoom level

```typescript
// Pinch to zoom component
const PinchToZoom = ({ children }) => {
  const baseScale = useRef(new Animated.Value(1)).current;
  const pinchScale = useRef(new Animated.Value(1)).current;
  const scale = Animated.multiply(baseScale, pinchScale);
  const lastScale = useRef(1);

  const panResponder = useRef(
    PanResponder.create({
      onStartShouldSetPanResponder: () => true,
      onStartShouldSetPanResponderCapture: () => true,
      onMoveShouldSetPanResponder: () => true,
      onMoveShouldSetPanResponderCapture: () => true,
      onPanResponderGrant: () => {
        pinchScale.setValue(1);
      },
      onPanResponderMove: (_, gestureState) => {
        if (gestureState.numberActiveTouches === 2) {
          // Calculate distance between touches
          const dx = Math.abs(gestureState.dx);
          const dy = Math.abs(gestureState.dy);
          const distance = Math.sqrt(dx * dx + dy * dy);

          // Calculate scale based on distance
          const newScale = distance / initialDistance;
          pinchScale.setValue(newScale);
        }
      },
      onPanResponderRelease: () => {
        // Update base scale
        lastScale.current = lastScale.current * pinchScale._value;
        baseScale.setValue(lastScale.current);
        pinchScale.setValue(1);

        // Constrain scale within limits
        if (lastScale.current < 1) {
          lastScale.current = 1;
          Animated.spring(baseScale, {
            toValue: 1,
            tension: 120,
            friction: 12,
            useNativeDriver: true
          }).start();
        } else if (lastScale.current > 3) {
          lastScale.current = 3;
          Animated.spring(baseScale, {
            toValue: 3,
            tension: 120,
            friction: 12,
            useNativeDriver: true
          }).start();
        }
      }
    })
  ).current;

  const handleDoubleTap = () => {
    // Reset zoom level
    lastScale.current = 1;
    Animated.spring(baseScale, {
      toValue: 1,
      tension: 120,
      friction: 12,
      useNativeDriver: true
    }).start();
  };

  return (
    <TapGestureHandler
      onHandlerStateChange={({ nativeEvent }) => {
        if (nativeEvent.state === State.ACTIVE) {
          handleDoubleTap();
        }
      }}
      numberOfTaps={2}
    >
      <Animated.View {...panResponder.panHandlers}>
        <Animated.View
          style={{
            transform: [{ scale }]
          }}
        >
          {children}
        </Animated.View>
      </Animated.View>
    </TapGestureHandler>
  );
};
```

## Form Interactions

### Input Focus

When a text input receives focus:

- **Visual Change**: Border color changes to primary highlight (#D2FF4D)
- **Animation**: Border width increases slightly
- **Label Animation**: Label scales and moves to top position
- **Duration**: 200ms with ease-in-out easing

```typescript
// Input focus animation
const AnimatedInput = ({ label, ...props }) => {
  const [focused, setFocused] = useState(false);
  const [value, setValue] = useState('');
  const hasValue = value.length > 0;

  const borderColor = useRef(new Animated.Value(0)).current;
  const borderWidth = useRef(new Animated.Value(1)).current;
  const labelPosition = useRef(new Animated.Value(hasValue || focused ? 1 : 0)).current;
  const labelScale = useRef(new Animated.Value(hasValue || focused ? 0.8 : 1)).current;

  useEffect(() => {
    Animated.parallel([
      Animated.timing(borderColor, {
        toValue: focused ? 1 : 0,
        duration: 200,
        useNativeDriver: false
      }),
      Animated.timing(borderWidth, {
        toValue: focused ? 2 : 1,
        duration: 200,
        useNativeDriver: false
      }),
      Animated.timing(labelPosition, {
        toValue: focused || hasValue ? 1 : 0,
        duration: 200,
        useNativeDriver: true
      }),
      Animated.timing(labelScale, {
        toValue: focused || hasValue ? 0.8 : 1,
        duration: 200,
        useNativeDriver: true
      })
    ]).start();
  }, [focused, hasValue]);

  const interpolatedBorderColor = borderColor.interpolate({
    inputRange: [0, 1],
    outputRange: [colors.text.secondary, colors.primary]
  });

  return (
    <View style={{ marginVertical: 8 }}>
      <Animated.Text
        style={{
          position: 'absolute',
          left: 12,
          top: 16,
          fontSize: typography.sizes.body,
          color: focused ? colors.primary : colors.text.secondary,
          transform: [
            {
              translateY: labelPosition.interpolate({
                inputRange: [0, 1],
                outputRange: [0, -20]
              })
            },
            { scale: labelScale }
          ],
          zIndex: 1
        }}
      >
        {label}
      </Animated.Text>

      <TextInput
        style={{
          borderWidth: borderWidth,
          borderColor: interpolatedBorderColor,
          borderRadius: borderRadius.input,
          padding: spacing.inputPadding,
          paddingTop: hasValue || focused ? spacing.inputPadding + 4 : spacing.inputPadding,
          fontSize: typography.sizes.body,
          color: colors.text.primary
        }}
        onFocus={() => setFocused(true)}
        onBlur={() => setFocused(false)}
        onChangeText={text => setValue(text)}
        value={value}
        {...props}
      />
    </View>
  );
};

### Toggle Switch

When a toggle switch is pressed:

- **Visual Change**: Thumb slides from off to on position
- **Color Change**: Background color changes to primary highlight
- **Animation**: Slight bounce effect at end of slide
- **Duration**: 200ms with ease-in-out easing

```typescript
// Toggle switch animation
const ToggleSwitch = ({ value, onValueChange }) => {
  const thumbPosition = useRef(new Animated.Value(value ? 1 : 0)).current;
  const backgroundColor = useRef(new Animated.Value(value ? 1 : 0)).current;

  useEffect(() => {
    Animated.parallel([
      Animated.spring(thumbPosition, {
        toValue: value ? 1 : 0,
        tension: 120,
        friction: 12,
        useNativeDriver: true
      }),
      Animated.timing(backgroundColor, {
        toValue: value ? 1 : 0,
        duration: 200,
        useNativeDriver: false
      })
    ]).start();
  }, [value]);

  const interpolatedBackgroundColor = backgroundColor.interpolate({
    inputRange: [0, 1],
    outputRange: [colors.text.disabled, colors.primary]
  });

  return (
    <Pressable
      onPress={() => onValueChange(!value)}
      style={{
        width: 50,
        height: 30,
        borderRadius: 15,
        padding: 2,
        justifyContent: 'center'
      }}
    >
      <Animated.View
        style={{
          width: '100%',
          height: '100%',
          borderRadius: 15,
          backgroundColor: interpolatedBackgroundColor
        }}
      >
        <Animated.View
          style={{
            width: 26,
            height: 26,
            borderRadius: 13,
            backgroundColor: colors.text.primary,
            transform: [
              {
                translateX: thumbPosition.interpolate({
                  inputRange: [0, 1],
                  outputRange: [0, 20]
                })
              }
            ]
          }}
        />
      </Animated.View>
    </Pressable>
  );
};
```

### Checkbox

When a checkbox is pressed:

- **Visual Change**: Check mark appears with fade-in animation
- **Border Change**: Border color changes to primary highlight
- **Animation**: Slight scale bounce effect
- **Duration**: 200ms with ease-in-out easing

```typescript
// Checkbox animation
const Checkbox = ({ value, onValueChange, label }) => {
  const checkOpacity = useRef(new Animated.Value(value ? 1 : 0)).current;
  const borderColor = useRef(new Animated.Value(value ? 1 : 0)).current;
  const scale = useRef(new Animated.Value(1)).current;

  useEffect(() => {
    Animated.parallel([
      Animated.timing(checkOpacity, {
        toValue: value ? 1 : 0,
        duration: 200,
        useNativeDriver: true
      }),
      Animated.timing(borderColor, {
        toValue: value ? 1 : 0,
        duration: 200,
        useNativeDriver: false
      }),
      Animated.sequence([
        Animated.timing(scale, {
          toValue: 0.8,
          duration: 100,
          useNativeDriver: true
        }),
        Animated.timing(scale, {
          toValue: 1,
          duration: 100,
          useNativeDriver: true
        })
      ])
    ]).start();
  }, [value]);

  const interpolatedBorderColor = borderColor.interpolate({
    inputRange: [0, 1],
    outputRange: [colors.text.secondary, colors.primary]
  });

  return (
    <Pressable
      onPress={() => onValueChange(!value)}
      style={{
        flexDirection: 'row',
        alignItems: 'center',
        marginVertical: 8
      }}
    >
      <Animated.View
        style={{
          width: 24,
          height: 24,
          borderWidth: 2,
          borderColor: interpolatedBorderColor,
          borderRadius: 4,
          justifyContent: 'center',
          alignItems: 'center',
          marginRight: 8,
          transform: [{ scale }]
        }}
      >
        <Animated.View
          style={{
            opacity: checkOpacity,
            width: 12,
            height: 12,
            backgroundColor: colors.primary,
            borderRadius: 2
          }}
        />
      </Animated.View>

      <Text style={{ fontSize: typography.sizes.body, color: colors.text.primary }}>
        {label}
      </Text>
    </Pressable>
  );
};
```

## Feedback Interactions

### Toast Notifications

When a toast notification appears:

- **Entrance**: Slides up from bottom with fade-in
- **Duration**: Visible for 3 seconds by default
- **Exit**: Slides down with fade-out
- **Interaction**: Swipeable to dismiss early

```typescript
// Toast notification component
const Toast = ({ message, type = 'info', duration = 3000, onDismiss }) => {
  const translateY = useRef(new Animated.Value(100)).current;
  const opacity = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    // Entrance animation
    Animated.parallel([
      Animated.spring(translateY, {
        toValue: 0,
        tension: 120,
        friction: 12,
        useNativeDriver: true
      }),
      Animated.timing(opacity, {
        toValue: 1,
        duration: 200,
        useNativeDriver: true
      })
    ]).start();

    // Auto-dismiss after duration
    const timer = setTimeout(() => {
      dismiss();
    }, duration);

    return () => clearTimeout(timer);
  }, []);

  const dismiss = () => {
    Animated.parallel([
      Animated.timing(translateY, {
        toValue: 100,
        duration: 300,
        useNativeDriver: true
      }),
      Animated.timing(opacity, {
        toValue: 0,
        duration: 300,
        useNativeDriver: true
      })
    ]).start(() => {
      if (onDismiss) onDismiss();
    });
  };

  // Get color based on type
  const getBackgroundColor = () => {
    switch (type) {
      case 'success':
        return colors.status.success;
      case 'error':
        return colors.status.error;
      case 'warning':
        return colors.status.warning;
      default:
        return colors.status.info;
    }
  };

  return (
    <Animated.View
      style={{
        position: 'absolute',
        bottom: 20,
        left: 20,
        right: 20,
        backgroundColor: getBackgroundColor(),
        borderRadius: borderRadius.medium,
        padding: spacing.md,
        ...elevation.level2,
        transform: [{ translateY }],
        opacity
      }}
    >
      <SwipeToDismiss onDismiss={dismiss}>
        <Text style={{ color: colors.text.primary, fontSize: typography.sizes.body }}>
          {message}
        </Text>
      </SwipeToDismiss>
    </Animated.View>
  );
};

### Error Shake Animation

When an error occurs (e.g., invalid form input):

- **Animation**: Horizontal shake (left-right-left)
- **Duration**: 300ms total
- **Easing**: Ease-out
- **Visual**: Optional red highlight or border

```typescript
// Error shake animation
const ErrorShake = ({ children, error }) => {
  const translateX = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    if (error) {
      Animated.sequence([
        Animated.timing(translateX, {
          toValue: 10,
          duration: 50,
          useNativeDriver: true
        }),
        Animated.timing(translateX, {
          toValue: -10,
          duration: 50,
          useNativeDriver: true
        }),
        Animated.timing(translateX, {
          toValue: 10,
          duration: 50,
          useNativeDriver: true
        }),
        Animated.timing(translateX, {
          toValue: -10,
          duration: 50,
          useNativeDriver: true
        }),
        Animated.timing(translateX, {
          toValue: 0,
          duration: 50,
          useNativeDriver: true
        })
      ]).start();
    }
  }, [error]);

  return (
    <Animated.View
      style={{
        transform: [{ translateX }],
        borderColor: error ? colors.status.error : 'transparent',
        borderWidth: error ? 1 : 0,
        borderRadius: borderRadius.medium
      }}
    >
      {children}

      {error && (
        <Text style={{ color: colors.status.error, fontSize: typography.sizes.bodySmall, marginTop: 4 }}>
          {error}
        </Text>
      )}
    </Animated.View>
  );
};
```

## Loading Interactions

### Button Loading State

When a button is in loading state:

- **Visual Change**: Replace text with spinner
- **Animation**: Continuous rotation animation
- **Feedback**: Button remains pressed (scaled down)
- **Interaction**: Button becomes non-interactive

```typescript
// Button loading state
const Button = ({ title, onPress, loading, ...props }) => {
  const spinnerRotation = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    if (loading) {
      Animated.loop(
        Animated.timing(spinnerRotation, {
          toValue: 1,
          duration: 1000,
          easing: Easing.linear,
          useNativeDriver: true
        })
      ).start();
    } else {
      spinnerRotation.setValue(0);
    }
  }, [loading]);

  const spin = spinnerRotation.interpolate({
    inputRange: [0, 1],
    outputRange: ['0deg', '360deg']
  });

  return (
    <Pressable
      onPress={loading ? null : onPress}
      style={[{
        backgroundColor: colors.primary,
        borderRadius: borderRadius.button,
        paddingVertical: spacing.buttonPadding.medium.vertical,
        paddingHorizontal: spacing.buttonPadding.medium.horizontal,
        alignItems: 'center',
        justifyContent: 'center',
        transform: [{ scale: loading ? 0.98 : 1 }]
      }, props.style]}
      disabled={loading}
    >
      {loading ? (
        <Animated.View style={{ transform: [{ rotate: spin }] }}>
          <Icon name="spinner" size={20} color={colors.text.onHighlight} />
        </Animated.View>
      ) : (
        <Text style={{ color: colors.text.onHighlight, fontSize: typography.sizes.body }}>
          {title}
        </Text>
      )}
    </Pressable>
  );
};
```

### Skeleton Loading

When content is loading:

- **Visual**: Placeholder shapes matching content layout
- **Animation**: Shimmer effect (light gradient moving across)
- **Duration**: Continuous until content loads
- **Transition**: Fade out when content is ready

```typescript
// Skeleton loading component
const SkeletonLoading = ({ width, height, borderRadius = 4, style }) => {
  const shimmerPosition = useRef(new Animated.Value(-1)).current;

  useEffect(() => {
    Animated.loop(
      Animated.timing(shimmerPosition, {
        toValue: 1,
        duration: 1500,
        easing: Easing.linear,
        useNativeDriver: true
      })
    ).start();
  }, []);

  return (
    <View
      style={[
        {
          width,
          height,
          borderRadius,
          backgroundColor: colors.text.disabled,
          overflow: 'hidden'
        },
        style
      ]}
    >
      <Animated.View
        style={{
          width: '100%',
          height: '100%',
          position: 'absolute',
          backgroundColor: 'transparent',
          transform: [
            {
              translateX: shimmerPosition.interpolate({
                inputRange: [-1, 1],
                outputRange: [-width, width]
              })
            }
          ]
        }}
      >
        <LinearGradient
          colors={['transparent', 'rgba(255,255,255,0.3)', 'transparent']}
          start={{ x: 0, y: 0.5 }}
          end={{ x: 1, y: 0.5 }}
          style={{ width: '100%', height: '100%' }}
        />
      </Animated.View>
    </View>
  );
};

// Usage example: Skeleton card
const SkeletonCard = () => {
  return (
    <View style={{ padding: spacing.md, backgroundColor: colors.background, borderRadius: borderRadius.card }}>
      <SkeletonLoading width={100} height={100} borderRadius={borderRadius.medium} />
      <SkeletonLoading width={200} height={20} borderRadius={4} style={{ marginTop: 12 }} />
      <SkeletonLoading width={150} height={16} borderRadius={4} style={{ marginTop: 8 }} />
      <SkeletonLoading width={100} height={16} borderRadius={4} style={{ marginTop: 8 }} />
    </View>
  );
};
```

## Best Practices

### Interaction Guidelines

1. **Be Responsive**: All interactions should provide immediate feedback
2. **Be Consistent**: Use the same interaction patterns throughout the app
3. **Be Purposeful**: Don't add animations just for the sake of it
4. **Be Accessible**: Ensure all interactions work with accessibility features
5. **Be Performant**: Optimize animations for smooth performance

### Performance Considerations

1. **Use Native Driver**: Enable `useNativeDriver: true` whenever possible
2. **Limit Animations**: Don't animate too many elements simultaneously
3. **Optimize Gesture Handlers**: Use proper thresholds and constraints
4. **Monitor Frame Rate**: Ensure animations maintain 60fps
5. **Test on Lower-End Devices**: Verify performance across device range

### Accessibility Considerations

1. **Respect Reduced Motion**: Honor the user's system-level reduced motion preference
2. **Provide Alternative Feedback**: Use haptic feedback in addition to visual feedback
3. **Ensure Sufficient Touch Targets**: Make interactive elements at least 44x44px
4. **Support Keyboard Navigation**: Ensure all interactions are keyboard accessible
5. **Test with Screen Readers**: Verify all interactions work with screen readers

```typescript
// Example: Respecting reduced motion preference
import { AccessibilityInfo } from 'react-native';

const [reducedMotion, setReducedMotion] = useState(false);

useEffect(() => {
  const checkReducedMotion = async () => {
    const isReducedMotionEnabled = await AccessibilityInfo.isReduceMotionEnabled();
    setReducedMotion(isReducedMotionEnabled);
  };

  checkReducedMotion();

  const subscription = AccessibilityInfo.addEventListener(
    'reduceMotionChanged',
    (isReduceMotionEnabled) => {
      setReducedMotion(isReduceMotionEnabled);
    }
  );

  return () => {
    subscription.remove();
  };
}, []);

// Use reduced animations when reducedMotion is true
const animationDuration = reducedMotion ? 0 : 300;
```

## Implementation Checklist

- [ ] Set up reusable animation components
- [ ] Implement button press feedback
- [ ] Create gesture interaction handlers
- [ ] Develop form interaction animations
- [ ] Build feedback interaction components
- [ ] Implement loading state animations
- [ ] Test interactions on different devices
- [ ] Verify accessibility compliance
- [ ] Optimize for performance
- [ ] Document interaction patterns for the team
