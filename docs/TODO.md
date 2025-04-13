# ZinApp V2 - TODO List

This file tracks pending tasks, features, refactoring items, and other actionable points for the ZinApp V2 project. Refer to `V2_ROADMAP.md` for milestone context.

---

## Sprint 1: Foundation & Mock Backend (Completed: 2025-04-13)
*Goal: Establish core app structure, implement mock authentication & persistence, set up mock backend, and address critical UI issues.*

### UI & Layout
- [x] **Fix Critical UI Overflows:** Apply initial fixes (SafeArea, SingleChildScrollView) to TokenShop, AchievementsCard, ChallengesCard. Improve image error placeholder in TrendingStylesCard. (Ref: `a3c8d12`)
- [ ] **Further Overflow Validation:** Test thoroughly on various screen sizes and fix remaining overflows.

### Mock Backend & Data Layer
- [x] **JSON Server Setup:** Update `db.json` with challenges/streaks, create `start_json_server.bat`, run server via npx. (Ref: `b7f6ee6`)
- [x] **Remote Data Sources:** Implement interfaces and `dio`-based implementations for User, Stylist, Post, Comment, Booking, Gamification entities connecting to `json-server`. (Ref: `b7f6ee6`)
- [x] **Models:** Create `Badge` and `Challenge` models. (Ref: `b7f6ee6`)
- [x] **Dependencies:** Add `dio`. (Ref: `b7f6ee6`)

### Authentication & Persistence
- [x] **Local Persistence:** Implement `LocalStorageService` using `shared_preferences`. (Ref: `b7f6ee6`)
- [x] **Auth Repository:** Implement `AuthRepository` connecting `AuthProvider` to `UserRemoteDataSource` and `LocalStorageService`. (Ref: `b7f6ee6`)
- [x] **Auth Provider:** Update `AuthProvider` to use `AuthRepository`. (Ref: `b7f6ee6`)
- [x] **Auth State (Temporary):** Modify `AuthState` to temporarily use `User` instead of `UserProfile` (Requires refactor). (Ref: `b7f6ee6`)
- [x] **Auth UI:** Scaffold basic `LoginScreen`. (Ref: `b7f6ee6`)
- [ ] **Auth Flow:** Implement actual user creation on registration via `UserRemoteDataSource`.
- [ ] **Auth Flow:** Implement proper `UserProfile` fetching after authentication in `AuthProvider`.
- [ ] **Auth UI:** Implement `RegistrationScreen`.

### Testing
- [x] **Setup:** Confirm `test/` structure and dependencies (`flutter_test`, `mockito`). (Ref: `b7f6ee6`)
- [x] **Widget Test:** Add initial widget test for `ZinButton`. (Ref: `b7f6ee6`)
- [ ] **Unit Tests:** Add unit tests for `AuthRepository`, `LocalStorageService`.
- [ ] **Integration Tests:** Add basic integration test for login flow using mock backend.

### Build & Generation
- [x] **Code Generation:** Run `build_runner` to generate `.g.dart` files for new models and providers. (Ref: `b7f6ee6`)

## Sprint 2: Gamification Engine & Refinement (Next Steps)
*Goal: Implement core gamification logic, expand testing, implement basic error handling, and enhance component showcase.*

### Gamification Engine
- [ ] **Logic Implementation:** Build core engine logic in Simulation layer (XP rules, token transactions, level-up, achievements, challenges, streaks).
- [ ] **Repository Integration:** Connect Gamification logic to repositories (using `json-server` for now).
- [ ] **State Management:** Refine providers (`UserProfileProvider`?) to manage detailed profile/gamification state separately from core `AuthState`.
- [ ] **Refactor AuthState:** Update `AuthState` and `AuthProvider` to correctly handle `UserProfile` fetching after authentication.

### Testing
- [ ] **Gamification Unit Tests:** Write unit tests for the Simulation layer gamification logic.
- [ ] **Repository/DataSource Tests:** Add tests for repository interactions with mock data sources.
- [ ] **Integration Tests:** Expand integration tests for auth and gamification flows using `json-server`.

### Error Handling & Polish
- [ ] **Error Handling Layer:** Implement global error handling (`ZinErrorWidget`, `AsyncValue.guard`). Handle network errors from `json-server`.
- [ ] **UI Polish:** Address remaining UI feedback (visual overload in Rewards, card consistency, etc.).
- [ ] **Component Showcase:** Enhance showcase with mock data generators reflecting engine states.

## Backlog / Future Sprints
- [ ] **Booking Engine:** Implement full booking flow logic and UI.
- [ ] **Social Feed (FYP):** Implement feed screen and components.
- [ ] **Onboarding Flow:** Create introductory screens for new users.
- [ ] **Stylist Discovery:** Implement search, filters, profile view.
- [ ] **Real API Integration:** Replace `json-server` with Firebase/Supabase/etc.
- [ ] **Advanced Gamification:** Leaderboards, advanced challenges, marketplace.
- [ ] **Advanced Social:** Posting, comments, following.
- [ ] **Push Notifications**
- [ ] **Payment Integration**
- [ ] **CI/CD Setup**
- [ ] **E2E Testing**
- [ ] **Performance Tuning**
- [ ] **iOS Setup**
- [ ] **Known Issues:** Address remaining items from `KNOWN_ISSUES.md`.

---

*(This list replaces the previous phase structure. Update status and add new items as development progresses)*
