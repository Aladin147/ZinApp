# ZinApp V2 - Development Roadmap

## Overall Goal
Rebuild ZinApp as a Flutter application adhering to the V2 Brand Identity, Architecture, and Feature Specifications, focusing on exceptional UI/UX, gamification, and community features.

---

## Milestone 1: Foundation & Core Implementation (Target: End of Week X)

**Goal:** Establish a runnable application skeleton with core architecture, theme, navigation, and foundational UI components implemented according to V2 standards. Build the first screen (`LandingScreen`).

**Key Tasks / Deliverables:**
*   [x] Flutter Project Setup (`zinapp_v2`)
*   [x] Documentation Setup (V2 Specs + Living Docs)
*   [x] **Core Dependencies:** Add `riverpod`, `go_router`, `http`/`dio`, `flutter_secure_storage`, `flutter_svg` etc. to `pubspec.yaml`. (Completed during setup/Phase 3)
*   [x] **API Service:** Implement `ApiService` abstraction & basic `MockApiService` (read-only JSON loading). Implement provider/swap logic. (Completed during setup/Phase 1)
*   [x] **Core Helpers:** Implement `AppTypography`, `ScreenWrapper`, `app_animations.dart`. (Completed during setup/Phase 1)
*   [x] **Core Components:** Implement `AppButton`, `AppCard`, `Avatar`, `AppTextField` adhering to theme. (Completed during setup/Phase 1)
*   [x] **Routing:** Basic `go_router` setup with initial routes (e.g., `/landing`). (Completed during setup/Phase 1)
*   [ ] **Landing Screen:** Implement `LandingScreen` UI using established components and theme. Integrate basic assets (logo).
*   [ ] **Unit/Widget Tests:** Initial tests for core components and services. (Partially done, ongoing)
*   [x] **Documentation:** Update Journal, TODO, Known Issues. (Completed as part of Phase 7)

**Success Criteria:** App runs, displays themed Landing Screen with core components, basic navigation works, core services are injectable (using mock).

---

## Milestone 2: Authentication & User Profile (Target: End of Week Y)

**Goal:** Implement user authentication flow and the basic user profile screen displaying gamification elements.

**Key Tasks / Deliverables:**
*   [ ] **Auth Feature:** Create `lib/features/auth/` structure.
*   [ ] **Auth Screens:** Implement `LoginScreen`, `SignupScreen` UI & basic form handling.
*   [ ] **Auth Service:** Implement `AuthService` interface & mock implementation (simulating login/signup). Integrate with `ApiService`.
*   [ ] **State Management:** Implement Auth state logic (e.g., `AuthNotifier` using Riverpod).
*   [ ] **Secure Storage:** Integrate `flutter_secure_storage` for token handling (mock tokens initially).
*   [ ] **Routing:** Add auth routes and basic route guarding.
*   [ ] **Profile Feature:** Create `lib/features/profile/` structure.
*   [ ] **Profile Screen:** Implement basic `ProfileScreen` UI displaying mock user data (username, avatar).
*   [ ] **Gamification Display:** Implement `XpProgressBar` widget; display mock XP, Level, ZIN Tokens on Profile Screen.
*   [ ] **Unit/Widget Tests:** Tests for Auth logic, screens, Profile display.
*   [ ] **Documentation:** Update Journal, TODO, Known Issues, Decisions.

**Success Criteria:** Users can simulate login/signup, authenticated state is managed, basic profile screen displays themed data including gamification elements.

---

## Milestone 3: Stylist Discovery & Core Booking Flow (Target: End of Week Z)

**Goal:** Implement the core user journey of finding a stylist and initiating the booking process.

**Key Tasks / Deliverables:**
*   [ ] **Stylist Discovery Feature:** Create `lib/features/stylist_discovery/`.
*   [ ] **Stylist Components:** Implement `StylistCard` widget.
*   [ ] **Stylist Screens:** Implement `StylistListScreen` (displaying mock stylists) and `StylistProfileScreen` (displaying mock details).
*   [ ] **Booking Feature:** Create `lib/features/booking/`.
*   [ ] **Booking Components:** Implement `ServiceButton`, `BookingCard` (basic).
*   [ ] **Booking Screens:** Implement `ServiceSelectScreen`, `BookingScreen` (basic form/calendar).
*   [ ] **API Integration:** Connect screens to `MockApiService` to fetch stylist/service data.
*   [ ] **Routing:** Add discovery and booking routes.
*   [ ] **Unit/Widget Tests:** Tests for discovery/booking screens and components.
*   [ ] **Documentation:** Updates.

**Success Criteria:** Users can view lists/profiles of mock stylists, select services, and navigate to a basic booking screen.

---

## Milestone 4: Booking Completion & Gamification Integration (Target: ...)

**Goal:** Complete the booking flow, implement the rating system, and integrate core gamification reward triggers.

**Key Tasks / Deliverables:**
*   [ ] **Booking Logic:** Implement `submitBooking` logic in `MockApiService` (simulating success/failure).
*   [ ] **Booking Screens:** Implement `Bsse7aScreen` (confirmation) and `RatingScreen`.
*   [ ] **Gamification Service:** Implement `GamificationService` logic for calculating XP/Tokens based on `gamification.json`.
*   [ ] **Integration:** Trigger `GamificationService` calls upon booking completion and rating submission via `MockApiService`. Update user state (XP/Tokens/Level).
*   [ ] **UI Feedback:** Display XP/Token gains on relevant screens. Implement Level Up notification/animation.
*   [ ] **Unit/Widget/Integration Tests:** Test booking completion, rating submission, and gamification updates.
*   [ ] **Documentation:** Updates.

**Success Criteria:** Users can complete a mock booking, submit a rating, and see their XP/Tokens/Level update accordingly.

---

## Milestone 5: Social Feed & Polish (Target: ...)

**Goal:** Implement the basic social feed (FYP) and add visual polish (animations, illustrations).

**Key Tasks / Deliverables:**
*   [ ] **Feed Feature:** Create `lib/features/feed/`.
*   [ ] **Feed Components:** Implement `PostCard` widget.
*   [ ] **Feed Screen:** Implement basic `FeedScreen` displaying mock posts.
*   [ ] **API Integration:** Connect feed to `MockApiService` to fetch posts.
*   [ ] **Animations:** Implement screen transitions, button feedback animations, loading indicators/shimmers.
*   [ ] **Illustrations:** Integrate illustrations into empty states, success screens, onboarding (if applicable).
*   [ ] **Splash Screen:** Implement Rive/Lottie splash screen animation.
*   [ ] **Testing:** Widget tests for feed, manual testing for animations/polish.
*   [ ] **Documentation:** Updates.

**Success Criteria:** Basic social feed displays mock content, core animations and illustrations enhance the user experience.

---

## Future Milestones (Post-MVP / Initial Release)
*   Real API Integration (`RealApiService`)
*   Advanced Gamification (Leaderboards, Challenges)
*   Advanced Social Features (Posting, Comments, Following)
*   Push Notifications
*   Live Tracking Feature
*   Payment Integration
*   CI/CD Setup
*   Advanced Testing (E2E Automation)
*   [x] Performance Optimization (Addressed in Phase 6 of Tech Debt Plan)
*   iOS Build Setup (Requires macOS)
