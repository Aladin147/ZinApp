
# ZinApp Interaction & Animation System

## 🎯 Purpose
This document defines the UX interaction patterns and animation system that drive the polished, intuitive feel of ZinApp. Our design ethos is built around a high-trust, low-friction mobile experience with responsive feedback, delightful transitions, and natural motion.

This system is non-optional — every UI element must behave consistently and elegantly.

---

## ✋ Interaction Patterns

### ✅ Tap
- All buttons must animate with a slight scale-in (95%) and bounce out
- Active states show soft shadow (NativeWind `shadow-md` + `bg-opacity`)
- CTA buttons use `bg-primary` (#F4805D) with icon + label
- Button height: 48px (standard) / 56px (hero)
- Button radius: 12px

### ✋ Long-Press
- Used for service cards (preview)
- Triggers haptic feedback (on supported devices)
- Optionally reveals a larger modal preview (spring-in)

### ✅ Scroll
- Lists (e.g. stylists, gallery) must support smooth momentum scroll
- Optional scroll-based header collapse
- Pull-to-refresh should show a custom animation or colorized spinner

### 👆 Swipe
- Horizontal swipe (for booking history cards)
- Left swipe reveals contextual actions: rebook, rate, tip
- Gesture-driven drawer or sheet (using Reanimated or Expo Drawer)

### 📍 QR Scan
- Uses a mock camera overlay w/ light pulse animation on active scan
- Upon detection, scans animate up → morphs into profile card

---

## 🎞️ Animation Tokens (Playful & Glovo-like)
| Token              | Duration  | Use                                    |
|--------------------|----------|-----------------------------------------|
| `screenTransition` | 300ms     | Slide + Fade screen transitions with bounce |
| `buttonTap`        | 100ms     | Scale down to 0.92 with extra bounce   |
| `confetti`         | 1200ms    | Booking confirmation animation         |
| `mapPulse`         | 1500ms    | Pulsing animation for map avatars      |
| `fadeIn`           | 400ms     | Appear transitions for cards           |
| `slideUp`          | 500ms     | Bottom sheets, Bsse7a screen           |
| `bounce`           | 800ms     | Playful bounce for attention elements  |
| `wiggle`           | 600ms     | Subtle wiggle for interactive elements |

---

## 📱 Screen Load Transitions

| Screen               | Transition Type    | Notes                                |
|----------------------|--------------------|--------------------------------------|
| `HomeLanding`        | fade-in + scale    | Logo reveal + call-to-action bounce  |
| `ServiceSelect`      | slide-up           | Category icons animate in from below |
| `StylistList`        | fade-in            | Cards fade and stagger-load          |
| `BarberProfile`      | slide-in-right     | Portfolio content bounces on load    |
| `BookingConfirm`     | bounce-scale       | Success anim + checkmark splash      |
| `LiveTrack`          | move + path-draw   | Avatar glides + route animates in    |
| `Bsse7aScreen`       | confetti + fade    | Cultural finish, tip + rating reveal |

---

## 🌗 Visual Feedback & Shadows (Glovo-inspired)
- Cards should have subtle shadows for depth and playfulness (like Glovo)
- Cards should have 24px border radius for a more playful, bubbly look
- Buttons should have 24px border radius (fully rounded like Glovo)
- Tappable elements should have exaggerated visual feedback (scale + color change)
- Modal dialogs use background blur and bouncy scale pop-in
- Use playful micro-interactions on important elements (wiggle, pulse, etc.)

---

## 🎯 Animation Tools & Libraries
- `react-native-reanimated` v2+ (screen and gesture transitions)
- `lottie-react-native` (Bsse7a, empty states)
- `expo-haptics` for tactile feedback
- `moti` (optional) for prop-driven animations

---

## 🔁 Reusability & Consistency
- Animations must be abstracted into hooks or wrapper components
- Use shared animation tokens (not duplicated inline values)
- All entry/exit transitions should be testable in isolation

---

## 🔚 Final Principle
> "The user should feel the product is alive, reactive, and effortless — like the experience was built just for them."

All animations must be purposeful.
All transitions must feel human.
All interactions must guide and delight.

This system is the invisible layer that makes ZinApp memorable.
