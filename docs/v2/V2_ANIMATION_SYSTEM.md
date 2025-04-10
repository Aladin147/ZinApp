# ZinApp V2 Animation System

## 1. Principles & Philosophy
   - **Purposeful:** Animations should enhance usability, provide feedback, guide the user, or add character without being distracting. Avoid purely decorative animations that slow down interaction.
   - **Responsive & Performant:** Animations must be smooth (aiming for 60fps) and not negatively impact app performance or battery life.
   - **Consistent:** Maintain a consistent style and timing across the application for similar interactions.
   - **Delightful (Subtle):** Incorporate subtle "micro-interactions" and transitions to make the UI feel alive and engaging, aligning with the "Child Wonder Test" principle.
   - **Contextual:** Animation intensity and style may vary slightly depending on the context (e.g., celebratory animations vs. standard UI feedback).
   - **Accessible:** Respect user preferences for reduced motion (see V2_ACCESSIBILITY_GUIDELINES.md).

## 2. Types of Animations
   - **Transitions:**
     - **Screen Transitions:** Smooth fades, slides (e.g., slide-in from right for forward navigation, fade for modals). Target duration: 300-500ms. Use Flutter's built-in `PageRouteBuilder` or packages like `animations`.
     - **Shared Element Transitions:** (Future consideration) For seamless navigation between list views and detail views (e.g., profile picture expanding).
   - **Micro-interactions:**
     - **Button Feedback:** Subtle scale down (e.g., 0.95 scale) on press, potentially with a slight haptic feedback simulation.
     - **Loading States:**
       - Shimmer effects (using `shimmer` package) for placeholder content.
       - Smooth loading indicators (e.g., `CircularProgressIndicator` with custom styling).
     - **Input Feedback:** Subtle border highlight or label animation on focus.
     - **Card Interactions:** Slight lift (elevation change) or scale on hover/press.
     - **Icon Animations:** Subtle rotation or state change (e.g., like icon filling).
   - **Feedback & Status:**
     - **Confirmation Animations:** Subtle checkmark animation or pulse effect.
     - **Error Animations:** Gentle shake or color flash on input errors.
     - **"Bsse7a!" Celebration:** More expressive animation (potentially Lottie/Rive) involving confetti, color bursts, and token/XP gain visualization.
   - **Data Visualization:**
     - Animated chart updates (if applicable).
     - Smooth updates to XP bars or token counters.
   - **Splash Screen Animation:**
     - Code-based prototype initially.
     - Target: Full Lottie or Rive animation (2.5-3s max) incorporating brand elements (#D2FF4D, #8CBACD, logo). See `V2_APP_LIFECYCLE.md`.

## 3. Tools & Technology
   - **Primary:** Flutter's built-in Animation framework (`AnimationController`, `Tween`, `AnimatedWidget`, `ImplicitlyAnimatedWidget` subclasses like `AnimatedContainer`).
   - **Complex/Vector Animations:**
     - **Rive (`rive` package):** Preferred for the splash screen and potentially complex character or celebratory animations due to performance and state machine capabilities.
     - **Lottie (`lottie` package):** Alternative for vector animations, especially if existing After Effects assets are available.
   - **Transitions:** Flutter's navigation transitions, `animations` package.
   - **Loading Shimmers:** `shimmer` package.
   - **Haptics:** `flutter_haptic_feedback` package for simulating subtle physical feedback on interactions.

## 4. Performance Considerations
   - **Minimize `setState`:** Use `AnimatedBuilder` or `AnimatedWidget` where possible to rebuild only the animating part of the widget tree.
   - **Use Implicit Animations:** Leverage widgets like `AnimatedContainer`, `AnimatedOpacity`, etc., for simple state changes.
   - **Profile Animations:** Use Flutter DevTools to profile animation performance and identify jank.
   - **Optimize Rive/Lottie:** Keep file sizes reasonable, simplify complex animations if they impact performance. Test on target devices.
   - **Avoid Overuse:** Be mindful of the number and complexity of simultaneous animations.

## 5. Accessibility
   - **Reduced Motion:** Check `MediaQuery.of(context).disableAnimations` and provide simpler or no animations if true.
   - **Flashing:** Avoid animations that flash rapidly, adhering to WCAG guidelines.
   - **Duration:** Ensure animations don't block users from interacting for excessive periods.

## 6. Implementation Notes
   - Define standard animation curves (e.g., `Curves.easeInOut`) and durations in a central theme or constants file (`constants/animations.dart` - TBD).
   - Create reusable animation widgets or mixins for common patterns (e.g., button press scale).
