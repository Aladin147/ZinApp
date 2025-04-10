# ZinApp V2 Flutter Application Architecture

## 1. Overview
   - **Goal:** To establish a clean, scalable, maintainable, and testable architecture for the ZinApp V2 Flutter application.
   - **Approach:** We will adopt a layered architecture combined with a feature-first project structure and a suitable state management solution. This promotes separation of concerns and modularity.

## 2. Core Architectural Layers
   The application will be broadly divided into the following layers:

   - **Presentation Layer:**
     - **Responsibility:** Handles UI rendering, user input, and displaying data from the state management layer. Contains Widgets (Screens, Components).
     - **Components:** Flutter Widgets (`StatelessWidget`, `StatefulWidget`), Screens (`lib/features/*/screens/`), Reusable Widgets (`lib/widgets/`, `lib/features/*/widgets/`).
     - **Interaction:** Interacts with the State Management layer to get data and trigger actions/events.

   - **State Management Layer:**
     - **Responsibility:** Manages the application's state, handles UI events triggered from the Presentation Layer, and interacts with the Service/Business Logic Layer to fetch/update data.
     - **Components:** State management solutions like Riverpod (preferred) or Provider, implementing patterns like Notifiers, Cubits, or BLoCs. Logic resides primarily within feature folders (`lib/features/*/provider/` or `cubit/` etc.).
     - **Interaction:** Provides state streams/values to the Presentation Layer. Calls methods on the Service Layer.

   - **Service / Business Logic Layer:**
     - **Responsibility:** Encapsulates core business logic, data fetching/manipulation orchestration, and interaction with external services (API, storage, platform plugins).
     - **Components:** Abstract `ApiService`, `AuthService`, `GamificationService`, etc. (`lib/services/`). Concrete implementations (`MockApiService`, `RealApiService`). Feature-specific logic might reside in `lib/features/*/logic/` if not suitable for a global service.
     - **Interaction:** Called by the State Management Layer. Interacts with data sources (API, local storage) and potentially other services.

   - **Data Layer:**
     - **Responsibility:** Handles direct interaction with data sources (network API, local database, device storage, mock JSON files). Includes data models.
     - **Components:** `MockApiService` / `RealApiService` implementations (contain data source interaction logic), Data Models (`lib/models/`), potentially Repository pattern implementations if complexity increases.
     - **Interaction:** Accessed by the Service Layer.

   - **Core / Shared Layer:**
     - **Responsibility:** Contains application-wide utilities, constants, theme, routing, and base configurations not specific to any feature.
     - **Components:** Code within `lib/app/`, `lib/config/`, `lib/constants/`, `lib/utils/`.

## 3. State Management Strategy
   - **Chosen Solution:** **Riverpod** (or Provider as a fallback if Riverpod proves too complex initially).
   - **Rationale:**
     - **Riverpod:** Offers compile-safe dependency injection, simplifies state management patterns (Provider, FutureProvider, StateNotifierProvider), reduces boilerplate compared to Provider, and promotes testability.
     - **Provider:** Simpler learning curve, widely used, good for basic state management and dependency injection.
   - **Implementation:**
     - Use `StateNotifierProvider` (Riverpod) or `ChangeNotifierProvider` (Provider) for managing mutable screen/feature state.
     - Use `Provider` for simple dependency injection of services (`ApiService`, `GamificationService`).
     - Use `FutureProvider` / `StreamProvider` for handling asynchronous data fetching directly in the UI where appropriate.
     - State logic will primarily reside within the respective feature folders (`lib/features/*/provider/`).

## 4. Navigation / Routing
   - **Chosen Solution:** **`go_router`** (or potentially Navigator 2.0 directly if complex nested routing is needed).
   - **Rationale:** `go_router` provides declarative, URL-based routing, simplifies deep linking, handles platform back buttons correctly, and integrates well with state management for route guarding.
   - **Implementation:** Define routes in `lib/app/router.dart`. Use `context.go()`, `context.push()` for navigation. Implement route guards for authentication checks.

## 5. Dependency Injection
   - **Approach:** Leverage the chosen state management solution (Riverpod/Provider) for dependency injection.
   - **Implementation:** Define providers for services (`apiServiceProvider`, `gamificationServiceProvider`) at the top level of the application (`main.dart` or root widget) and access them within state notifiers or widgets using `ref.watch`/`ref.read` (Riverpod) or `context.watch`/`context.read` (Provider).

## 6. Error Handling
   - **Strategy:**
     - Service layer methods return `Future`s that complete with data or throw specific, typed exceptions (e.g., `ApiException`, `NetworkException`, `NotFoundException`).
     - State management layer catches these exceptions, updates the state to reflect the error (e.g., `state = AsyncError(...)` in Riverpod, or a specific error property), and potentially triggers side effects (e.g., showing a snackbar).
     - Presentation layer listens to the error state and displays appropriate UI feedback (error messages, retry buttons).
     - Use `ErrorBoundary` widgets (custom or package-based) for catching unexpected UI rendering errors.
     - Integrate crash reporting (Crashlytics/Sentry) for unhandled exceptions (See `V2_APP_LIFECYCLE.md`).

## 7. Modularity & Feature Slicing
   - **Feature Folders:** The `lib/features/` directory is central. Each major feature (booking, auth, feed, profile) gets its own folder containing all related screens, widgets, and state logic.
   - **Shared Components:** Truly reusable widgets (buttons, cards, avatars) reside in `lib/widgets/`. Avoid placing feature-specific widgets here.
   - **Dependencies:** Features should ideally depend on services, models, constants, and shared widgets, but minimize direct dependencies between features. Use service layer interactions or state management coordination for cross-feature communication if needed.

## 8. Testing Considerations
   - The layered architecture and dependency injection facilitate testing:
     - **Unit Tests:** Test services and state logic by mocking dependencies (e.g., mock `ApiService` when testing a state notifier).
     - **Widget Tests:** Test widgets by providing mock state or mock service implementations via providers.
     - **Integration Tests:** Test flows by providing the `MockApiService` implementation.
   - (See `V2_TEST_STRATEGY.md` for more details).
