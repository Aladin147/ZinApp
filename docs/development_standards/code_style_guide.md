# ZinApp V2 Code Style Guide

## Overview

This document outlines the coding standards and best practices for the ZinApp V2 Flutter project. Adhering to these standards ensures code consistency, maintainability, and quality across the codebase.

## General Principles

### 1. Readability

- Write code that is easy to read and understand
- Prioritize clarity over cleverness
- Use meaningful names for variables, functions, and classes
- Include comments for complex logic, but let code be self-documenting when possible

### 2. Consistency

- Follow established patterns throughout the codebase
- Use consistent naming, formatting, and organization
- Adhere to Flutter and Dart conventions when applicable

### 3. Maintainability

- Write modular, reusable code
- Keep functions and classes focused on a single responsibility
- Minimize dependencies between components
- Write code that is easy to test

### 4. Performance

- Be mindful of performance implications
- Optimize critical paths
- Avoid unnecessary rebuilds in Flutter widgets
- Use appropriate data structures and algorithms

## Dart Style Guide

### Naming Conventions

- **Classes, enums, typedefs, extensions**: `UpperCamelCase`
  ```dart
  class UserProfile { }
  enum ConnectionState { }
  typedef JsonMap = Map<String, dynamic>;
  extension StringExtension on String { }
  ```

- **Libraries, packages, directories, source files**: `snake_case`
  ```dart
  import 'package:zinapp_v2/features/user/user_profile.dart';
  ```

- **Variables, constants, parameters, named parameters**: `lowerCamelCase`
  ```dart
  var itemCount = 0;
  const defaultTimeout = Duration(seconds: 30);
  void sum(int firstNumber, int secondNumber) { }
  ```

- **Private identifiers**: Prefix with underscore
  ```dart
  class _PrivateClass { }
  void _privateMethod() { }
  final _privateVariable = 0;
  ```

### Formatting

- Use 2-space indentation
- Maximum line length of 80 characters
- Use trailing commas for multi-line parameter lists
- Place the opening curly brace on the same line as the declaration
- Use spaces around operators

```dart
// Good
void exampleFunction({
  required String parameter1,
  int? parameter2,
  bool isEnabled = false,
}) {
  if (parameter2 != null && isEnabled) {
    // Do something
  }
}

// Bad
void exampleFunction(
  {required String parameter1,int? parameter2,bool isEnabled=false}){
  if(parameter2!=null&&isEnabled){
    // Do something
  }
}
```

### Comments

- Use `///` for documentation comments
- Document all public APIs
- Include examples in documentation when helpful
- Use `//` for implementation comments
- Keep comments up-to-date with code changes

```dart
/// Returns a formatted string representation of the user's full name.
///
/// Example:
/// ```dart
/// final user = User(firstName: 'John', lastName: 'Doe');
/// print(user.fullName); // Outputs: "John Doe"
/// ```
String get fullName => '$firstName $lastName';

// This is an implementation comment explaining complex logic
```

### Imports

- Organize imports in the following order:
  1. Dart SDK imports
  2. Flutter imports
  3. Third-party package imports
  4. Project imports
- Separate each import group with a blank line
- Sort imports alphabetically within each group

```dart
// Dart imports
import 'dart:async';
import 'dart:convert';

// Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Third-party imports
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports
import 'package:zinapp_v2/features/auth/auth_provider.dart';
import 'package:zinapp_v2/widgets/app_button.dart';
```

## Flutter-Specific Guidelines

### Widget Structure

- Use `const` constructors whenever possible
- Implement `==` and `hashCode` for widget classes with many properties
- Keep widget build methods focused and readable
- Extract complex widget trees into separate methods or widget classes
- Use named parameters for clarity

```dart
class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.username,
    required this.avatarUrl,
    this.isVerified = false,
    this.onTap,
  });

  final String username;
  final String avatarUrl;
  final bool isVerified;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: _buildCardContent(),
      ),
    );
  }

  Widget _buildCardContent() {
    return Row(
      children: [
        _buildAvatar(),
        const SizedBox(width: 12),
        _buildUserInfo(),
      ],
    );
  }

  Widget _buildAvatar() {
    // Avatar implementation
  }

  Widget _buildUserInfo() {
    // User info implementation
  }
}
```

### State Management

- Use Riverpod for state management
- Keep providers focused on a single responsibility
- Use appropriate provider types for different use cases
- Document providers with clear comments

```dart
/// Provides the current user profile information.
///
/// Automatically refreshes when the authentication state changes.
@riverpod
class UserProfileNotifier extends AsyncNotifier<UserProfile> {
  @override
  Future<UserProfile> build() async {
    // Listen to auth changes
    final userId = ref.watch(authStateProvider).valueOrNull?.userId;
    
    if (userId == null) {
      throw const UserNotAuthenticatedException();
    }
    
    return ref.watch(userRepositoryProvider).getUserProfile(userId);
  }
  
