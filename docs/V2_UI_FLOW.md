# ZinApp V2 UI Flow

This document provides a detailed walkthrough of screens, transitions, and state changes in ZinApp V2.

## Overview

ZinApp V2 follows a logical flow that guides users through the service discovery, booking, tracking, and completion process. Each screen has specific states and transitions that create a cohesive, engaging user experience.

## Core User Journey

### 1. Onboarding & Authentication

#### Initial Launch
- **Splash Screen** → **Onboarding** (first-time users)
- **Splash Screen** → **Authentication** (returning users without active session)
- **Splash Screen** → **Landing Screen** (returning users with active session)

#### Authentication States
- **Login Form**: Email/phone input → Password input → Validation → Success/Error
- **Registration Form**: Personal info → Verification → Profile completion
- **Password Recovery**: Email/phone input → Verification → Reset password

#### Transitions
- Fade transition from Splash to Onboarding/Authentication
- Slide up transition between authentication steps
- Celebration animation on successful registration

### 2. Service Discovery

#### Landing Screen
- **States**: Default, Loading, Error, Empty (no services available)
- **Components**: Service categories, Featured stylists, Recent bookings, Promotions
- **Actions**: Select service category, View stylist, View promotion, Search

#### Service Selection Screen
- **States**: Default, Loading, Filtered, Error, Empty (no services match filter)
- **Components**: Service list, Filter options, Search bar, Sort options
- **Actions**: Select service, Apply filter, Search, Sort

#### Transitions
- Slide up transition from Landing to Service Selection
- Shared element transition for service cards
- Fade transition for filter changes

### 3. Stylist Selection

#### Stylist List Screen
- **States**: Default, Loading, Filtered, Error, Empty (no stylists available)
- **Components**: Stylist cards, Filter options, Map view toggle, Sort options
- **Actions**: Select stylist, Apply filter, Toggle map view, Sort

#### Stylist Profile Screen
- **States**: Default, Loading, Error
- **Components**: Stylist info, Services offered, Reviews, Availability calendar
- **Actions**: View reviews, Check availability, Book appointment, Contact stylist

#### Transitions
- Slide horizontal transition from Service Selection to Stylist List
- Reveal transition from Stylist List to Stylist Profile
- Shared element transition for stylist avatar

### 4. Booking Process

#### Booking Screen
- **Step 1 - Date & Time Selection**
  - **States**: Default, Loading, Error, No availability
  - **Components**: Calendar, Time slots, Selected service summary
  - **Actions**: Select date, Select time, Continue to next step

- **Step 2 - Service Customization**
  - **States**: Default, Loading, Error
  - **Components**: Service options, Add-ons, Special requests
  - **Actions**: Select options, Add special requests, Continue to next step

- **Step 3 - Payment & Confirmation**
  - **States**: Default, Loading, Processing payment, Error, Success
  - **Components**: Payment methods, Price breakdown, Terms acceptance
  - **Actions**: Select payment method, Apply discount, Confirm booking

#### Transitions
- Slide horizontal transition between booking steps
- Progress indicator animation
- Success animation on booking confirmation

### 5. Tracking & Completion

#### Live Track Screen
- **States**: Waiting for stylist, Stylist on the way, Stylist arrived, Error
- **Components**: Map view, Stylist info, ETA, Contact options
- **Actions**: Contact stylist, Cancel booking, View booking details

#### Bsse7a (Completion) Screen
- **States**: Default, Rating submitted, Tip added, Shared
- **Components**: Thank you message, Rating input, Tip options, Booking summary
- **Actions**: Rate experience, Add tip, Share experience, Book again

#### Transitions
- Map-focused transition to Live Track Screen
- Celebration transition to Bsse7a Screen
- Confetti animation on completion

## State Management Logic

### Global States

1. **Authentication State**
   - `unauthenticated`: User not logged in
   - `authenticating`: Authentication in progress
   - `authenticated`: User successfully logged in
   - `error`: Authentication error

2. **Booking State**
   - `idle`: No booking in progress
   - `selecting`: User selecting service/stylist
   - `booking`: Booking in progress
   - `confirmed`: Booking confirmed
   - `active`: Booking currently active
   - `completed`: Booking completed
   - `cancelled`: Booking cancelled

3. **Network State**
   - `online`: App has internet connection
   - `offline`: App is offline
   - `poor`: App has poor connection

### Screen-Specific States

