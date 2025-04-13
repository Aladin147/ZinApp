# ZinApp V2 - Key Decisions Log

This document records significant architectural, technical, or design decisions made during the ZinApp V2 project, along with their rationale.

---

## 2025-04-10

*   **Decision:** Migrate from React Native (V1) to Flutter for V2.
    *   **Rationale:** Align with shareholder memo's emphasis on high-fidelity UI/UX and custom animations. Leverage Flutter's capabilities for the desired V2 visual and interactive goals. Address limitations encountered in V1. A complete rebuild approach was chosen over direct porting due to the significant UI/UX paradigm shift.
    *   **Reference:** `docs/v2/V2_MIGRATION_GUIDE.md`, Shareholder Memo

*   **Decision:** Adopt a layered architecture (Presentation, Domain, Data) combined with a feature-first project structure (`lib/features/`).
    *   **Rationale:** Promotes separation of concerns (Clean Architecture principles), modularity, testability, and maintainability as the application scales. Aligns with common Flutter best practices.
    *   **Reference:** `docs/technical_architecture.md`, `docs/V2_ARCHITECTURE.md`, `docs/V2_FILE_STRUCTURE.md`

*   **Decision:** Use Riverpod as the **sole and standard** state management solution.
    *   **Rationale:** Riverpod offers compile-safe dependency injection, simplified state management patterns (StateNotifierProvider, FutureProvider, etc.), reduced boilerplate (especially with code generation), and enhanced testability. The migration from any previous solutions is complete.
    *   **Reference:** `docs/V2_ARCHITECTURE.md`, `docs/developer_guides/state_management_with_riverpod.md`

*   **Decision:** Use `go_router` for navigation and routing.
    *   **Rationale:** Provides declarative, URL-based routing suitable for web and mobile, simplifies deep linking, and integrates well with Riverpod for route guarding.
    *   **Reference:** `docs/V2_ARCHITECTURE.md`, `lib/router/`

*   **Decision:** Implement an abstract `ApiService` interface (`lib/services/api_service.dart`) with distinct `MockApiService` and potentially `RealApiService` implementations. Use a configuration flag (`lib/config/env.dart`) and DI (via Riverpod) to switch between them.
    *   **Rationale:** Decouples data fetching logic from the rest of the application, facilitates testing with mock data, and allows easy switching to a live backend later.
    *   **Reference:** `docs/V2_DATA_HANDLING.md` (Review/Update this doc if needed), `lib/services/`, `lib/config/`

*   **Decision:** Select Urbanist as the primary font family (Weights: 400, 600, 800), with Nunito and Inter as fallbacks. Drop usage of Uber Move font.
    *   **Rationale:** Urbanist aligns best with the desired "playful-premium" V2 aesthetic. Fallbacks ensure graceful degradation. Dropping Uber Move avoids potential licensing friction.
    *   **Reference:** `docs/V2_TYPOGRAPHY_SYSTEM.md`, `docs/design_system/typography.md` (Verify consistency)

*   **Decision:** Use `flutter_lints` as the base linting ruleset, augmented with specific stricter rules (`always_use_package_imports`, `prefer_const_constructors`, `require_trailing_commas`, `avoid_print`) defined in `analysis_options.yaml`.
    *   **Rationale:** Enforces code consistency and quality standards from the beginning.
    *   **Reference:** `docs/V2_DEV_SETUP.md`, `analysis_options.yaml`

*   **Decision:** Establish a "Living Documentation" system alongside technical specifications, including Development Journal, Known Issues, Decisions Log, Did Not Work Log, and Do Not Do guidelines.
    *   **Rationale:** Improve project tracking, knowledge sharing, transparency, and learning from past challenges.

---

*(Add new decisions with date, rationale, and references as they are made)*
