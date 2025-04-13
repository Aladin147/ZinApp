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

#### StateNotifier Providers (Generated via @riverpod)
- Manage complex application state using a `StateNotifier`.
- Use immutable state classes (typically generated with `freezed`).
- Implement state transitions as methods within the Notifier class.
- Example: `authNotifierProvider` (generated from `AuthNotifier` class)

```dart
// State Class (using freezed)
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated({required UserProfile user}) = _Authenticated;
  const factory AuthState.error({required String message}) = _Error;
}

// Notifier Class
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    // Initialize dependencies, return initial state
    return AuthState.initial();
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    try {
      // Call auth service
      // final user = await ref.read(authServiceProvider).login(email, password);
      // state = AuthState.authenticated(user: user);
    } catch (e) {
      state = AuthState.error(message: e.toString());
    }
  }
  // Other methods...
}
```

#### Computed Providers (Generated via @riverpod)
- Derive state from other providers.
- Automatically update when dependencies change.
- Example: `userIsAuthenticatedProvider`

```dart
@riverpod
bool userIsAuthenticated(UserIsAuthenticatedRef ref) {
  // Watch the generated AuthNotifier provider
  final authState = ref.watch(authNotifierProvider);
  // Use pattern matching on the freezed state
  return authState.maybeWhen(
    authenticated: (_) => true,
    orElse: () => false,
  );
}
```
*Note: Other provider types like `FutureProvider`, `StreamProvider`, `StateProvider` are also used as needed, following the `@riverpod` generation pattern.*

### 2. State Classes

All state is represented by **immutable classes**, typically generated using the **`freezed` package**. This provides:
- Immutable properties.
- `copyWith` method for state updates.
- Pattern matching capabilities (when/maybeWhen, map/maybeMap) for handling different states easily in the UI.
- Named constructors for different states (e.g., `initial`, `loading`, `data`, `error`).

Example (using `freezed`):

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart'; // Generated file

@freezed
class AuthState with _$AuthState {
  // Define different states as factory constructors
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated({required UserProfile user}) = _Authenticated;
  const factory AuthState.error({required String message}) = _Error;
}