#### Service Selection
- `selectedCategory`: Currently selected service category
- `searchQuery`: Current search query
- `filterOptions`: Applied filters
- `sortOption`: Current sort option

#### Stylist Selection
- `selectedService`: Currently selected service
- `filterOptions`: Applied filters
- `viewMode`: List or map view
- `sortOption`: Current sort option

#### Booking
- `selectedDate`: Selected appointment date
- `selectedTime`: Selected appointment time
- `selectedOptions`: Selected service options
- `specialRequests`: Special requests text
- `selectedPaymentMethod`: Selected payment method

#### Live Track
- `stylistLocation`: Current stylist location
- `eta`: Estimated time of arrival
- `bookingStatus`: Current status of booking

#### Bsse7a
- `rating`: User rating for the service
- `tipAmount`: Selected tip amount
- `feedbackText`: User feedback text

## Transition Specifications

### Standard Transitions

1. **Fade Transition**
   - Duration: 300ms
   - Timing function: ease-in-out
   - Opacity: 0 → 1

2. **Slide Horizontal Transition**
   - Duration: 300ms
   - Timing function: ease-out
   - Transform: translateX(100%) → translateX(0)

3. **Slide Up Transition**
   - Duration: 300ms
   - Timing function: ease-out
   - Transform: translateY(100%) → translateY(0)

4. **Scale Transition**
   - Duration: 300ms
   - Timing function: ease-out
   - Transform: scale(0.9) → scale(1)

### Special Transitions

1. **Reveal Transition** (Stylist Profile)
   - Duration: 400ms
   - Timing function: ease-out
   - Transform: scale(0.8) → scale(1)
   - Border radius: 20px → 0px
   - Opacity: 0 → 1

2. **Map Focus Transition** (Live Track)
   - Duration: 500ms
   - Timing function: ease-in-out
   - Transform: translateY(30%) → translateY(0)
   - Scale: 1.1 → 1
   - Opacity: 0 → 1

3. **Celebration Transition** (Bsse7a)
   - Duration: 600ms
   - Timing function: spring(tension: 50, friction: 7)
   - Transform: scale(0.5) → scale(1), translateY(50px) → translateY(0)
   - Opacity: 0 → 1
   - Followed by confetti animation

## Micro-Interactions

### Button Interactions
- Press: Scale to 0.98, duration 100ms
- Release: Scale back to 1.0, duration 200ms
- Error: Shake animation, duration 300ms

### Form Field Interactions
- Focus: Border highlight animation, duration 200ms
- Error: Red highlight pulse, duration 300ms
- Success: Green highlight fade, duration 300ms

### List Item Interactions
- Press: Background color change, scale to 0.99, duration 100ms
- Swipe: Reveal actions, elastic animation
- Delete: Fade out and collapse, duration 300ms

### Card Interactions
- Press: Elevation increase, scale to 0.98, duration 100ms
- Select: Highlight border animation, duration 200ms
- Expand: Height animation, duration 300ms

## Error Handling

### Network Errors
- Offline banner at top of screen
- Retry button with loading animation
- Automatic retry with exponential backoff

### Input Validation Errors
- Inline error messages with fade-in animation
- Field highlight with error color
- Error icon with subtle shake animation

### Server Errors
- Error toast with icon and message
- Retry option with loading animation
- Fallback content when available

## Loading States

### Initial Loading
- Splash screen with logo animation
- Progress indicator for longer loads
- Skeleton screens for content

### Action Loading
- Button loading state (spinner or progress)
- Inline loading indicators
- Partial content updates with loading states

### Background Loading
- Subtle loading indicator in header/footer
- Pull-to-refresh with custom animation
- Background refresh with silent updates

## Edge Cases

### Empty States
- Empty service list: Illustration and suggestion
- No stylists available: Alternative options
- No booking history: Onboarding-style guidance

### Error Recovery
- Authentication failure: Alternative login options
- Payment failure: Alternative payment methods
- Network failure: Offline functionality

### Interruptions
- Incoming call: Pause booking process, resume after
- App backgrounded: Preserve state, resume gracefully
- Session timeout: Refresh token or re-authenticate

## Implementation Notes

- Use React Navigation for screen transitions
- Implement custom transition components for special transitions
- Use Animated API for micro-interactions
- Implement skeleton screens for content loading
- Use context for global state management
- Implement error boundaries for graceful error handling
