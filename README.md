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

## Project Structure

The project follows a feature-based organization with clean architecture principles:

```
lib/
├── app/                  # Application-level configuration
│   ├── router.dart       # Navigation/routing configuration
│   └── theme/            # Theme configuration
├── features/             # Feature modules
│   ├── auth/             # Authentication feature
│   ├── profile/          # User profile feature
│   ├── stylist/          # Stylist-related features
│   └── showcase/         # Component showcase (development only)
├── services/             # Application services
├── widgets/              # Reusable UI components
├── constants/            # Application constants
└── main.dart             # Application entry point
```

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
