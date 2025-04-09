# ZinApp Known Issues

This document tracks known issues in the ZinApp codebase that are pending resolution.

## API Connectivity

- **Issue**: API calls fail with TypeError when mock server is unreachable
- **Workaround**: App now runs in DEMO MODE with hardcoded data to bypass API connectivity issues
- **Root Cause**: Multiple factors including port conflicts when running multiple servers in office environment
- **Status**: Temporarily resolved with DEMO MODE, needs proper investigation

## UI Implementation

- **Issue**: UI implementation is not fully aligned with design specifications
- **Details**: Missing components, inconsistent styling, and incomplete animation system
- **Workaround**: Basic UI components have been implemented to improve user experience
- **Status**: In progress, see UI_IMPLEMENTATION_PLAN.md for details

## Package Dependencies

- **Issue**: Several npm packages are outdated or have vulnerabilities
- **Details**: Expo SDK 52 compatibility issues with current package versions
- **Status**: To be addressed in a future update

## Type Definitions

- **Issue**: Some TypeScript errors related to missing type definitions
- **Details**: Path aliases (@types, @constants) sometimes show errors in IDE
- **Status**: App compiles and runs correctly despite these errors

## Documentation

- **Issue**: Some documentation files have markdown linting issues
- **Details**: Indentation and spacing issues in markdown files
- **Status**: Low priority, does not affect functionality