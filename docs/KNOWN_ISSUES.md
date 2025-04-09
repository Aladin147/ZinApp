# ZinApp Known Issues

This document tracks known issues in the ZinApp codebase that are pending resolution.

## API Connectivity

- **Issue**: API calls fail with TypeError when mock server is unreachable
- **Workaround**: App now runs in DEMO MODE with hardcoded data to bypass API connectivity issues
- **Root Cause**: Multiple factors including port conflicts when running multiple servers in office environment
- **Status**: Bypassed with DEMO MODE, needs proper investigation when API is re-enabled.

## UI Implementation

- **Issue**: UI implementation is not fully aligned with design specifications
- **Details**: Some components still missing, animation system incomplete
- **Workaround**: Most core UI components have been implemented (Button, Card, Typography, Logo, RatingStars, MapTracker, BookingCard)
- **Status**: Significant progress made offline, requires consistency audit & polish.
- **Animation System (Moti)**: Temporarily disabled. Caused "Invalid hook call" / "useContext of null" errors, likely due to incompatibility with Moti v0.30.0 / Expo 52 / Reanimated 3.16.1 stack. Needs investigation or alternative solution (e.g., direct Reanimated usage). Animations currently non-functional.

## Package Dependencies

- **Issue**: Several npm packages are outdated or have vulnerabilities
- **Details**: Expo SDK 52 compatibility issues with current package versions
- **Status**: To be addressed in a future update

## Type Definitions

- **Issue**: Some TypeScript errors related to missing type definitions
- **Details**: Path aliases (@types, @constants, etc.) show errors in IDE despite `tsconfigPaths` and `esModuleInterop` being enabled.
- **Status**: App compiles and runs correctly, but this hinders developer experience and type safety checks in the IDE. Needs investigation (TS server, `babel-plugin-module-resolver` interaction).
- **Update**: Added type definitions for SVG files and react-native-vector-icons

## Documentation

- **Issue**: Some documentation files have markdown linting issues
- **Details**: Indentation and spacing issues in markdown files
- **Status**: Low priority, does not affect functionality
- **Update**: Added CHANGELOG.md and updated component documentation

## SVG Support

- **Issue**: SVG files may not render correctly on all devices
- **Details**: Some Android devices may have issues with complex SVG files
- **Workaround**: The Logo component has been implemented with proper sizing and aspect ratio handling
- **Status**: Working for most devices, may need PNG fallbacks for problematic devices

## Map Integration

- **Issue**: MapTracker component requires Google Maps API key for production use
- **Details**: Currently using the development mode of react-native-maps
- **Workaround**: Works fine in development, but will need proper API keys for production
- **Status**: To be addressed before production deployment
- **[RESOLVED] Hook/Context Errors (2025-04-09):** Resolved "Invalid hook call" and "Cannot read property 'useContext' of null" errors by temporarily disabling Moti animations.
