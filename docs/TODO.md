# ZinApp V2 - TODO List

This file tracks pending tasks, features, refactoring items, and other actionable points for the ZinApp V2 project. Refer to `V2_ROADMAP.md` for milestone context.

---

## Milestone 1: Foundation & Core Implementation
*Goal: Establish a runnable application skeleton with core architecture, theme, navigation, and foundational UI components implemented according to V2 standards. Build the first screen (`LandingScreen`).*

- [x] Initialize Flutter Project (`zinapp_v2`)
- [x] Copy V2 Documentation
- [x] Setup `lib` structure
- [x] Configure Linter (`analysis_options.yaml`)
- [x] Add `.gitignore`
- [x] Implement Theme System (`color_scheme`, `text_theme`, `zinapp_theme`)
- [x] Declare & Add Fonts (`pubspec.yaml`, assets)
- [x] Apply Theme in `main.dart`
- [x] Setup Living Documentation Files (Journal, Known Issues, Decisions, etc.)
- [x] Implement API Service Abstraction (`ApiService`)
- [x] Implement basic `MockApiService` (read-only placeholders)
- [x] Implement `AppTypography` Helper/Widget
- [x] Implement `ScreenWrapper` Widget
- [x] Define Animation Constants (`app_animations.dart`)
- [x] Build `AppButton` Component (`lib/widgets/`)
- [ ] **Core Dependencies:** Add `flutter_riverpod`, `go_router`, `http`/`dio`, `flutter_secure_storage`, `flutter_svg` etc. to `pubspec.yaml` and run `flutter pub get`.
- [ ] **API Service:** Implement JSON loading in `MockApiService`.
- [ ] **API Service:** Implement provider/swap logic (e.g., Riverpod provider).
- [ ] **Core Components:** Build `AppCard` Component (`lib/widgets/`).
- [ ] **Core Components:** Build `Avatar` Component (`lib/widgets/`).
- [ ] **Core Components:** Build `AppTextField` Component (`lib/widgets/`).
- [ ] **Routing:** Implement basic `go_router` setup (`lib/app/router.dart`) with `/landing` route.
- [ ] **State Management:** Basic Riverpod `ProviderScope` setup in `main.dart`.
- [ ] **Landing Screen:** Create feature folder (`lib/features/auth/`).
- [ ] **Landing Screen:** Implement `LandingScreen` UI (`lib/features/auth/screens/landing_screen.dart`) using `ScreenWrapper`, `AppButton`, `AppTypography`, assets.
- [ ] **Unit/Widget Tests:** Add initial tests for `AppButton`, `ScreenWrapper`, `MockApiService`.
- [ ] **Documentation:** Update Journal, Known Issues for Milestone 1 progress.

## Milestone 2: Authentication & User Profile
*Goal: Implement user authentication flow and the basic user profile screen displaying gamification elements.*

- [ ] **Auth Feature:** Create `lib/features/auth/` structure (if not done).
- [ ] **Auth Screens:** Implement `LoginScreen`, `SignupScreen` UI & basic form handling.
- [ ] **Auth Service:** Implement `AuthService` interface & mock implementation.
- [ ] **State Management:** Implement Auth state logic (e.g., `AuthNotifier`).
- [ ] **Secure Storage:** Integrate `flutter_secure_storage` for mock tokens.
- [ ] **Routing:** Add auth routes and route guarding.
- [ ] **Profile Feature:** Create `lib/features/profile/` structure.
- [ ] **Profile Screen:** Implement basic `ProfileScreen` UI (username, avatar).
- [ ] **Gamification Display:** Implement `XpProgressBar` widget; display mock XP/Level/Tokens.
- [ ] **Unit/Widget Tests:** Tests for Auth logic, screens, Profile display.
- [ ] **Documentation:** Updates.

## Milestone 3: Stylist Discovery & Core Booking Flow
*Goal: Implement the core user journey of finding a stylist and initiating the booking process.*

- [ ] **Stylist Discovery Feature:** Create `lib/features/stylist_discovery/`.
- [ ] **Stylist Components:** Implement `StylistCard` widget.
- [ ] **Stylist Screens:** Implement `StylistListScreen` & `StylistProfileScreen`.
- [ ] **Booking Feature:** Create `lib/features/booking/`.
- [ ] **Booking Components:** Implement `ServiceButton`, `BookingCard` (basic).
- [ ] **Booking Screens:** Implement `ServiceSelectScreen`, `BookingScreen`.
- [ ] **API Integration:** Connect screens to `MockApiService`.
- [ ] **Routing:** Add discovery and booking routes.
- [ ] **Unit/Widget Tests:** Tests for discovery/booking screens and components.
- [ ] **Documentation:** Updates.

## Milestone 4: Booking Completion & Gamification Integration
*Goal: Complete the booking flow, implement the rating system, and integrate core gamification reward triggers.*

- [ ] **Booking Logic:** Implement `submitBooking` in `MockApiService`.
- [ ] **Booking Screens:** Implement `Bsse7aScreen` & `RatingScreen`.
- [ ] **Gamification Service:** Implement `GamificationService` logic.
- [ ] **Integration:** Trigger `GamificationService` calls. Update user state.
- [ ] **UI Feedback:** Display XP/Token gains & Level Up.
- [ ] **Unit/Widget/Integration Tests:** Test booking completion, rating, gamification.
- [ ] **Documentation:** Updates.

## Milestone 5: Social Feed & Polish
*Goal: Implement the basic social feed (FYP) and add visual polish (animations, illustrations).*

- [ ] **Feed Feature:** Create `lib/features/feed/`.
- [ ] **Feed Components:** Implement `PostCard` widget.
- [ ] **Feed Screen:** Implement basic `FeedScreen`.
- [ ] **API Integration:** Connect feed to `MockApiService`.
- [ ] **Animations:** Implement screen transitions, button feedback, loading indicators.
- [ ] **Illustrations:** Integrate illustrations.
- [ ] **Splash Screen:** Implement Rive/Lottie splash animation.
- [ ] **Testing:** Widget tests for feed, manual testing for polish.
- [ ] **Documentation:** Updates.

## Future Milestones / Backlog
- [ ] Real API Integration (`RealApiService`)
- [ ] Advanced Gamification (Leaderboards, Challenges)
- [ ] Advanced Social Features (Posting, Comments, Following)
- [ ] Push Notifications
- [ ] Live Tracking Feature
- [ ] Payment Integration
- [ ] CI/CD Setup
- [ ] Advanced Testing (E2E Automation)
- [ ] Performance Optimization
- [ ] iOS Build Setup (Requires macOS)
- [ ] Implement Mock API write operations (Ref: KNOWN_ISSUES #02)
- [ ] Implement responsive typography scaling (Ref: KNOWN_ISSUES #03)
- [ ] Setup Android Studio / Android SDK / Emulator (Ref: KNOWN_ISSUES #01)

---

*(Update status and add new items as development progresses)*
