# Riverpod Architecture Specification

## Overview

This document outlines the architecture and patterns used for state management in the ZinApp V2 project after migrating to Riverpod. It serves as a guide for developers working on the project to ensure consistency and maintainability.

## Core Concepts

### 1. Provider Types

ZinApp V2 uses several types of providers:

#### Service Providers
- Provide access to services (API, database, etc.)
- Usually singleton providers
- Example: `authServiceProvider`

```dart
@riverpod
AuthService authService(AuthServiceRef ref) {
  return AuthService();
}
```

#### State Providers
- Manage application state
- Use immutable state classes
- Implement state transitions as methods
- Example: `authProvider`

```dart
@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() {
    return AuthState.initial();
  }
  
  // Methods to manipulate state...
}
```

#### Computed Providers
- Derive state from other providers
- Automatically update when dependencies change
- Example: `userIsAuthenticatedProvider`

```dart
@riverpod
bool userIsAuthenticated(UserIsAuthenticatedRef ref) {
  final authState = ref.watch(authProvider);
  return authState.isAuthenticated;
}
```

### 2. State Classes

All state is represented by immutable classes with:
- Immutable properties (final)
- copyWith method for state updates
- Named constructors for different states (initial, loading, error, etc.)

Example:

```dart
class AuthState {
  final UserProfile? user;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    UserProfile? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  // Named constructors
  factory AuthState.initial() => const AuthState();
  factory AuthState.loading() => const AuthState(isLoading: true);
  factory AuthState.authenticated(UserProfile user) => AuthState(user: user);
  factory AuthState.error(String message) => AuthState(error: message);
  
  // Clear error
  AuthState clearError() => copyWith(error: null);
}
```

### 3. Widget Integration

#### ConsumerWidget
Used for stateless widgets that need to access providers:

```dart
class ProfileHeader extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileProviderProvider).user;
    // ...
  }
}
```

#### ConsumerStatefulWidget
Used for stateful widgets that need to access providers:

```dart
class LoginScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(authProvider.notifier).clearError();
  }
  
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    // ...
  }
}
```

#### Consumer
Used for rebuilding only parts of a widget:

```dart
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        // Only this part rebuilds when authState changes
        Consumer(
          builder: (context, ref, child) {
            final authState = ref.watch(authProvider);
            return Text(authState.isAuthenticated ? 'Logged In' : 'Logged Out');
          },
        ),
        // Rest of the UI...
      ],
    ),
  );
}
```

## Folder Structure

```
lib/
├── features/
│   ├── auth/
│   │   ├── providers/
│   │   │   └── riverpod/
│   │   │       ├── auth_provider.dart
│   │   │       └── auth_provider.g.dart
│   │   ├── screens/
│   │   │   └── riverpod/
│   │   │       ├── auth_screen.dart
│   │   │       ├── login_screen.dart
│   │   │       └── register_screen.dart
│   │   └── widgets/
│   │       └── riverpod/
│   │           └── auth_wrapper.dart
│   ├── profile/
│   │   ├── providers/
│   │   │   └── riverpod/
│   │   │       ├── user_profile_provider.dart
│   │   │       └── user_profile_provider.g.dart
│   │   └── screens/
│   │       └── riverpod/
│   │           ├── profile_screen.dart
│   │           └── profile_edit_screen.dart
│   └── ...
├── models/
│   ├── user_profile.dart
│   ├── post.dart
│   └── ...
├── services/
│   ├── auth_service.dart
│   ├── user_service.dart
│   └── ...
└── router/
    ├── app_routes.dart
    ├── riverpod_router.dart
    └── riverpod_router.g.dart
```

## Naming Conventions

- **Provider Files**: `feature_provider.dart`
- **State Classes**: `FeatureState`
- **Provider Classes**: `Feature` (will be generated as `FeatureProvider`)
- **Provider Variables**: `featureProvider`
- **Service Providers**: `featureServiceProvider`

## State Management Patterns

### Loading State

```dart
Future<void> loadData() async {
  state = state.copyWith(isLoading: true, error: null);
  
  try {
    final data = await ref.read(serviceProvider).fetchData();
    state = state.copyWith(
      data: data,
      isLoading: false,
    );
  } catch (e) {
    state = state.copyWith(
      isLoading: false,
      error: e.toString(),
    );
  }
}
```

### Error Handling

```dart
void clearError() {
  if (state.error != null) {
    state = state.copyWith(error: null);
  }
}

// In UI:
if (state.error != null) {
  // Show error message
}
```

### Data Fetching

```dart
@override
void initState() {
  super.initState();
  Future.microtask(() {
    ref.read(dataProvider.notifier).loadData();
  });
}
```

## Testing

### Provider Testing

```dart
void main() {
  test('AuthProvider login success', () async {
    final container = ProviderContainer(
      overrides: [
        authServiceProvider.overrideWithValue(MockAuthService()),
      ],
    );
    
    final notifier = container.read(authProvider.notifier);
    await notifier.login(email: 'test@example.com', password: 'password');
    
    final state = container.read(authProvider);
    expect(state.isAuthenticated, true);
    expect(state.user, isNotNull);
  });
}
```

### Widget Testing

```dart
void main() {
  testWidgets('LoginScreen shows error message', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith((ref) => MockAuthNotifier()),
        ],
        child: MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );
    
    // Test interactions...
  });
}
```

## Best Practices

1. **Keep Providers Focused**: Each provider should have a single responsibility.
2. **Use Immutable State**: Always use immutable state classes with copyWith.
3. **Separate UI and Logic**: Keep business logic in providers, UI logic in widgets.
4. **Use ref.watch Sparingly**: Only watch what you need to minimize rebuilds.
5. **Prefer Consumer for Granular Updates**: Use Consumer to rebuild only what's needed.
6. **Document State Transitions**: Comment state transitions for clarity.
7. **Handle Loading and Error States**: Always handle loading and error states in the UI.
8. **Use Extension Methods**: Use extension methods for backward compatibility.
9. **Generate Code**: Use code generation to reduce boilerplate.
10. **Test Providers**: Write tests for all providers.

## Migration Notes

When migrating existing features:
1. Create Riverpod versions in separate files
2. Update imports to use Riverpod versions
3. Remove Provider-based files once migration is complete

## Conclusion

This architecture provides a solid foundation for state management in the ZinApp V2 project. By following these patterns and conventions, we ensure a maintainable and scalable codebase that can grow with the application's needs.
