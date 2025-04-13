# ZinApp V2 Comprehensive Architecture Guide

## Introduction

This document provides a comprehensive guide to the architecture of the ZinApp V2 application. It is intended for developers who are new to the project or need to understand the overall structure and design decisions.

## Table of Contents

1. [Architectural Overview](#architectural-overview)
2. [Directory Structure](#directory-structure)
3. [State Management](#state-management)
4. [Navigation](#navigation)
5. [Dependency Injection](#dependency-injection)
6. [Error Handling](#error-handling)
7. [Testing Strategy](#testing-strategy)
8. [API Integration](#api-integration)
9. [Gamification System](#gamification-system)
10. [UI Component System](#ui-component-system)

## Architectural Overview

ZinApp V2 follows a layered architecture combined with a feature-first project structure. The application is divided into the following layers:

### Presentation Layer

The presentation layer is responsible for rendering the UI and handling user input. It consists of:

- **Screens**: Full-page widgets that represent a complete screen in the application.
- **Widgets**: Reusable UI components that make up the screens.
- **UI Logic**: Logic that is specific to the UI, such as form validation, animation control, etc.

### State Management Layer

The state management layer is responsible for managing the application's state and business logic. It consists of:

- **Providers**: Riverpod providers that expose state and functionality to the UI.
- **Notifiers**: StateNotifier classes that manage state and provide methods to update it.
- **State Classes**: Immutable classes that represent the state of a feature or component.

### Service Layer

The service layer is responsible for handling external interactions and complex business logic. It consists of:

- **API Services**: Services that handle communication with the backend API.
- **Local Storage Services**: Services that handle local data persistence.
- **Business Logic Services**: Services that implement complex business logic, such as gamification rules.

### Data Layer

The data layer is responsible for defining the data structures used throughout the application. It consists of:

- **Models**: Classes that represent the data structures used in the application.
- **DTOs**: Data Transfer Objects that are used to convert between API responses and model objects.
- **Repositories**: Classes that abstract the data sources and provide a unified API for data access.

## Directory Structure

The ZinApp V2 project follows a feature-first directory structure, which means that code is organized primarily by feature rather than by technical concern. This makes it easier to find all the code related to a specific feature in one place.

```
lib/
├── main.dart                  # Application entry point
├── riverpod_app.dart          # Root application widget
├── config/                    # Configuration files
├── constants/                 # Application constants
├── features/                  # Feature modules
│   ├── auth/                  # Authentication feature
│   │   ├── models/            # Feature-specific models
│   │   ├── providers/         # Feature-specific providers
│   │   │   └── riverpod/      # Riverpod providers
│   │   ├── repositories/      # Feature-specific repositories
│   │   ├── screens/           # Feature-specific screens
│   │   │   └── riverpod/      # Screens using Riverpod
│   │   ├── services/          # Feature-specific services
│   │   └── widgets/           # Feature-specific widgets
│   ├── booking/               # Booking feature
│   ├── feed/                  # Social feed feature
│   ├── home/                  # Home screen feature
│   ├── profile/               # User profile feature
│   ├── rewards/               # Rewards and gamification feature
│   ├── showcase/              # Component showcase feature
│   └── stylist/               # Stylist discovery feature
├── models/                    # Shared data models
├── navigation/                # Navigation components
├── providers/                 # Shared providers
│   ├── api/                   # API providers
│   ├── gamification/          # Gamification providers
│   └── navigation/            # Navigation providers
├── router/                    # Routing configuration
├── services/                  # Shared services
├── theme/                     # Theme configuration
├── utils/                     # Utility functions
└── widgets/                   # Shared widgets
```

## State Management

ZinApp V2 uses Riverpod for state management. Riverpod provides a flexible and testable way to manage state in a Flutter application.

### Provider Types

- **Provider**: Used for simple values that don't change, such as services or configuration.
- **StateProvider**: Used for simple state that can be changed, such as a counter or a toggle.
- **StateNotifierProvider**: Used for complex state that requires custom logic to update.
- **FutureProvider**: Used for asynchronous data that is loaded once.
- **StreamProvider**: Used for asynchronous data that updates over time.

### Provider Organization

Providers are organized by feature and are located in the `providers` directory of each feature. For example, the authentication providers are located in `lib/features/auth/providers/riverpod/`.

Shared providers that are used across multiple features are located in the `lib/providers` directory.

### State Classes

State classes are immutable classes that represent the state of a feature or component. They are typically defined using the `freezed` package to generate immutable classes with copyWith methods.

Example:

```dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required AuthStatus status,
    required UserProfile? userProfile,
    String? errorMessage,
  }) = _AuthState;

  factory AuthState.initial() => const AuthState(
        status: AuthStatus.initial,
        userProfile: null,
      );
}
```

### Notifiers

Notifiers are classes that extend `StateNotifier` and provide methods to update the state. They are typically defined using the `@riverpod` annotation to generate the provider.

Example:

```dart
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    return AuthState.initial();
  }

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final userProfile = await _authService.signIn(email, password);
      state = state.copyWith(
        status: AuthStatus.authenticated,
        userProfile: userProfile,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }
}
```

## Navigation

ZinApp V2 uses GoRouter for navigation. GoRouter provides a declarative way to define routes and handle navigation in a Flutter application.

### Route Definition

Routes are defined in the `lib/router/app_routes.dart` file. Each route is defined with a path, a name, and a builder function that creates the screen widget.

Example:

```dart
final router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      name: AppRoutes.home,
      builder: (context, state) => const HomeDashboard(),
    ),
    GoRoute(
      path: '/profile',
      name: AppRoutes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);
```

### Navigation

Navigation is performed using the `context.go()` or `context.push()` methods provided by GoRouter.

Example:

```dart
// Navigate to a new screen, replacing the current one
context.go('/profile');

// Navigate to a new screen, adding it to the stack
context.push('/profile');
```

## Dependency Injection

ZinApp V2 uses Riverpod for dependency injection. Riverpod provides a way to inject dependencies into widgets and other providers.

### Service Providers

Services are provided using the `Provider` type and are typically defined in the `lib/providers` directory.

Example:

```dart
@Riverpod(keepAlive: true)
ApiService apiService(ApiServiceRef ref) {
  if (AppConfig.useMockData) {
    return MockApiService();
  } else {
    return RealApiService();
  }
}
```

### Accessing Dependencies

Dependencies are accessed using the `ref.watch()` or `ref.read()` methods provided by Riverpod.

Example:

```dart
final apiService = ref.watch(apiServiceProvider);
```

## Error Handling

ZinApp V2 uses a consistent approach to error handling throughout the application.

### Service Layer

Services throw typed exceptions when errors occur. These exceptions are caught by the state management layer and converted into error states.

Example:

```dart
Future<UserProfile> signIn(String email, String password) async {
  try {
    final response = await _httpClient.post('/auth/sign-in', body: {
      'email': email,
      'password': password,
    });
    return UserProfile.fromJson(response.data);
  } catch (e) {
    throw AuthException('Failed to sign in: ${e.toString()}');
  }
}
```

### State Management Layer

The state management layer catches exceptions thrown by the service layer and updates the state to reflect the error.

Example:

```dart
Future<void> signIn(String email, String password) async {
  state = state.copyWith(status: AuthStatus.loading);
  try {
    final userProfile = await _authService.signIn(email, password);
    state = state.copyWith(
      status: AuthStatus.authenticated,
      userProfile: userProfile,
      errorMessage: null,
    );
  } catch (e) {
    state = state.copyWith(
      status: AuthStatus.error,
      errorMessage: e.toString(),
    );
  }
}
```

### Presentation Layer

The presentation layer displays error messages to the user based on the error state.

Example:

```dart
final authState = ref.watch(authNotifierProvider);

if (authState.status == AuthStatus.error) {
  return ErrorScreen(message: authState.errorMessage);
}
```

## Testing Strategy

ZinApp V2 follows a comprehensive testing strategy that includes unit tests, widget tests, and integration tests.

### Unit Tests

Unit tests are used to test individual functions, classes, and providers in isolation. They are located in the `test/unit` directory.

Example:

```dart
void main() {
  group('AuthNotifier', () {
    test('initial state is correct', () {
      final container = ProviderContainer();
      final authState = container.read(authNotifierProvider);
      expect(authState.status, AuthStatus.initial);
      expect(authState.userProfile, null);
      expect(authState.errorMessage, null);
    });
  });
}
```

### Widget Tests

Widget tests are used to test individual widgets in isolation. They are located in the `test/widget` directory.

Example:

```dart
void main() {
  testWidgets('LoginScreen shows error message when login fails', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authNotifierProvider.overrideWith((ref) => MockAuthNotifier()),
        ],
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Failed to sign in'), findsOneWidget);
  });
}
```

### Integration Tests

Integration tests are used to test the interaction between multiple components. They are located in the `test/integration` directory.

Example:

```dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('User can sign in and view profile', (tester) async {
    await tester.pumpWidget(const RiverpodApp());

    // Navigate to login screen
    await tester.tap(find.byIcon(Icons.login));
    await tester.pumpAndSettle();

    // Enter credentials and sign in
    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Verify user is signed in and can view profile
    expect(find.text('Welcome, Test User'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();
    expect(find.text('Profile'), findsOneWidget);
  });
}
```

## API Integration

ZinApp V2 uses a service-based approach to API integration. The `ApiService` interface defines the contract for API interactions, and concrete implementations provide the actual implementation.

### ApiService Interface

The `ApiService` interface defines the methods for interacting with the API.

Example:

```dart
abstract class ApiService {
  Future<UserProfile> getUserProfile(String userId);
  Future<List<Post>> getFeed(String userId);
  Future<void> likePost(String postId, String userId);
  Future<void> commentOnPost(String postId, String userId, String comment);
}
```

### MockApiService Implementation

The `MockApiService` implementation provides mock data for development and testing.

Example:

```dart
class MockApiService implements ApiService {
  @override
  Future<UserProfile> getUserProfile(String userId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Return mock data
    return UserProfile(
      id: userId,
      name: 'Test User',
      email: 'test@example.com',
      profilePictureUrl: 'https://example.com/profile.jpg',
    );
  }
  
  // Other methods...
}
```

### RealApiService Implementation

The `RealApiService` implementation communicates with the actual backend API.

Example:

```dart
class RealApiService implements ApiService {
  final HttpClient _httpClient;
  
  RealApiService(this._httpClient);
  
  @override
  Future<UserProfile> getUserProfile(String userId) async {
    final response = await _httpClient.get('/users/$userId');
    return UserProfile.fromJson(response.data);
  }
  
  // Other methods...
}
```

## Gamification System

ZinApp V2 includes a comprehensive gamification system that rewards users for various actions within the application.

### GamificationService

The `GamificationService` is responsible for calculating rewards, tracking progress, and managing the gamification state.

Example:

```dart
class GamificationService {
  final UserProfileService _userProfileService;
  
  GamificationService({required UserProfileService userProfileService})
      : _userProfileService = userProfileService;
  
  Future<Map<String, dynamic>> awardForAction(
    String userId,
    String actionType, {
    String? description,
    String? relatedEntityId,
  }) async {
    // Calculate XP and tokens based on action type
    final xpGained = _calculateXpForAction(actionType);
    final tokensGained = _calculateTokensForAction(actionType);
    
    // Update user profile
    final userProfile = await _userProfileService.getUserProfile(userId);
    final updatedXp = userProfile.xp + xpGained;
    final updatedTokens = userProfile.tokens + tokensGained;
    
    // Check if user leveled up
    final currentLevel = _calculateLevelForXp(userProfile.xp);
    final newLevel = _calculateLevelForXp(updatedXp);
    final leveledUp = newLevel > currentLevel;
    
    // Update user profile
    await _userProfileService.updateUserProfile(
      userId,
      xp: updatedXp,
      tokens: updatedTokens,
      level: newLevel,
    );
    
    // Return result
    return {
      'xpGained': xpGained,
      'tokensGained': tokensGained,
      'leveledUp': leveledUp,
      'newLevel': newLevel,
    };
  }
  
  // Other methods...
}
```

### Gamification UI

The gamification UI displays the user's progress, rewards, and achievements.

Example:

```dart
class RewardsDashboard extends ConsumerWidget {
  const RewardsDashboard({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider);
    final gamificationState = ref.watch(gamificationNotifierProvider);
    
    return Column(
      children: [
        // User level and XP
        LevelProgressWidget(
          level: userProfile.level,
          xp: userProfile.xp,
          nextLevelXp: gamificationState.getXPForNextLevel(userProfile.xp),
        ),
        
        // Token balance
        TokenBalanceWidget(
          tokens: userProfile.tokens,
        ),
        
        // Daily rewards
        DailyRewardsCard(),
        
        // Challenges
        ChallengesCard(),
        
        // Achievements
        AchievementsCard(),
      ],
    );
  }
}
```

## UI Component System

ZinApp V2 uses a component-based approach to UI development. Reusable UI components are defined in the `lib/widgets` directory and feature-specific components are defined in the `lib/features/*/widgets` directories.

### Design System

The design system defines the visual language of the application, including colors, typography, spacing, and component styles.

Example:

```dart
class AppColors {
  static const primaryHighlight = Color(0xFF00FFFF);
  static const baseDark = Color(0xFF172335);
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFCCCCCC);
}

class AppTypography {
  static const headingLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );
}
```

### Reusable Components

Reusable components are defined in the `lib/widgets` directory and can be used throughout the application.

Example:

```dart
class ZinButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ZinButtonVariant variant;
  final ZinButtonSize size;
  final IconData? icon;
  final bool isLoading;
  
  const ZinButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.variant = ZinButtonVariant.primary,
    this.size = ZinButtonSize.medium,
    this.icon,
    this.isLoading = false,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // Button implementation...
  }
}
```

### Feature-Specific Components

Feature-specific components are defined in the `lib/features/*/widgets` directories and are used only within that feature.

Example:

```dart
class StylistCard extends StatelessWidget {
  final Stylist stylist;
  final VoidCallback? onTap;
  final bool isCompact;
  
  const StylistCard({
    Key? key,
    required this.stylist,
    this.onTap,
    this.isCompact = false,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // Stylist card implementation...
  }
}
```

## Conclusion

This comprehensive architecture guide provides an overview of the ZinApp V2 application architecture. It covers the key architectural decisions, patterns, and practices used in the application. Developers should refer to this guide when working on the application to ensure consistency and maintainability.
