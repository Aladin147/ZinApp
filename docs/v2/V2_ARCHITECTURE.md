# ZinApp V2 Architecture

This document outlines the architecture for ZinApp V2, based on the V2 memo and requirements.

## Overview

ZinApp V2 architecture is designed to support a more modular, maintainable, and visually engaging application. The architecture focuses on:

- Clear separation of concerns
- Modular component structure
- Consistent styling through design tokens
- Support for gamification features
- Improved performance and responsiveness
- Enhanced visual feedback and animations

## Key Differences from V1

ZinApp V2 introduces several architectural improvements over V1:

1. **Design Token System**: V2 implements a comprehensive design token system for consistent styling, replacing the direct use of color values and styles in V1.

2. **Component Architecture**: V2 uses a more modular component architecture with clear separation between UI, layout, and feature components.

3. **File Structure**: V2 follows a stricter file organization with dedicated directories for UI components, layout components, and feature-specific code.

4. **Gamification Layer**: V2 adds a gamification layer with XP, levels, and tokens, requiring new architectural components.

5. **Animation System**: V2 incorporates a more robust animation system for enhanced visual feedback.

6. **Theme Extension**: V2 uses Flutter Theme extension for design tokens, improving maintainability and consistency.

## Component Architecture

ZinApp V2 follows a hierarchical component architecture:

### Component Hierarchy

1. **Foundation Components**: Basic UI elements like buttons, cards, typography, and inputs.
   - Located in `/components/ui/`
   - Highly reusable and configurable
   - Styled using design tokens

2. **Layout Components**: Components that handle layout and structure.
   - Located in `/components/layout/`
   - Include screen wrappers, card wrappers, and grid systems
   - Handle responsive behavior and spacing

3. **Feature Components**: More complex, feature-specific components.
   - Built using foundation and layout components
   - Implement specific business logic
   - Examples: StylistCard, ServiceCard, BookingStep

4. **Screen Components**: Full screens composed of multiple components.
   - Located in `/screens/`
   - Orchestrate component interactions
   - Handle navigation and data flow

### Component Communication

Components communicate through:

1. **Props**: Direct parent-to-child communication
2. **Context**: Shared state for related components
3. **Events**: For component-to-screen communication
4. **Global State**: For app-wide state management

## State Management

ZinApp V2 uses a multi-layered state management approach:

### Global State

- **App State**: Core application state (user, authentication, preferences)
- **Gamification State**: XP, levels, tokens, and achievements
- **Navigation State**: Current screen, navigation history

### Local State

- **Component State**: UI state specific to a component
- **Screen State**: State specific to a screen
- **Form State**: State for form inputs and validation

### State Persistence

- **Local Storage**: For user preferences and session data
- **Secure Storage**: For sensitive information
- **Mock API**: For simulating backend persistence during development

### State Synchronization

- **Real-time Updates**: For live tracking and notifications
- **Optimistic Updates**: For improved perceived performance
- **Error Handling**: For graceful recovery from failed operations

## Data Flow

ZinApp V2 implements a unidirectional data flow:

### API Integration

- **Mock API**: Simulated backend during development
- **API Client**: Centralized API request handling
- **Data Models**: Strongly typed data models for API responses
- **Transformers**: Data transformation and normalization

### Caching Strategy

- **In-memory Cache**: For frequently accessed data
- **Persistent Cache**: For offline support
- **Cache Invalidation**: Rules for refreshing cached data

### Offline Support

- **Offline Detection**: Monitoring network connectivity
- **Offline Actions**: Queue actions for later synchronization
- **Conflict Resolution**: Handling conflicts during synchronization

## Navigation

ZinApp V2 uses a stack-based navigation system with enhanced transitions:

### Screen Hierarchy

- **Landing**: Entry point to the app
- **Service Selection**: Browsing and selecting services
- **Stylist List**: Browsing and selecting stylists
- **Stylist Profile**: Viewing stylist details
- **Booking**: Multi-step booking process
- **Live Tracking**: Tracking stylist arrival
- **Completion**: Post-service feedback and rewards

### Navigation Patterns

- **Stack Navigation**: For linear flows
- **Tab Navigation**: For parallel sections
- **Modal Navigation**: For overlays and dialogs

### Transition Animations

- **Custom Transitions**: Screen-specific transitions
- **Shared Element Transitions**: For visual continuity
- **Gesture-based Navigation**: Swipe gestures for navigation

## Performance Optimizations

ZinApp V2 implements several performance optimization strategies:

### Rendering Optimization

- **Memoization**: Preventing unnecessary re-renders
- **Virtualized Lists**: For efficient list rendering
- **Lazy Loading**: Loading components only when needed
- **Code Splitting**: Breaking code into smaller chunks

### Memory Management

- **Resource Cleanup**: Proper cleanup of resources
- **Image Optimization**: Optimized image loading and caching
- **Garbage Collection**: Minimizing memory leaks

### Network Optimization

- **Request Batching**: Combining multiple requests
- **Data Compression**: Minimizing data transfer
- **Caching**: Reducing unnecessary network requests

### Asset Loading

- **Asset Preloading**: Loading critical assets early
- **Progressive Loading**: Loading assets in order of importance
- **Caching**: Storing assets for faster access

## Gamification Architecture

ZinApp V2 includes a dedicated gamification architecture:

### XP and Level System

- **XP Tracker**: Tracks user actions and awards XP
- **Level Calculator**: Determines user level based on XP
- **Reward Distributor**: Awards rewards for level-ups

### Token Economy

- **Token Wallet**: Manages user's token balance
- **Transaction Processor**: Handles token transactions
- **Reward Shop**: Interface for spending tokens

### Achievement System

- **Achievement Tracker**: Tracks progress toward achievements
- **Badge Manager**: Awards and displays badges
- **Notification System**: Alerts users of achievements

## Error Handling

ZinApp V2 implements a robust error handling system:

### Error Types

- **Network Errors**: Handling connectivity issues
- **API Errors**: Handling server-side errors
- **Validation Errors**: Handling input validation errors
- **Application Errors**: Handling unexpected application errors

### Error Presentation

- **Toast Notifications**: For non-critical errors
- **Error Dialogs**: For critical errors requiring action
- **Inline Errors**: For form validation errors
- **Error Pages**: For catastrophic errors

### Error Recovery

- **Retry Mechanisms**: Automatic and manual retry options
- **Fallback Content**: Displaying alternative content when primary content fails
- **Graceful Degradation**: Maintaining core functionality during errors
