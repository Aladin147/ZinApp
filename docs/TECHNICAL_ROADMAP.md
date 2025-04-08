# ZinApp Demo - Technical Roadmap

This document outlines the planned sequence for building the ZinApp demo, ensuring adherence to the project's documentation and standards.

**Phase 1: Core Navigation & Screens Setup**

1.  **Implement Basic Screens:** Create placeholder files for all screens defined in `FEATURE_FLOW.md` within the `screens/` directory (e.g., `LandingScreen.tsx`, `ServiceSelectScreen.tsx`, etc.). Ensure they render basic text and are correctly linked in `navigation/AppNavigator.tsx`.
    *   *Docs Ref:* `FEATURE_FLOW.md`, `navigation/AppNavigator.tsx`
2.  **Basic Navigation Test:** Verify that tapping through the basic flow navigates between these placeholder screens correctly.
    *   *Docs Ref:* `FEATURE_FLOW.md`

**Phase 2: Service Selection & Stylist Discovery**

1.  **Implement `ServiceSelectScreen`:**
    *   Build the UI using design tokens (`constants/`).
    *   Implement the `ServiceIconBtn` component (`components/specific/`).
    *   Add tap animations (`ANIMATION_INTERACTION_SYSTEM.md`).
    *   Fetch service data using `services/api.ts`.
    *   Navigate to `StylistListScreen` on selection, passing the selected service ID.
    *   *Docs Ref:* `FEATURE_FLOW.md`, `DESIGN_TOKENS.md`, `COMPONENT_MAP.md`, `ANIMATION_INTERACTION_SYSTEM.md`, `MOCK_API_SCHEMA.md`
2.  **Implement `StylistListScreen`:**
    *   Build the list UI.
    *   Implement the `BarberCard` component (`components/specific/`).
    *   Fetch stylist data based on service ID (or all stylists) using `services/api.ts`.
    *   Implement card fade-in/stagger animation (`ANIMATION_INTERACTION_SYSTEM.md`).
    *   Handle "No stylists nearby" state (`STATE_FLAGS.md`).
    *   Navigate to `BarberProfileScreen` on card tap, passing stylist ID.
    *   *Docs Ref:* `FEATURE_FLOW.md`, `DESIGN_TOKENS.md`, `COMPONENT_MAP.md`, `ANIMATION_INTERACTION_SYSTEM.md`, `MOCK_API_SCHEMA.md`, `STATE_FLAGS.md`

**Phase 3: Stylist Profile & Booking Initiation**

1.  **Implement `BarberProfileScreen`:**
    *   Build UI: Profile photo, name, bio, gallery grid, service list.
    *   Implement `AvatarBadge` component (`components/shared/` - need to create this folder/component).
    *   Fetch specific stylist data using `services/api.ts`.
    *   Implement gallery interactions (e.g., tap to expand - placeholder for now).
    *   Display "Verified Stylist" badge conditionally.
    *   Handle `qrSource` flag (`STATE_FLAGS.md`) for potential UI variations (e.g., trust glow - placeholder).
    *   Navigate to `BookingScreen` on CTA tap, passing stylist and selected service ID.
    *   *Docs Ref:* `FEATURE_FLOW.md`, `DESIGN_TOKENS.md`, `COMPONENT_MAP.md`, `ANIMATION_INTERACTION_SYSTEM.md`, `MOCK_API_SCHEMA.md`, `STATE_FLAGS.md`, `TRUST_MODEL.md`
2.  **Implement `BookingScreen`:**
    *   Build UI: Service display, date/time picker (use a basic native component initially), payment section.
    *   Implement **Guest/Verified State Logic:**
        *   Use `AuthContext` (`state/AuthContext.tsx`) to get `is_verified` status.
        *   Conditionally show "Add card" prompt (Guest) or "Pay later" toggle (Verified). This directly addresses a `TODO.md` item.
    *   Implement CTA button with primary color and tap animation.
    *   On confirm, simulate booking creation (no actual API call needed for demo) and navigate to `LiveTrackScreen`, passing a mock booking ID.
    *   *Docs Ref:* `FEATURE_FLOW.md`, `DESIGN_TOKENS.md`, `ANIMATION_INTERACTION_SYSTEM.md`, `MOCK_API_SCHEMA.md`, `STATE_FLAGS.md`, `TRUST_MODEL.md`, `state/AuthContext.tsx`

**Phase 4: Live Tracking & Post-Service Flow**

1.  **Implement `LiveTrackScreen`:**
    *   Build UI: Map view placeholder (using `react-native-maps` if needed, or just a static image for demo), ETA display, stylist avatar.
    *   Implement `MapTracker` component (`components/core/` - need to create this folder/component).
    *   Simulate ETA countdown and avatar movement (basic animation).
    *   Implement fake Contact/Cancel buttons.
    *   Auto-navigate to `Bsse7aScreen` after a timer or manual trigger.
    *   *Docs Ref:* `FEATURE_FLOW.md`, `DESIGN_TOKENS.md`, `COMPONENT_MAP.md`, `ANIMATION_INTERACTION_SYSTEM.md`
2.  **Implement `Bsse7aScreen`:**
    *   Build UI: Confetti (using `lottie-react-native`), avatar, summary, tip buttons, rating component.
    *   Implement `RatingStars` component (`components/shared/`).
    *   Implement tip button interactions.
    *   Handle `rating_given` flag (`STATE_FLAGS.md`) - potentially skip rating if already done.
    *   Implement CTAs (Rebook, Favorites - placeholder actions).
    *   Navigate back to `ServiceSelectScreen` to restart flow.
    *   *Docs Ref:* `FEATURE_FLOW.md`, `DESIGN_TOKENS.md`, `COMPONENT_MAP.md`, `ANIMATION_INTERACTION_SYSTEM.md`, `STATE_FLAGS.md`, `TRUST_MODEL.md`

**Phase 5: QR Flow & Refinements**

1.  **Implement QR Routing Stub:** Add a button (e.g., on LandingScreen or a debug menu) to simulate scanning. On tap, navigate directly to a specific `BarberProfileScreen`, setting the `qrSource=true` flag/param. This addresses a `TODO.md` item.
    *   *Docs Ref:* `FEATURE_FLOW.md`, `STATE_FLAGS.md`, `QR_LOGIC.md` (for future logic)
2.  **Refine Animations & Transitions:** Revisit all screens and ensure transitions and interactions strictly follow `ANIMATION_INTERACTION_SYSTEM.md`.
3.  **Testing & Polish:** Thoroughly test the entire flow using the mock data and state flags. Fix bugs noted in `KNOWN_ISSUES.md` if feasible within the demo scope. Ensure visual consistency and adherence to design tokens.

**Ongoing Tasks:**

*   **Documentation:** Update `journal.md`, `TODO.md`, `KNOWN_ISSUES.md`, and `COMPONENT_MAP.md` *as each step is completed*.
*   **Commits:** Make frequent, logical commits to Git.
