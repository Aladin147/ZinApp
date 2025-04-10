# ZinApp V2 - Key Decisions Log

This document records significant architectural, technical, or design decisions made during the ZinApp V2 project, along with their rationale.

---

## 2025-04-10

*   **Decision:** Migrate from React Native (V1) to Flutter for V2.
    *   **Rationale:** Align with shareholder memo's emphasis on high-fidelity UI/UX and custom animations. Leverage Flutter's capabilities for the desired V2 visual and interactive goals. Address limitations encountered in V1. A complete rebuild approach was chosen over direct porting due to the significant UI/UX paradigm shift.
    *   **Reference:** `docs/v2/V2_MIGRATION_GUIDE.md`, Shareholder Memo

*   **Decision:** Adopt a layered architecture featuring Presentation, State Management, Service/Business Logic, and Data layers. Structure code using a feature-first approach (`lib/features/`).
    *   **Rationale:** Promotes separation of concerns, modularity, testability, and maintainability as the application scales. Aligns with common Flutter best practices.
    *   **Reference:** `docs/v2/V2_ARCHITECTURE.md`, `docs/v2/V2_FILE_STRUCTURE.md`

*   **Decision:** Use Riverpod as the primary state management solution, with Provider as a fallback.
    *   **Rationale:** Riverpod offers compile-safe dependency injection, simplified state management patterns (StateNotifierProvider, FutureProvider), reduced boilerplate, and enhanced testability compared to Provider alone.
    *   **Reference:** `docs/v2/V2_ARCHITECTURE.md`

*   **Decision:** Use `go_router` for navigation and routing.
    *   **Rationale:** Provides declarative, URL-based routing suitable for web and mobile, simplifies deep linking, and integrates well with state management for route guarding.
    *   **Reference:** `docs/v2/V2_ARCHITECTURE.md`

*   **Decision:** Implement an abstract `ApiService` interface with distinct `MockApiService` (using local JSON) and `RealApiService` (using HTTP client) implementations. Use a configuration flag (`lib/config/env.dart`) and DI (via Riverpod/Provider) to switch between them.
    *   **Rationale:** Decouples data fetching logic from the rest of the application, facilitates testing with mock data, and allows easy switching to a live backend later.
    *   **Reference:** `docs/v2/V2_DATA_HANDLING.md`

*   **Decision:** Select Urbanist as the primary font family (Weights: 400, 600, 800), with Nunito and Inter as fallbacks. Drop usage of Uber Move font.
    *   **Rationale:** Urbanist aligns best with the desired "playful-premium" V2 aesthetic. Fallbacks ensure graceful degradation. Dropping Uber Move avoids potential licensing friction.
    *   **Reference:** `docs/v2/V2_TYPOGRAPHY_SYSTEM.md`

*   **Decision:** Use `flutter_lints` as the base linting ruleset, augmented with specific stricter rules (`always_use_package_imports`, `prefer_const_constructors`, `require_trailing_commas`) defined in `analysis_options.yaml`.
    *   **Rationale:** Enforces code consistency and quality standards from the beginning.
    *   **Reference:** `docs/v2/V2_DEV_SETUP.md`

*   **Decision:** Establish a "Living Documentation" system alongside technical specifications, including Development Journal, Known Issues, Decisions Log, Did Not Work Log, and Do Not Do guidelines.
    *   **Rationale:** Improve project tracking, knowledge sharing, transparency, and learning from past challenges.

---

*(Add new decisions with date, rationale, and references as they are made)*
