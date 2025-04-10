# ZinApp V2 React Native to Flutter Migration Guide

## 1. Overview
   - **Goal:** To outline the strategy and steps for migrating the ZinApp application from the existing V1 React Native (Expo) codebase to the new V2 Flutter platform.
   - **Decision:** As confirmed, V2 will be built entirely in Flutter. The React Native codebase (`master` branch or a dedicated archive branch) will serve as a reference for logic and features but will not be directly ported.
   - **Approach:** This will be a **complete rebuild** in Flutter, not a line-by-line translation. We will leverage the V1 codebase primarily for understanding existing business logic, feature scope, and API interactions (where applicable).

## 2. Rationale for Rebuild (vs. Porting)
   - **Significant UI/UX Overhaul:** V2 introduces a completely new brand identity, design system, and user experience philosophy (gamification, social elements) that differs substantially from V1. Rebuilding allows implementing this new vision cleanly.
   - **Platform Differences:** React Native and Flutter have fundamentally different approaches to UI rendering, state management, navigation, and native integrations. A direct port would be inefficient and likely result in non-idiomatic Flutter code.
   - **Opportunity for Improvement:** Rebuilding provides a chance to implement best practices, improve architecture (as defined in `V2_ARCHITECTURE.md`), enhance performance, and address any technical debt from V1.

## 3. Migration Strategy
   - **Phase 1: Foundation & Core Setup (Current Focus)**
     - Set up the new Flutter project (`zinapp_v2_flutter`).
     - Establish core architecture: Layered structure, state management (Riverpod), navigation (`go_router`).
     - Define and implement core design tokens (colors, typography, spacing) in Flutter theme (`lib/app/theme.dart`).
     - Set up development environment standards (`V2_DEV_SETUP.md`).
     - Define core documentation (`V2_*` documents).
     - Implement mock data handling (`V2_DATA_HANDLING.md`, `MockApiService`).
   - **Phase 2: Core Component & Shared Widget Implementation**
     - Build the common reusable widgets (`lib/widgets/`) based on `V2_COMPONENT_SYSTEM.md` and `V2_BRAND_IDENTITY.md` (e.g., `AppButton`, `AppCard`, `ScreenWrapper`).
     - Develop using Storybook (optional) for isolated testing and visualization.
   - **Phase 3: Feature Re-implementation (Iterative)**
     - Rebuild features one by one, prioritizing core user flows.
     - **For each feature:**
       - **Analyze V1 Logic:** Review the corresponding React Native feature code (`screens/`, `components/`, state logic) to understand the required functionality, business rules, and API interactions.
       - **Design V2 UI:** Implement the V2 UI for the feature's screens using Flutter widgets, adhering to the new design system and component guidelines.
       - **Implement State Management:** Create Riverpod providers/notifiers (or chosen alternative) for the feature's state.
       - **Integrate Services:** Connect the state management layer to the necessary services (`ApiService`, `GamificationService`, etc.).
       - **Write Tests:** Implement unit and widget tests for the new Flutter code.
     - **Potential Feature Order (Example):**
       1. Authentication (Login/Signup)
       2. Stylist Discovery (List/Map View, Profile View)
       3. Core Booking Flow (Service Selection, Booking Screen, Confirmation)
       4. User Profile (Displaying info, XP/Tokens)
       5. Rating Flow
       6. Social Feed/FYP (Basic implementation)
       7. Live Tracking (If applicable)
   - **Phase 4: Gamification & Social Integration**
     - Integrate the `GamificationService` calls into relevant feature flows (booking completion, rating, posting).
     - Build out the UI elements for displaying XP, levels, tokens, and feed content.
   - **Phase 5: Polish, Testing & Refinement**
     - Implement animations and transitions (`V2_ANIMATION_SYSTEM.md`).
     - Add illustrations (`V2_ILLUSTRATION_SYSTEM.md`).
     - Conduct thorough testing (integration, manual, accessibility).
     - Refine UI based on testing and feedback.
     - Optimize performance.

## 4. Leveraging the V1 React Native Codebase
   - **Business Logic Reference:** Use V1 code to understand complex business rules, calculations, or specific sequences of operations.
   - **API Contract Reference:** Analyze how V1 interacted with any existing (or planned) backend APIs to inform the `ApiService` interface and `RealApiService` implementation.
   - **Feature Scope:** Use V1 as a checklist to ensure all necessary V1 features (that are still relevant for V2) are accounted for in the rebuild plan.
   - **DO NOT:** Copy-paste UI code or state management logic directly.

## 5. Data Migration (If Applicable)
   - **Scope:** This guide focuses on code migration. If user data from a V1 backend needs to be migrated to a V2 backend, a separate data migration plan is required.
   - **Mock Data:** V2 starts with fresh mock data as defined in `MOCK_API_SCHEMA.md`.

## 6. Archiving V1
   - Once V2 development is sufficiently advanced and stable, the V1 React Native codebase (`master` branch) can be archived (e.g., create an `archive/v1` branch or tag) for historical reference.
   - The `V2-Dev` branch will become the new `main` branch for the repository.

## 7. Key Considerations
   - **Team Familiarity:** Ensure the development team is comfortable with Flutter and Dart. Provide resources or training if needed.
   - **Time Estimate:** A full rebuild takes significant time. Set realistic expectations and milestones.
   - **Testing:** Rigorous testing is crucial to ensure the rebuilt application functions correctly and meets V2 standards.
