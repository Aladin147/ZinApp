# ZinApp V2

ZinApp V2 is a Flutter application for connecting users with stylists and sharing hairstyle inspiration.

## Project Overview

ZinApp V2 is a complete redesign of the original ZinApp, built with Flutter to provide a modern, responsive, and engaging user experience. The app focuses on:

- Connecting users with local stylists
- Sharing and discovering hairstyle inspiration
- Gamification elements to increase engagement
- Professional design and implementation

## Getting Started

### Prerequisites

- Flutter 3.29.2 or higher
- Dart SDK 3.7.2 or higher
- Android Studio / VS Code with Flutter extensions
- For Windows: Developer Mode with symlink support enabled

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/zinapp_v2.git
   ```

2. Navigate to the project directory:
   ```
   cd zinapp_v2
   ```

3. Install dependencies:
   ```
   flutter pub get
   ```

4. Run the app:
   ```
   flutter run
   ```

## Architecture

ZinApp V2 uses Riverpod for state management, following a feature-based organization with clean architecture principles.

### State Management

The application uses Riverpod for state management with the following patterns:

- **Immutable State Classes**: All state is represented by immutable classes with copyWith methods
- **Provider Organization**: Providers are organized by feature and type
- **Code Generation**: Uses riverpod_annotation for code generation
- **Separation of Concerns**: Services are separated from state management

For more details, see `docs/specs/riverpod-architecture.md`.

### Project Structure

The project structure is documented in `docs/V2_FILE_STRUCTURE.md`:

```
lib/
├── features/                # Feature modules
│   ├── auth/                # Authentication feature
│   │   ├── providers/       # Auth-specific providers
│   │   │   └── riverpod/    # Riverpod implementations
│   │   ├── screens/         # Auth screens (login, register)
│   │   │   └── riverpod/    # Riverpod-based screens
│   │   └── widgets/         # Auth-specific widgets
│   │       └── riverpod/    # Riverpod-based widgets
│   ├── feed/                # Social feed feature
│   ├── home/                # Home screen and dashboard
│   ├── profile/             # User profile feature
│   ├── stylist/             # Stylist-related features
│   └── showcase/            # Component showcase (development only)
├── models/                  # Data models
├── services/                # Application services
├── theme/                   # Theme configuration
├── widgets/                 # Reusable UI components
├── constants/               # Application constants
├── router/                  # Navigation/routing configuration
│   ├── app_routes.dart      # Route definitions
│   └── riverpod_router.dart # Riverpod-based router
└── main.dart                # Application entry point
```

## Dependencies

ZinApp V2 uses the following key dependencies:

- **flutter_riverpod**: State management with Riverpod
- **riverpod_annotation**: Code generation for Riverpod
- **go_router**: Navigation and routing
- **flutter_secure_storage**: Secure storage for sensitive data
- **shared_preferences**: Local storage for app preferences
- **sqflite**: Local database for offline data

See `pubspec.yaml` for the complete list of dependencies.

### Recent Updates

- Migrated from Provider to Riverpod for state management
- Implemented immutable state classes for all providers
- Created Riverpod-based versions of all screens and widgets
- Removed Provider package and all legacy Provider code
- Updated router to use Riverpod for navigation state
- Fixed deprecation warnings and code quality issues

See `docs/RIVERPOD_MIGRATION_COMPLETE.md` for detailed information on the migration process.

## Design System

ZinApp V2 implements a comprehensive design system with:

- Consistent color palette based on the brand identity
- Typography system using Urbanist font family
- Component library with standardized UI elements
- Spacing and layout guidelines

### Key Components

- **ZinButton**: Standardized button component with multiple variants
- **ZinLogo**: Logo component with various display options
- **ZinCard**: Card component for content containers
- **ZinAvatar**: User avatar component

## Documentation

Comprehensive documentation is available in the `docs/` directory:

- **Design System**: Color system, typography, component principles
- **Architecture**: Structure mapping, clean architecture
- **State Management**: Riverpod architecture and patterns
- **Migration**: Provider to Riverpod migration process and decisions
- **ADRs**: Architectural Decision Records, including Riverpod migration
- **Journal**: Development journal entries documenting progress
- **Development Standards**: Code style guide, PR template
- **Components**: Detailed documentation for each component

## Development Workflow

1. **Feature Development**:
   - Create a new branch for each feature
   - Follow the code style guide
   - Write tests for new functionality
   - Document new components and features

2. **Pull Requests**:
   - Use the PR template
   - Ensure all tests pass
   - Address code review feedback

3. **Testing**:
   - Write unit tests for business logic
   - Write widget tests for UI components
   - Perform manual testing on multiple devices

## License

[Include license information here]

## Acknowledgements

- Flutter team for the amazing framework
- Contributors and designers who helped shape ZinApp V2