  Future<void> updateProfile(UserProfileUpdate update) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => 
      ref.read(userRepositoryProvider).updateProfile(update));
  }
}
```

### Error Handling

- Use `AsyncValue` for representing async operations
- Handle errors gracefully in the UI
- Provide meaningful error messages to users
- Log errors for debugging purposes

```dart
Widget build(BuildContext context) {
  final profileState = ref.watch(userProfileProvider);
  
  return profileState.when(
    data: (profile) => ProfileView(profile: profile),
    loading: () => const LoadingIndicator(),
    error: (error, stackTrace) => ErrorView(
      message: 'Could not load profile',
      details: error.toString(),
      onRetry: () => ref.refresh(userProfileProvider),
    ),
  );
}
```

### Performance Considerations

- Use `const` constructors for immutable widgets
- Implement `==` and `hashCode` for custom classes used in collections
- Avoid expensive operations in build methods
- Use `ListView.builder` for long lists
- Optimize image loading and caching
- Use `RepaintBoundary` to isolate frequently repainting widgets

```dart
// Good
@immutable
class UserData {
  const UserData({
    required this.id,
    required this.name,
    required this.email,
  });

  final String id;
  final String name;
  final String email;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserData &&
        other.id == id &&
        other.name == name &&
        other.email == email;
  }

  @override
  int get hashCode => Object.hash(id, name, email);
}
```

## Testing Standards

### Unit Tests

- Test one concept per test function
- Use descriptive test names that explain the expected behavior
- Follow the Arrange-Act-Assert pattern
- Mock external dependencies

```dart
test('getUserProfile returns UserProfile when user exists', () async {
  // Arrange
  final mockDataSource = MockUserDataSource();
  when(mockDataSource.fetchUser(any)).thenAnswer(
    (_) async => userResponseDto,
  );
  final repository = UserRepositoryImpl(dataSource: mockDataSource);
  
  // Act
  final result = await repository.getUserProfile('user-123');
  
  // Assert
  expect(result, isA<UserProfile>());
  expect(result.id, equals('user-123'));
  expect(result.displayName, equals('John Doe'));
});
```

### Widget Tests

- Test widget rendering and interactions
- Verify widget behavior in different states
- Test user interactions using `tester.tap`, `tester.enterText`, etc.
- Verify widget tree structure when relevant

```dart
testWidgets('ProfileCard displays username and verified badge when isVerified is true', 
    (WidgetTester tester) async {
  // Arrange
  await tester.pumpWidget(
    MaterialApp(
      home: ProfileCard(
        username: 'johndoe',
        avatarUrl: 'https://example.com/avatar.jpg',
        isVerified: true,
      ),
    ),
  );
  
  // Assert
  expect(find.text('johndoe'), findsOneWidget);
  expect(find.byIcon(Icons.verified), findsOneWidget);
});
```

### Integration Tests

- Focus on critical user flows
- Test feature interactions
- Verify end-to-end functionality
- Use realistic test data

## Code Review Checklist

Before submitting code for review, ensure:

1. Code follows the style guide
2. All tests pass
3. New features have appropriate test coverage
4. Documentation is updated
5. No unnecessary commented-out code
6. No debug print statements
7. Error handling is implemented
8. Performance considerations are addressed
9. Accessibility requirements are met
10. Code is free of warnings and linter issues

## Linting

ZinApp V2 uses a custom set of lint rules defined in `analysis_options.yaml`. All code must pass these lint rules before being merged.

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    - always_declare_return_types
    - avoid_print
    - avoid_unnecessary_containers
    - prefer_const_constructors
    - prefer_const_declarations
    - prefer_final_locals
    - sort_child_properties_last
    - use_key_in_widget_constructors
    # Additional custom rules
```

## Continuous Integration

All code changes must pass the CI pipeline, which includes:
- Static analysis (linting)
- Unit tests
- Widget tests
- Integration tests
- Code coverage reporting

## Version Control

- Use feature branches for development
- Write clear, descriptive commit messages
- Keep commits focused on a single change
- Squash commits before merging when appropriate
- Use pull requests for code review
