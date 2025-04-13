# ZinApp Technical Architecture

## Overview
This document outlines the technical architecture for ZinApp, detailing the structure, patterns, and technologies used in the application.

## Architecture Pattern
ZinApp follows a layered architecture based on Clean Architecture principles, with clear separation of concerns:

### Layers
1. **Presentation Layer**
   - UI components (screens, widgets)
   - State management
   - Navigation

2. **Domain Layer**
   - Business logic
   - Entity models
   - Use cases

3. **Data Layer**
   - Repositories
   - Data sources (remote, local)
   - DTOs (Data Transfer Objects)

## Directory Structure
The project follows a feature-first directory structure, promoting modularity and separation of concerns.

```
lib/
├── common/               # Common utilities, widgets, or constants used across features
│
├── config/               # Application configuration (e.g., themes, environment settings)
│   └── themes/           # Theme definitions (extracted from lib/theme)
│
├── constants/            # Application-wide constants (e.g., API keys, route names)
│
├── features/             # Core feature modules (e.g., auth, feed, profile)
│   └── [feature_name]/
│       ├── data/         # Data layer: repositories, data sources, DTOs
│       ├── domain/       # Domain layer: entities, use cases
│       ├── presentation/ # Presentation layer: screens, widgets, providers/controllers
│       │   ├── providers/  # Riverpod providers specific to the feature
│       │   ├── screens/
│       │   └── widgets/
│       └── feature_name_exports.dart # Exports for the feature module
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
*Note: This structure is inferred from the `list_files` output and standard Flutter practices. Further refinement might be needed based on deeper inspection.*

## State Management
ZinApp has standardized on **Riverpod** for state management and dependency injection across the entire application. This ensures consistency and leverages Riverpod's capabilities for managing state immutably, handling asynchronous operations, and providing dependencies efficiently.

- **Providers (`lib/providers/`, `lib/features/*/presentation/providers/`)**: Define the application's state and dependencies. StateNotifierProvider, FutureProvider, StreamProvider, and Provider are used based on the specific state management needs.
- **ConsumerWidget/Consumer**: Used within the UI layer to listen to provider changes and rebuild widgets accordingly.
- **Ref**: Used within providers and widgets to read other providers or perform actions.

While `StatefulWidget` might still be used for purely local, ephemeral UI state (e.g., animation controllers, text field focus), all application state and business logic interaction is managed through Riverpod. The previous usage of Provider and ChangeNotifier has been fully migrated.

## Data Flow
1. **UI Layer**
   - Displays data to the user
   - Captures user input
   - Delegates to controllers/providers

2. **Controllers/Providers**
   - Process UI events
   - Coordinate between UI and business logic
   - Update UI state

3. **Use Cases**
   - Implement business rules
   - Orchestrate data operations
   - Return results to controllers

4. **Repositories**
   - Abstract data sources
   - Handle data operations
   - Convert between DTOs and domain models

5. **Data Sources**
   - Communicate with external systems (API, database)
   - Cache data locally
   - Handle data serialization/deserialization

## Authentication Flow
1. User enters credentials
2. AuthService validates credentials with Firebase Auth
3. On success, user token is stored securely
4. User profile is fetched from Firestore
5. User is redirected to the appropriate screen based on user type

## Navigation
- **GoRouter** for declarative routing
- Route guards for authentication checks
- Deep linking support
- Custom page transitions

## API Communication
- **Dio/http** package for HTTP requests
- Repository pattern to abstract API calls
- Error handling and retry logic
- Response caching

## Local Storage
- **SharedPreferences** for simple key-value storage
- **Hive** for complex object storage
- **SQLite** for relational data (if needed)

## Asset Management
- Images stored in assets directory
- SVG support for vector graphics
- Font assets for custom typography
- Asset generation for app icons

## Error Handling
- Global error handling
- User-friendly error messages
- Error logging and reporting
- Graceful degradation

## Testing Strategy
- **Unit Tests** for business logic and repositories
- **Widget Tests** for UI components
- **Integration Tests** for feature flows
- **Golden Tests** for UI appearance

## Security Considerations
- Secure storage of tokens
- Input validation
- HTTPS for all network requests
- Obfuscation of production code
- Regular security audits

## Performance Optimization
Significant focus has been placed on performance:
- **Image Optimization**: Implemented `CachedNetworkImage` (or similar) for efficient loading, caching, and placeholder/error handling for network images (Phase 6).
- **List Virtualization**: Employed techniques like lazy loading and pagination for long lists (e.g., feeds) to improve initial load times and reduce memory consumption (Phase 6).
- **Data Loading**: Optimized data fetching patterns, potentially including caching strategies for API responses and minimizing unnecessary data requests (Phase 6).
- **Build Time Optimization**: Addressed analyzer issues and deprecated APIs, contributing to potentially faster build times (Phase 1, 4).
- **State Management Efficiency**: Riverpod helps minimize unnecessary widget rebuilds compared to older patterns.
- **Code Splitting**: Dart's deferred loading can be used if needed for large features.

## Accessibility
- Semantic labels for screen readers
- Sufficient color contrast
- Scalable text
- Support for system accessibility settings

## Internationalization
- Support for multiple languages
- Locale-aware formatting
- RTL layout support
- Cultural adaptations

## Deployment Pipeline
1. Code review
2. Automated testing
3. Build generation
4. Beta distribution
5. Production release

This architecture is designed to be modular, maintainable, and scalable as the application grows in complexity.
