# Changelog

All notable changes to the ZinApp project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Logo component with support for normal, inverted, and standalone variants
- LogoShowcaseScreen to demonstrate all logo variants
- Avatar component with support for different sizes and verification badge
- AvatarShowcaseScreen to demonstrate avatar variants
- QRScannerShowcaseScreen placeholder for future QR code scanning functionality
- RatingStars component with support for different sizes and animations
- MapTracker component with route visualization and ETA display
- BookingCard component with support for different booking statuses
- SVG support using react-native-svg-transformer
- Enhanced Button component with icon support and multiple variants
- Enhanced Card component with animation support and multiple variants
- Comprehensive design system documentation in DESIGN_TOKENS.md
- Spacing utility functions for consistent application of spacing
- Spacing documentation in SPACING.md
- Enhanced typography system with comprehensive variants and documentation
- TypographyShowcaseScreen to demonstrate all typography variants
- Refined color system with semantic naming and consistent palette
- Enhanced spacing system with component-specific values

### Changed

- Updated LiveTrackScreen to use the MapTracker component
- Updated LandingScreen to use the Logo component
- Updated LandingScreen with navigation to LogoShowcaseScreen and AvatarShowcaseScreen
- Updated navigation to include the LogoShowcaseScreen, AvatarShowcaseScreen, and TypographyShowcaseScreen
- Improved documentation to reflect recent changes
- Updated DESIGN_TOKENS.md with detailed typography and spacing documentation
- Updated App.tsx to use the Typography component consistently

### Fixed

- Formatting issues in documentation files

## [0.1.0] - 2023-07-01

### Added

- Initial project setup with Expo
- Basic navigation structure
- Core UI components (Button, Card, Typography, Screen, Header)
- Specific components (BarberCard, ServiceIconBtn)
- Mock API setup
- Basic screens (LandingScreen, ServiceSelectScreen, StylistListScreen)
- Documentation (README, DESIGN_TOKENS, COMPONENT_MAP, etc.)