// Run build_runner to generate auth_state.freezed.dart
```

### 3. Widget Integration

#### ConsumerWidget
Used for stateless widgets that need to access providers:

```dart
class ProfileHeader extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the generated provider
    final authState = ref.watch(authNotifierProvider);
    // Use pattern matching to display UI based on state
    return authState.maybeWhen(
      authenticated: (user) => Text('Welcome, ${user.name}'),
      orElse: () => const Text('Not logged in'),
    );
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
    // Access notifier via ref.read inside initState or other lifecycle methods
    // Example: ref.read(authNotifierProvider.notifier).someInitialization();
  }

  @override
  Widget build(BuildContext context) {
    // Watch the generated provider
    final authState = ref.watch(authNotifierProvider);
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
            // Watch the generated provider
            final isAuthenticated = ref.watch(userIsAuthenticatedProvider);
            return Text(isAuthenticated ? 'Logged In' : 'Logged Out');
          },
        ),
        // Rest of the UI...
      ],
    ),
  );
}
```

## Folder Structure

The structure follows the layered, feature-first approach outlined in `V2_FILE_STRUCTURE.md`:

```
lib/
├── features/
│   └── [feature_name]/
│       ├── data/
│       ├── domain/
│       └── presentation/
│           ├── providers/  # Riverpod providers (.dart & .g.dart files)
│           ├── screens/
│           └── widgets/
├── providers/            # Global Riverpod providers (.dart & .g.dart files)
├── services/             # Shared services
├── models/               # Shared models (if any)
├── router/               # GoRouter configuration
└── ...                   # Other core directories (config, constants, etc.)
```
*Refer to `docs/V2_FILE_STRUCTURE.md` for the complete structure.*

## Naming Conventions

- **Provider Files**: `[feature_or_service]_provider.dart` (e.g., `auth_notifier.dart`, `api_service_provider.dart`) - Note: Generator often dictates the file name based on the provider name.
- **State Classes**: `[Feature]State` (e.g., `AuthState`, `FeedState`) - Often generated by `freezed`.
- **Notifier Classes**: `[Feature]Notifier` (e.g., `AuthNotifier`, `FeedNotifier`) - Used with `@riverpod`.
- **Generated Provider Variables**: `[feature]NotifierProvider` (for StateNotifierProvider), `[name]Provider` (for others) (e.g., `authNotifierProvider`, `apiServiceProvider`, `userIsAuthenticatedProvider`). Follow Riverpod generator conventions.
- **Service Providers**: `[serviceName]Provider` (e.g., `apiServiceProvider`, `authServiceProvider`).

## State Management Patterns

### Loading State

```dart
Future<void> loadData() async {
  // Use freezed states for loading/error
  state = const State.loading();

  try {
    final data = await ref.read(someServiceProvider).fetchData();
    state = State.data(data); // Assuming a 'data' factory constructor
  } catch (e) {
    state = State.error(e.toString()); // Assuming an 'error' factory constructor
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
// In Notifier:
// No explicit clearError needed if using freezed states.
// Transitioning to a non-error state implicitly clears the error.

// In UI (using pattern matching):
state.when(
  // ... other states
  error: (message) => Text('Error: $message'),
  // ...
);
```

### Data Fetching

- **Using `FutureProvider` / `StreamProvider`**: Often preferred for simple data fetching. Riverpod handles loading/error states automatically via `AsyncValue`.

  ```dart
  @riverpod
  Future<UserProfile> userProfile(UserProfileRef ref, String userId) async {
    final repository = ref.watch(userRepositoryProvider);
    return repository.fetchUserProfile(userId);
  }

  // In UI:
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsync = ref.watch(userProfileProvider('someUserId'));
    return userProfileAsync.when(
      data: (user) => Text(user.name),
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
  ```

- **Manual Fetching in `StateNotifier`**: Use when more complex logic or state manipulation is needed around the fetch.

  ```dart
  // Inside a StateNotifier method:
  Future<void> loadData() async {
    state = const State.loading(); // Use freezed state
    try {
      final data = await ref.read(someServiceProvider).fetchData();
      state = State.data(data); // Use freezed state
    } catch (e, stack) {
      state = State.error(e.toString()); // Use freezed state
      // Log error with stack trace
    }
  }

  // Triggering fetch (e.g., in initState or button press):
  // ref.read(myNotifierProvider.notifier).loadData();
  ```

## Testing

### Provider Testing

```dart
void main() {
  test('AuthNotifier login success', () async {
    // 1. Create mock dependencies
    final mockAuthService = MockAuthService();
    when(mockAuthService.login(any, any)).thenAnswer((_) async => /* mock UserProfile */);

    // 2. Create ProviderContainer with overrides
    final container = ProviderContainer(
      overrides: [
        // Override the service provider used by AuthNotifier
        authServiceProvider.overrideWithValue(mockAuthService),
      ],
    );

    // 3. Read the notifier and call method
    final notifier = container.read(authNotifierProvider.notifier);
    await notifier.login(email: 'test@example.com', password: 'password');

    // 4. Read the state and assert
    final state = container.read(authNotifierProvider);
    expect(state, isA<Authenticated>()); // Check freezed state type
    // expect((state as Authenticated).user, isNotNull);
  });
}
```

### Widget Testing

```dart
void main() {
  testWidgets('LoginScreen shows error message on failed login', (tester) async {
    // 1. Create mock notifier or override service provider
    final mockAuthNotifier = MockAuthNotifier(); // Assuming a mock class exists
    when(() => mockAuthNotifier.state).thenReturn(const AuthState.error(message: 'Invalid'));

    // 2. Pump widget with ProviderScope overrides
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Override the specific notifier provider for this test
          authNotifierProvider.overrideWithValue(mockAuthNotifier),
        ],
        child: MaterialApp(home: LoginScreen()), // Your screen widget
      ),
    );

    // 3. Find widgets and assert
    expect(find.text('Error: Invalid'), findsOneWidget);
  });
}
```

## Best Practices

1. **Keep Providers Focused**: Each provider should manage a distinct piece of state or provide a specific service.
2. **Use Immutable State**: Leverage `freezed` for robust immutable state classes.
3. **Separate Concerns**: Follow the layered architecture (Presentation, Domain, Data). Keep business logic out of widgets.
4. **Use `ref.watch` for UI Rebuilds**: Watch providers in the `build` method to react to state changes.
5. **Use `ref.read` for Actions**: Read providers in callbacks (`onPressed`, `initState`, etc.) to trigger actions without rebuilding.
6. **Prefer `Consumer` for Granular Updates**: Wrap only the necessary parts of the widget tree with `Consumer` or `ref.watch` to optimize rebuilds.
7. **Handle Loading and Error States**: Use `AsyncValue` from `Future/StreamProvider` or explicit states (`loading`, `error` factories in `freezed`) and handle them gracefully in the UI.
8. **Use Code Generation**: Rely on `@riverpod` and `freezed` generators to reduce boilerplate and ensure type safety.
9. **Test Providers and Logic**: Write unit tests for notifiers and domain logic.
10. **Provider Placement**: Place global providers in `lib/providers/`, feature-specific ones in `lib/features/[feature]/presentation/providers/`.

## Conclusion

This architecture, centered around Riverpod and a layered feature structure, provides a solid foundation for state management in the ZinApp V2 project. By adhering to these patterns, using code generation (`@riverpod`, `freezed`), and following best practices, we ensure a maintainable, testable, and scalable codebase.
