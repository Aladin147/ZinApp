# ZinApp V2 - TODO List

This file tracks pending tasks, features, refactoring items, and other actionable points for the ZinApp V2 project.

---

## Setup & Foundation
- [x] Initialize Flutter Project (`zinapp_v2`)
- [x] Copy V2 Documentation
- [x] Setup `lib` structure
- [x] Configure Linter (`analysis_options.yaml`)
- [x] Add `.gitignore`
- [x] Implement Theme System (`color_scheme`, `text_theme`, `zinapp_theme`)
- [x] Declare & Add Fonts (`pubspec.yaml`, assets)
- [x] Apply Theme in `main.dart`
- [x] Setup Living Documentation Files (Journal, Known Issues, Decisions, Did Not Work, Do Not Do, TODO)
- [ ] Implement API Service Abstraction (`ApiService`, `MockApiService`)
- [ ] Implement `AppTypography` Helper/Widget
- [ ] Implement `ScreenWrapper` Widget
- [ ] Define Animation Constants (`app_animations.dart`)
- [ ] Add core dependencies (Riverpod, go_router, http/dio, flutter_secure_storage, etc.) to `pubspec.yaml` and run `pub get`.
- [ ] Implement Mock API write operations (or decide on in-memory mock updates for dev). (Ref: KNOWN_ISSUES #02)
- [ ] Implement basic routing setup using `go_router` (`lib/app/router.dart`).
- [ ] Implement basic state management setup using Riverpod (`main.dart`, providers).

## Feature Implementation - Core Flow
- [ ] Build `AppButton` Component (`lib/widgets/`)
- [ ] Build `AppCard` Component (`lib/widgets/`)
- [ ] Build `Avatar` Component (`lib/widgets/`)
- [ ] Build `AppTextField` Component (`lib/widgets/`)
- [ ] Implement Landing Screen UI (`lib/features/auth/screens/landing_screen.dart` - *Suggesting feature folder*)
- [ ] Implement Login Screen UI & Logic (`lib/features/auth/screens/login_screen.dart`)
- [ ] Implement Signup Screen UI & Logic (`lib/features/auth/screens/signup_screen.dart`)
- [ ] Implement Stylist List Screen UI (`lib/features/stylist_discovery/screens/stylist_list_screen.dart`)
- [ ] Implement Stylist Profile Screen UI (`lib/features/stylist_discovery/screens/stylist_profile_screen.dart`)
- [ ] Implement Service Selection Screen UI (`lib/features/booking/screens/service_select_screen.dart`)
- [ ] Implement Booking Screen UI (`lib/features/booking/screens/booking_screen.dart`)
- [ ] Implement Booking Confirmation / "Bsse7a" Screen UI (`lib/features/booking/screens/bsse7a_screen.dart`)
- [ ] Implement User Profile Screen UI (`lib/features/profile/screens/profile_screen.dart`) - Display XP/Level/Tokens
- [ ] Implement Rating Screen UI & Logic (`lib/features/booking/screens/rating_screen.dart`)

## Feature Implementation - Social & Gamification
- [ ] Implement basic Social Feed Screen UI (`lib/features/feed/screens/feed_screen.dart`)
- [ ] Implement Post Card Widget (`lib/features/feed/widgets/post_card.dart`)
- [ ] Implement "Create Post" UI/Flow (Check-in, Share Style)
- [ ] Integrate GamificationService calls for relevant actions (booking, rating, posting, commenting, liking)
- [ ] Implement UI feedback for XP/Token gains
- [ ] Implement Level Up UI feedback/animation

## Polish & Extras
- [ ] Implement screen transitions (slide/fade) via `go_router`.
- [ ] Implement button press animations/haptics.
- [ ] Implement loading indicators/shimmers (`LoadingIndicator` widget).
- [ ] Add illustrations to relevant screens (Onboarding, Empty States, Success).
- [ ] Implement Splash Screen animation (Rive/Lottie).
- [ ] Implement responsive typography scaling (if deemed necessary).
- [ ] Thorough Accessibility testing (Manual + Tools).
- [ ] Thorough cross-device/platform testing (Manual).

## Infrastructure & Backend
- [ ] Setup Android Studio / Android SDK / Emulator. (Ref: KNOWN_ISSUES #01)
- [ ] Configure iOS build setup (requires macOS/Xcode).
- [ ] Define and implement `RealApiService` when backend is ready.
- [ ] Setup CI/CD pipeline (GitHub Actions / Codemagic).

---

*(Update status and add new items as development progresses)*
