# ZinApp V2 - TODO List

This file tracks pending tasks, features, refactoring items, and other actionable points for the ZinApp V2 project. Refer to `V2_ROADMAP.md` for milestone context.

---

## Phase 1: Foundation (2-3 weeks)
*Goal: Establish core app structure, implement local authentication, and create the foundation for the split-screen home layout.*

### Local Authentication System
- [x] **JSON Server Setup:** Install and configure JSON Server for local authentication
- [x] **User Data Model:** Create initial user data structure with gamification fields
- [x] **Auth Service:** Implement `AuthService` with register, login, logout functionality
- [x] **Secure Storage:** Integrate `flutter_secure_storage` for session persistence
- [x] **Auth UI:** Enhance existing login and registration screens
- [x] **Form Validation:** Add comprehensive validation for auth forms
- [x] **Error Handling:** Implement proper error messages and loading states
- [x] **Documentation:** Create detailed authentication system specification

### Core Navigation & Structure
- [x] **Dependencies:** Add required packages (`http`, `flutter_secure_storage`, etc.)
- [x] **Router Setup:** Configure GoRouter with protected routes
- [ ] **Navigation Shell:** Implement bottom navigation or drawer
- [x] **State Management:** Set up provider pattern for app-wide state
- [x] **Service Layer:** Create service abstractions for API communication
- [x] **Dependency Injection:** Set up service provider system

### Extended Data Models
- [x] **User Profile:** Extend model with XP, level, tokens, achievements
- [x] **Stylist Profile:** Enhance with availability, rating, services
- [x] **Social Content:** Improve post structure with engagement metrics
- [x] **Mock Data:** Create comprehensive test data for development
- [x] **Documentation:** Document data models and relationships

## Phase 2: Split-Screen Home Implementation (3-4 weeks)
*Goal: Create the innovative three-section home screen layout with gamified HUD, action zone, and social feed.*

### Basic Layout Structure
- [x] **Container Component:** Create three-section layout container
- [x] **Responsive Behavior:** Implement adaptive sizing for different screens
- [ ] **Section Coordination:** Set up shared state between sections
- [ ] **Scroll Behavior:** Implement proper scrolling and interaction handling
- [ ] **Transition Animations:** Add smooth animations between states

### HUD Dashboard Implementation
- [x] **Player Stats Display:** Create level and XP visualization
- [x] **Token Display:** Implement token balance with animation
- [x] **Rank Display:** Add user rank/title component
- [ ] **Achievement Indicator:** Create recent achievements display
- [x] **Visual Design:** Implement neon-on-dark aesthetic with animations

### Action & Discovery Zone
- [x] **Stylist Cards:** Create horizontally scrollable stylist cards
- [x] **Availability Indicators:** Add real-time availability status
- [x] **Quick Actions:** Implement primary action buttons
- [ ] **Daily Challenges:** Create challenge cards with rewards
- [ ] **Recommendations:** Add personalized recommendation system

### Enhanced Feed Section
- [x] **Post Cards:** Improve design with engagement metrics
- [x] **Media Support:** Add rich media content capabilities
- [x] **Interaction Buttons:** Implement like, comment, share functionality
- [ ] **Feed Filters:** Create tabs for different content types
- [ ] **Infinite Scrolling:** Implement efficient content loading

## Phase 3: Gamification Implementation (2-3 weeks)
*Goal: Implement the core gamification systems including XP, levels, tokens, and achievements.*

### XP & Leveling System
- [ ] **XP Calculation:** Implement action-based XP rewards
- [ ] **Level Progression:** Create level-up logic and animations
- [ ] **Rank System:** Implement title changes based on level
- [ ] **Progress Visualization:** Create XP bar with animations
- [ ] **Milestone Rewards:** Add level-up rewards and bonuses

### ZinToken Economy (Basic)
- [ ] **Token Earning:** Implement content creation rewards
- [ ] **Engagement Rewards:** Add interaction-based token earning
- [ ] **Challenge Rewards:** Create quest completion bonuses
- [ ] **Token History:** Implement transaction logging
- [ ] **Basic Spending:** Add simple token redemption options

### Achievement System
- [ ] **Achievement Tracking:** Create milestone-based achievements
- [ ] **Unlock Logic:** Implement achievement unlocking system
- [ ] **Notification System:** Add achievement unlock notifications
- [ ] **Achievement UI:** Create achievement showcase in profile
- [ ] **Progress Tracking:** Add incomplete achievement progress

## Completed Tasks
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
- [x] Create comprehensive implementation plan
- [x] Design local authentication strategy
- [x] Design split-screen home layout
- [x] Create ZinToken economy design

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
