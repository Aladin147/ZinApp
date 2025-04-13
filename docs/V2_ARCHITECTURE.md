# ZinApp V2 Flutter Application Architecture

## 1. Overview
   - **Goal:** To establish a clean, scalable, maintainable, and testable architecture for the ZinApp V2 Flutter application.
   - **Approach:** We will adopt a layered architecture combined with a feature-first project structure and a suitable state management solution. This promotes separation of concerns and modularity.

## 2. Core Architectural Layers
   The application will be broadly divided into the following layers:

   - **Presentation Layer:**
     - **Responsibility:** Handles UI rendering, user input, and displaying data from the state management layer. Contains Widgets (Screens, Components).
     - **Components:** Flutter Widgets (`StatelessWidget`, `StatefulWidget`), Screens (`lib/features/*/presentation/screens/`), Reusable Widgets (`lib/widgets/`, `lib/features/*/presentation/widgets/`).
     - **Interaction:** Interacts with the State Management layer (Riverpod providers) to get data and trigger actions/events.

   - **State Management Layer (Integrated with Presentation/Domain):**
     - **Responsibility:** Manages the application's state, handles UI events triggered from the Presentation Layer, and interacts with the Domain/Service Layer to fetch/update data. Primarily implemented using Riverpod.
     - **Components:** Riverpod Providers (`StateNotifierProvider`, `FutureProvider`, `StreamProvider`, `Provider`) located in `lib/providers/` (global) and `lib/features/*/presentation/providers/` (feature-specific).
     - **Interaction:** Provides state streams/values to the Presentation Layer. Calls methods on the Domain/Service Layer.

   - **Domain Layer:**
     - **Responsibility:** Encapsulates core business logic, use cases, and domain entities, independent of UI and data sources.
     - **Components:** Entities/Models (`lib/models/`, `lib/features/*/domain/entities/`), Use Cases/Interactors (`lib/features/*/domain/usecases/`).
     - **Interaction:** Called by the State Management Layer (Providers). Interacts with abstract Repository interfaces defined here.

   - **Data Layer:**
     - **Responsibility:** Handles data fetching, storage, and retrieval from various sources (API, local DB, etc.). Implements Repository interfaces defined in the Domain Layer.
     - **Components:** Repositories (`lib/features/*/data/repositories/`), Data Sources (`lib/features/*/data/datasources/`), Data Transfer Objects (DTOs) (`lib/features/*/data/models/`). Shared services like `ApiService` (`lib/services/`) act as data sources.
     - **Interaction:** Accessed by the Domain Layer via Repository interfaces. Interacts with external sources (network, storage).

   - **Core / Shared Layer:**
     - **Responsibility:** Contains application-wide utilities, constants, theme, routing, shared widgets, and base configurations not specific to any feature.
     - **Components:** Code within `lib/common/`, `lib/config/`, `lib/constants/`, `lib/navigation/`, `lib/providers/` (global ones), `lib/router/`, `lib/services/`, `lib/theme/`, `lib/utils/`, `lib/widgets/`.

## 3. State Management Strategy
   - **Chosen Solution:** **Riverpod**. The application has been fully migrated to Riverpod for state management and dependency injection.
   - **Rationale:** Riverpod offers compile-safe dependency injection, simplifies state management patterns (Provider, FutureProvider, StateNotifierProvider), reduces boilerplate, promotes testability, and handles asynchronous operations effectively.
   - **Implementation:**
     - Use `StateNotifierProvider` for managing mutable screen/feature state.
     - Use `Provider` for simple dependency injection of services (e.g., `apiServiceProvider` defined in `lib/providers/` or feature-specific providers).
     - Use `FutureProvider` / `StreamProvider` for handling asynchronous data fetching and caching.
     - State logic (Providers) resides within `lib/providers/` (global) and `lib/features/*/presentation/providers/` (feature-specific).

## 4. Navigation / Routing
   - **Chosen Solution:** **`go_router`**.
   - **Rationale:** `go_router` provides declarative, URL-based routing, simplifies deep linking, handles platform back buttons correctly, and integrates well with Riverpod for route guarding.
   - **Implementation:** Route configuration resides in `lib/router/` (e.g., `app_router.dart`). Use `context.go()`, `context.push()` for navigation. Implement route guards using Riverpod providers to check authentication status or other conditions.

## 5. Dependency Injection
   - **Approach:** Riverpod is used exclusively for dependency injection.
   - **Implementation:** Define providers for services (e.g., `apiServiceProvider` in `lib/providers/service_providers.dart`) and access them within other providers or widgets using `ref.watch`/`ref.read`.

## 6. Error Handling
   - **Strategy:**
     - Service layer methods return `Future`s that complete with data or throw specific, typed exceptions (e.g., `ApiException`, `NetworkException`, `NotFoundException`).
     - State management layer catches these exceptions, updates the state to reflect the error (e.g., `state = AsyncError(...)` in Riverpod, or a specific error property), and potentially triggers side effects (e.g., showing a snackbar).
     - Presentation layer listens to the error state and displays appropriate UI feedback (error messages, retry buttons).
     - Use `ErrorBoundary` widgets (custom or package-based) for catching unexpected UI rendering errors.
     - Integrate crash reporting (Crashlytics/Sentry) for unhandled exceptions (See `V2_APP_LIFECYCLE.md`).

## 7. Modularity & Feature Slicing
   - **Feature Folders:** The `lib/features/` directory is central. Each major feature (booking, auth, feed, profile) gets its own folder containing subdirectories for `data`, `domain`, and `presentation` layers.
   - **Shared Components:** Truly reusable widgets reside in `lib/widgets/`. Common utilities are in `lib/common/` or `lib/utils/`. Shared services are in `lib/services/`. Global providers are in `lib/providers/`.
   - **Dependencies:** Features depend on the Core/Shared layer components (services, models, constants, shared widgets, global providers). Direct dependencies *between* features should be minimized; communication typically occurs via shared services or coordinated state management (global providers).

## 8. Testing Considerations
   - The layered architecture and dependency injection facilitate testing:
     - **Unit Tests:** Test services and state logic by mocking dependencies (e.g., mock `ApiService` when testing a state notifier).
     - **Widget Tests:** Test widgets by providing mock state or mock service implementations via providers.
     - **Integration Tests:** Test flows by providing the `MockApiService` implementation.
   - (See `V2_TEST_STRATEGY.md` for more details).
