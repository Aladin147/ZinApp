# ZinApp V2 Clean Architecture

## Overview

ZinApp V2 follows clean architecture principles to ensure separation of concerns, testability, and maintainability. This document outlines the architectural approach and how it's implemented in the Flutter project.

## Architecture Layers

### 1. Presentation Layer

**Purpose**: User interface and state management  
**Location**: `/lib/features/*/screens/`, `/lib/widgets/`

Components:
- **Screens**: Full-page UI components
- **Widgets**: Reusable UI components
- **Providers**: State management using Riverpod

Responsibilities:
- Displaying data to the user
- Handling user input
- Managing UI state
- Delegating business logic to the domain layer

### 2. Domain Layer

**Purpose**: Business logic and rules  
**Location**: `/lib/features/*/domain/`

Components:
- **Use Cases**: Business logic operations
- **Entities**: Core business models
- **Repository Interfaces**: Abstractions for data access

Responsibilities:
- Implementing business rules
- Defining core data structures
- Specifying how data should be accessed
- Being independent of UI and external frameworks

### 3. Data Layer

**Purpose**: Data access and external interactions  
**Location**: `/lib/features/*/data/`, `/lib/services/`

Components:
- **Repositories**: Implementations of domain repository interfaces
- **Data Sources**: API clients, local storage, etc.
- **DTOs**: Data Transfer Objects for mapping between API and domain models

Responsibilities:
- Fetching data from external sources (API, database)
- Caching data when appropriate
- Converting between external data formats and domain entities
- Handling data persistence

## Data Flow

1. **UI Event**: User interacts with the UI
2. **Provider**: Captures the event and calls appropriate use case
3. **Use Case**: Executes business logic, calling repository as needed
4. **Repository**: Retrieves/stores data using data sources
5. **Data Source**: Communicates with external systems (API, database)
6. **Response**: Data flows back up the chain, transformed at each step
7. **UI Update**: Provider updates state, causing UI to rebuild

## Dependency Rule

Dependencies always point inward:
- Presentation depends on Domain
- Data depends on Domain
- Domain depends on nothing

This ensures that the core business logic (Domain) remains isolated and testable.

## State Management with Riverpod

ZinApp V2 uses Riverpod for state management:

1. **Providers**: Defined in feature-specific provider files
2. **StateNotifier**: Used for complex state with multiple properties
3. **AsyncNotifier**: Used for asynchronous operations (API calls, etc.)
4. **Code Generation**: Uses riverpod_generator for cleaner provider definitions

Example provider structure:
```dart
@riverpod
class UserProfileNotifier extends AsyncNotifier<UserProfile> {
  @override
  Future<UserProfile> build() async {
    return ref.watch(userRepositoryProvider).getCurrentUser();
  }
  
  Future<void> updateProfile(UserProfileUpdate update) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => 
      ref.read(userRepositoryProvider).updateProfile(update));
  }
}
```

## Navigation

ZinApp V2 uses go_router for declarative routing:

1. **Router Configuration**: Defined in `/lib/app/router.dart`
2. **Route Guards**: Authentication checks implemented as redirect functions
3. **Deep Linking**: Support for deep linking with path parameters
4. **Nested Navigation**: Support for nested navigation when needed

## Error Handling

Comprehensive error handling strategy:
1. **Domain Errors**: Business logic errors defined in the domain layer
2. **Data Errors**: Network/storage errors handled in the data layer
3. **UI Error Handling**: Graceful error presentation in the UI
4. **Global Error Handling**: Centralized error logging and reporting

## Testing Strategy

Each layer has its own testing approach:
1. **Domain Tests**: Unit tests for business logic
2. **Repository Tests**: Unit tests with mocked data sources
3. **UI Tests**: Widget tests for component behavior
4. **Integration Tests**: End-to-end tests for critical flows

## Dependency Injection

Dependency injection is handled through Riverpod:
1. **Service Providers**: Singleton services provided at the app level
2. **Repository Providers**: Repositories with their dependencies
3. **Use Case Providers**: Business logic with repository dependencies
4. **Override for Testing**: Providers can be overridden in tests

## Folder Structure Example

```
lib/
├── app/
│   ├── router.dart
│   └── theme/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── repositories/
│   │   │   └── sources/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   ├── presentation/
│   │   │   ├── providers/
│   │   │   ├── screens/
│   │   │   └── widgets/
│   │   └── auth_module.dart
│   └── profile/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── services/
│   ├── api_service.dart
│   └── storage_service.dart
└── widgets/
    ├── app_button.dart
    └── app_card.dart
```

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────┐
│                                                         │
│                   Presentation Layer                     │
│                                                         │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐  │
│  │   Screens   │    │   Widgets   │    │  Providers  │  │
│  └─────────────┘    └─────────────┘    └─────────────┘  │
│           │                │                  │         │
└───────────┼────────────────┼──────────────────┼─────────┘
            │                │                  │
            ▼                ▼                  ▼
┌─────────────────────────────────────────────────────────┐
│                                                         │
│                     Domain Layer                        │
│                                                         │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐  │
│  │  Use Cases  │    │  Entities   │    │ Repository  │  │
│  │             │    │             │    │ Interfaces  │  │
│  └─────────────┘    └─────────────┘    └─────────────┘  │
│           │                │                  │         │
└───────────┼────────────────┼──────────────────┼─────────┘
            │                │                  │
            ▼                ▼                  ▼
┌─────────────────────────────────────────────────────────┐
│                                                         │
│                      Data Layer                         │
│                                                         │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐  │
│  │ Repository  │    │    DTOs     │    │    Data     │  │
│  │ Impl        │    │             │    │   Sources   │  │
│  └─────────────┘    └─────────────┘    └─────────────┘  │
│           │                │                  │         │
└───────────┼────────────────┼──────────────────┼─────────┘
            │                │                  │
            ▼                ▼                  ▼
┌─────────────────────────────────────────────────────────┐
│                                                         │
│                   External Systems                      │
│                                                         │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐  │
│  │     API     │    │   Database  │    │    Other    │  │
│  │             │    │             │    │   Services  │  │
│  └─────────────┘    └─────────────┘    └─────────────┘  │
│                                                         │
└─────────────────────────────────────────────────────────┘
```
