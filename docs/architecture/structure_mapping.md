# ZinApp V2 Structure Mapping

This document maps the ZinApp V2 Flutter project structure to the conceptual structure outlined in the project requirements. It serves as a reference for understanding how the Flutter-specific organization fulfills the intent of the original structure.

## Conceptual Structure vs. Flutter Structure

| Conceptual Structure | Flutter Structure | Purpose |
|----------------------|-------------------|---------|
| `/components/ui/` | `/lib/widgets/` | UI components like buttons, cards, typography |
| `/components/layout/` | `/lib/widgets/` (layout-specific) | Layout wrappers, screen containers |
| `/constants/design-tokens.ts` | `/lib/app/theme/` | Design tokens, color schemes, typography |
| `/lib/game_logic/` | `/lib/features/game/` | Game mechanics and logic |
| `/assets/` | `/assets/` | Static assets like images, fonts, etc. |

## Detailed Mapping

### UI Components

**Conceptual**: `/components/ui/`  
**Flutter**: `/lib/widgets/`

The `widgets` directory contains all reusable UI components:
- `app_button.dart`: Button components (primary, secondary, text variants)
- `app_card.dart`: Card components for content containers
- `app_textfield.dart`: Text input components
- `app_typography.dart`: Typography components for consistent text styling
- `avatar.dart`: User avatar components
- Additional components will be added as needed

### Layout Components

**Conceptual**: `/components/layout/`  
**Flutter**: `/lib/widgets/` (layout-specific)

Layout-specific components are also in the `widgets` directory:
- `screen_wrapper.dart`: Base layout wrapper for screens with consistent padding/structure

### Design Tokens

**Conceptual**: `/constants/design-tokens.ts`  
**Flutter**: `/lib/app/theme/`

Design tokens are implemented in the theme directory:
- `color_scheme.dart`: Color tokens and Flutter ColorScheme
- `text_theme.dart`: Typography tokens and Flutter TextTheme
- `zinapp_theme.dart`: Combined theme with component-specific styling

### Game Logic

**Conceptual**: `/lib/game_logic/`  
**Flutter**: `/lib/features/game/`

Game mechanics will be implemented in feature-specific directories:
- `/lib/features/game/`: Will contain game-related logic
- `/lib/features/game/models/`: Game data models
- `/lib/features/game/providers/`: Game state management
- `/lib/features/game/screens/`: Game UI screens

### Assets

**Conceptual**: `/assets/`  
**Flutter**: `/assets/`

Assets are organized in a structured manner:
- `/assets/fonts/`: Typography assets
- `/assets/icons/`: UI icons and symbols
- `/assets/logos/`: Logo variations
- `/assets/badges/`: Achievement and gamification badges
- `/assets/illustrations/`: Larger illustrations and graphics
- `/assets/mock_data/`: JSON files for development and testing

## Additional Flutter-Specific Directories

### App Configuration

**Flutter**: `/lib/app/`

Contains application-level configuration:
- `router.dart`: Navigation/routing configuration
- `theme/`: Theme configuration (as detailed above)

### Features

**Flutter**: `/lib/features/`

Feature-based organization for business logic and screens:
- Each feature gets its own directory (e.g., `/lib/features/auth/`, `/lib/features/profile/`)
- Features contain their own models, providers, screens, and widgets

### Services

**Flutter**: `/lib/services/`

Application services for data access and business logic:
- `api_service.dart`: API communication
- `api_provider.dart`: Provider for API service
- `mock_api_service.dart`: Mock implementation for development

### Config

**Flutter**: `/lib/config/`

Application configuration:
- `env.dart`: Environment configuration

### Constants

**Flutter**: `/lib/constants/`

Application-wide constants:
- `app_animations.dart`: Animation constants

## Rationale for Structure

The Flutter project structure follows industry best practices while fulfilling the intent of the conceptual structure:

1. **Separation of Concerns**: UI components, business logic, and data access are clearly separated
2. **Feature-Based Organization**: Related code is grouped by feature for better maintainability
3. **Reusable Components**: UI components are centralized for consistency
4. **Clear Dependencies**: The structure makes dependencies between modules clear
5. **Scalability**: The structure can accommodate growth as new features are added

## Future Considerations

As the project grows, we may consider:

1. **Component Library Package**: Moving reusable UI components to a separate package
2. **Feature Modules**: Further modularizing features for better code organization
3. **Code Generation**: Implementing more code generation for repetitive patterns
