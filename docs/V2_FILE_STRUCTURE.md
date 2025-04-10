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
├── lib/                 # Main Dart application code
│   ├── main.dart        # App entry point
│   ├── app/             # Core app setup, routing, theme
│   ├── config/          # Environment configuration
│   ├── constants/       # App-wide constants (design tokens, strings)
│   ├── features/        # Feature-specific modules (screens, widgets, logic)
│   ├── models/          # Data models (plain Dart objects)
│   ├── services/        # Business logic services (API, gamification, etc.)
│   ├── utils/           # Utility functions and helpers
│   └── widgets/         # Common reusable widgets (shared across features)
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

-   **`main.dart`**: Initializes the app, sets up providers/service locators, and runs the main `App` widget.
-   **`app/`**:
    -   `app.dart`: Root `MaterialApp` or `CupertinoApp` widget.
    -   `theme.dart`: Defines the application theme (colors, typography, component themes) based on design tokens.
    -   `router.dart`: Defines navigation routes and logic (e.g., using `go_router` or `Navigator 2.0`).
-   **`config/`**:
    -   `env.dart`: Environment configuration (e.g., API base URL, mock data toggle flag). See `V2_DEV_SETUP.md`.
-   **`constants/`**:
    -   `app_colors.dart`: Color constants/tokens.
    -   `app_typography.dart`: TextStyle constants/tokens.
    -   `app_spacing.dart`: Spacing constants (padding, margins).
    -   `app_animations.dart`: Animation duration/curve constants.
    -   `app_strings.dart`: String constants for localization (or use dedicated localization package).
    -   `design_tokens.dart`: (Optional) Central file importing/exporting all token types.
-   **`features/`**: **(Primary Location for Feature Development)**
    -   Organized by feature domain (e.g., `booking`, `authentication`, `profile`, `stylist_discovery`, `feed`).
    -   Each feature directory typically contains:
        -   `screens/`: Widgets representing full screens/pages.
        -   `widgets/`: Widgets specific to this feature.
        -   `cubit/` or `bloc/` or `provider/`: State management logic for the feature.
        -   `logic/` or `usecases/`: Feature-specific business logic (if not in a global service).
    -   Example:
        ```
        lib/features/booking/
        ├── screens/
        │   ├── booking_screen.dart
        │   └── service_select_screen.dart
        ├── widgets/
        │   ├── booking_card.dart
        │   └── service_button.dart
        └── cubit/
            └── booking_cubit.dart
        ```
-   **`models/`**: Contains plain Dart objects representing data structures (e.g., `user.dart`, `stylist.dart`, `booking.dart`). Should include `fromJson`/`toJson` methods if applicable.
-   **`services/`**:
    -   `api_service.dart`: Abstract interface for data fetching.
    -   `mock_api_service.dart`: Mock implementation using local JSON.
    -   `real_api_service.dart`: Real implementation using HTTP client.
    -   `gamification_service.dart`: Logic for calculating XP, levels, tokens.
    -   `auth_service.dart`: Authentication logic (login, logout, token management).
    -   `notification_service.dart`: Handling push notifications (if applicable).
-   **`utils/`**: General utility functions, extensions, formatters, validators, etc. (e.g., `date_formatter.dart`, `validators.dart`).
-   **`widgets/`**: **(Common Reusable Widgets)**
    -   Contains highly reusable UI components shared across multiple features (e.g., `CustomButton`, `Avatar`, `LoadingIndicator`, `ScreenWrapper`, `CardWrapper`).

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
