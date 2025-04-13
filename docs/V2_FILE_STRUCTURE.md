# ZinApp V2 Flutter Project File Structure

This document defines the standard file and directory structure for the ZinApp V2 Flutter project. Adhering to this structure ensures consistency, maintainability, and ease of navigation.

## 1. Root Directory Structure

```
zinapp_v2_flutter/
├── android/             # Android specific files
├── assets/              # Static assets (images, fonts, mock data, etc.)
│   ├── fonts/
│   ├── icons/
│   ├── illustrations/
│   ├── lottie/          # Lottie animation files (if used)
│   └── rive/            # Rive animation files (if used)
├── ios/                 # iOS specific files
├── lib/                 # Main Dart application code (See details below)
├── linux/               # Linux specific files (if supporting desktop)
├── macos/               # macOS specific files (if supporting desktop)
├── test/                # Automated tests
│   ├── unit/
│   ├── widget/
│   └── integration/
├── web/                 # Web specific files (if supporting web)
├── windows/             # Windows specific files (if supporting desktop)
├── .gitignore
├── analysis_options.yaml # Dart analyzer configuration
├── pubspec.lock
├── pubspec.yaml         # Flutter project dependencies and metadata
└── README.md            # Project README
```

## 2. `lib/` Directory Deep Dive

```
lib/
├── common/               # Common utilities, widgets, or constants used across features
│
├── config/               # Application configuration (e.g., themes, environment settings)
│   └── themes/           # Theme definitions (extracted from lib/theme)
│
├── constants/            # Application-wide constants (e.g., API keys, route names, design tokens)
│
├── features/             # Core feature modules (e.g., auth, feed, profile) - See structure below
│
├── models/               # Shared data models/entities (if any not specific to a feature)
│
├── navigation/           # Navigation logic (potentially GoRouter setup) - Replaced router/
│
├── providers/            # Global Riverpod providers (app-wide state, services)
│
├── router/               # Routing configuration (likely using GoRouter)
│
├── services/             # Shared application services (e.g., API, Auth, Storage)
│
├── theme/                # App theming (Consider moving fully into config/themes)
│
├── utils/                # General utility functions
│
├── widgets/              # Common shared widgets used across multiple features
│
├── error_screen.dart     # Generic error screen
├── main.dart             # Application entry point
└── riverpod_app.dart     # Root application widget integrating Riverpod
```

-   **`main.dart`**: Initializes the app, sets up global Riverpod providers (`ProviderScope`), and runs the main `RiverpodApp` widget.
-   **`riverpod_app.dart`**: Root `MaterialApp` (or similar) widget, configured with the theme and router.
-   **`error_screen.dart`**: A generic screen displayed for routing errors or other unhandled states.
-   **`common/`**: Contains utilities, base classes, or widgets that are shared across multiple features but don't fit into `utils/` or `widgets/`.
-   **`config/`**: Application-level configuration.
    -   `themes/`: Contains theme definitions (`color_scheme.dart`, `text_theme.dart`, `app_theme.dart`).
    -   May contain environment-specific configuration files if needed.
-   **`constants/`**: Holds application-wide constants like API endpoints, keys, route names, duration values, potentially design tokens (colors, spacing, typography constants if not solely in `theme/`).
-   **`features/`**: **(Primary Location for Feature Development)**
    -   Organized by feature domain (e.g., `auth`, `feed`, `profile`, `booking`).
    -   Each feature follows a layered structure:
        ```
        lib/features/[feature_name]/
        ├── data/         # Data layer implementation
        │   ├── datasources/ # API client calls, local storage access
        │   ├── models/      # Data Transfer Objects (DTOs), request/response models
        │   └── repositories/ # Implementation of domain repositories
        ├── domain/       # Business logic and rules
        │   ├── entities/    # Core business objects/models
        │   ├── repositories/ # Abstract repository interfaces
        │   └── usecases/    # Feature-specific operations/interactions
        ├── presentation/ # UI and State Management (Riverpod)
        │   ├── providers/  # Riverpod providers (StateNotifiers, FutureProviders, etc.)
        │   ├── screens/    # Widgets representing full screens/pages
        │   └── widgets/    # Reusable widgets specific to this feature
        └── feature_name_exports.dart # Optional: Exports public API of the feature
        ```
-   **`models/`**: Contains shared data models/entities used across multiple features, if any. Often, models are specific to a feature's domain layer.
-   **`navigation/`**: May contain navigation-related utilities or helpers, potentially interacting with the router.
-   **`providers/`**: Contains global Riverpod providers, such as those exposing shared services (`apiServiceProvider`, `authServiceProvider`) or managing application-wide state (e.g., `appSettingsProvider`).
-   **`router/`**: Defines the application's navigation routes using `go_router` (e.g., `app_router.dart`). Includes route definitions, parameters, and potentially route guards.
-   **`services/`**: Contains shared, application-level services providing access to external resources or capabilities (e.g., `ApiService`, `AuthService`, `StorageService`, `NotificationService`). These are typically injected via global Riverpod providers.
-   **`theme/`**: Defines the application's visual theme (colors, typography, component styles). *Consider consolidating fully into `config/themes/`.*
-   **`utils/`**: General utility functions, extensions, formatters, validators, etc., not specific to any feature (e.g., `date_formatter.dart`, `validators.dart`).
-   **`widgets/`**: **(Common Reusable Widgets)** Contains highly reusable UI components shared across multiple features (e.g., `AppButton`, `Avatar`, `LoadingIndicator`, `CardWrapper`).

## 3. `assets/` Directory

-   Organize assets logically.
-   Use subdirectories for different asset types (`fonts`, `icons`, `illustrations`, `lottie`, `rive`).
-   Ensure assets are declared in `pubspec.yaml`.

## 4. `test/` Directory

-   Mirror the `lib/` structure where appropriate.
-   Place unit tests (`_test.dart`) alongside the code they test or in corresponding `test/unit/` directories.
-   Place widget tests (`_test.dart`) alongside the widgets they test or in corresponding `test/widget/` directories.
-   Place integration tests in `test/integration/`.

## 5. Naming Conventions
   - **Files:** `snake_case.dart` (e.g., `booking_screen.dart`, `api_service.dart`).
   - **Classes:** `PascalCase` (e.g., `BookingScreen`, `ApiService`).
   - **Variables/Functions:** `camelCase` (e.g., `userName`, `fetchUserProfile`).
   - **Constants:** `camelCase` or `UPPER_SNAKE_CASE` (e.g., `defaultPadding`, `API_TIMEOUT`).
   - **Private Members:** Prefix with underscore `_` (e.g., `_internalCounter`, `_fetchData`).

## 6. Rationale
   - **Modularity:** Feature-based structure promotes separation of concerns and scalability.
   - **Discoverability:** Consistent structure makes it easier to find code.
   - **Reusability:** Clear separation of common widgets and utilities.
   - **Testability:** Structure facilitates unit, widget, and integration testing.
   - **Alignment:** Follows common conventions in the Flutter community.
