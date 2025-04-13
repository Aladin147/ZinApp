# Developer Guide: Adding a New Feature

This guide provides step-by-step instructions for adding a new feature to the ZinApp V2 application. It covers the entire process from planning to implementation and testing.

## Table of Contents

1. [Planning](#planning)
2. [Directory Structure](#directory-structure)
3. [Models](#models)
4. [Services](#services)
5. [State Management](#state-management)
6. [UI Components](#ui-components)
7. [Navigation](#navigation)
8. [Testing](#testing)
9. [Documentation](#documentation)
10. [Example: Adding a Notification Feature](#example-adding-a-notification-feature)

## Planning

Before implementing a new feature, it's important to plan it thoroughly. This includes:

1. **Define the feature requirements**: What problem does this feature solve? What are the user stories?
2. **Design the user interface**: Create wireframes or mockups of the UI.
3. **Plan the data model**: What data structures will be needed?
4. **Plan the API integration**: What API endpoints will be needed?
5. **Plan the state management**: How will the feature's state be managed?
6. **Plan the navigation**: How will users navigate to and from this feature?

## Directory Structure

ZinApp V2 follows a feature-first directory structure with internal layering based on Clean Architecture principles. When adding a new feature, create a new directory in `lib/features/` with the following internal structure:

```
lib/features/[feature_name]/
├── data/         # Data layer implementation
│   ├── datasources/ # API client calls, local storage access (e.g., notification_remote_datasource.dart)
│   ├── models/      # Data Transfer Objects (DTOs), request/response models (e.g., notification_dto.dart)
│   └── repositories/ # Implementation of domain repositories (e.g., notification_repository_impl.dart)
├── domain/       # Business logic and rules (independent of UI and data sources)
│   ├── entities/    # Core business objects/models (e.g., notification.dart)
│   ├── repositories/ # Abstract repository interfaces (e.g., notification_repository.dart)
│   └── usecases/    # Feature-specific operations/interactions (e.g., get_notifications.dart, mark_notification_read.dart)
├── presentation/ # UI and State Management (Riverpod)
│   ├── providers/  # Riverpod providers (.dart & .g.dart files) (e.g., notification_provider.dart)
│   ├── screens/    # Widgets representing full screens/pages (e.g., notifications_screen.dart)
│   └── widgets/    # Reusable widgets specific to this feature (e.g., notification_card.dart)
└── feature_name_exports.dart # Optional: Exports public API of the feature
```
*Refer to `docs/V2_FILE_STRUCTURE.md` for the complete project structure.*

## Domain Layer (Entities, Repositories, Use Cases)

Start by defining the core business logic and data structures, independent of implementation details.

1.  **Entities**: Define the core data structures for the feature in `lib/features/[feature_name]/domain/entities/`. Use `freezed` for immutable objects. These represent the pure business model.
2.  **Repository Interface**: Define an abstract interface for data operations required by the feature in `lib/features/[feature_name]/domain/repositories/`. This defines *what* data operations are needed, not *how* they are done.
3.  **Use Cases**: Create classes in `lib/features/[feature_name]/domain/usecases/` that encapsulate specific business operations or interactions. Use cases typically depend on one or more repository interfaces.

Example (Domain Layer):

```dart
// lib/features/notification/domain/entities/notification.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';

@freezed
class Notification with _$Notification {
  const factory Notification({
    required String id,
    required String title,
    required String message,
    required DateTime timestamp,
    required bool isRead,
    String? imageUrl,
    String? actionUrl,
  }) = _Notification;
}

// lib/features/notification/domain/repositories/notification_repository.dart
import 'package:zinapp_v2/features/notification/domain/entities/notification.dart';

abstract class NotificationRepository {
  Future<List<Notification>> getNotifications(String userId);
  Future<void> markNotificationAsRead(String notificationId);
  Future<void> deleteNotification(String notificationId);
}

// lib/features/notification/domain/usecases/get_notifications.dart
import 'package:zinapp_v2/features/notification/domain/entities/notification.dart';
import 'package:zinapp_v2/features/notification/domain/repositories/notification_repository.dart';

class GetNotifications {
  final NotificationRepository repository;
  GetNotifications(this.repository);

  Future<List<Notification>> call(String userId) async {
    return repository.getNotifications(userId);
  }
}
// Similar use cases for MarkNotificationRead, DeleteNotification...
```

## Data Layer (DataSources, Models/DTOs, Repository Implementation)

Implement the details of how data is fetched and stored.

1.  **DataSources**: Create classes in `lib/features/[feature_name]/data/datasources/` responsible for interacting with specific data sources (e.g., remote API, local database). These often depend on shared services like `ApiService` from `lib/services/`.
2.  **Models/DTOs**: Define Data Transfer Objects in `lib/features/[feature_name]/data/models/` if the data structure from the source differs from the domain entity. Include `fromJson`/`toJson` methods here. Often, DTOs extend domain entities.
3.  **Repository Implementation**: Create a concrete implementation of the domain repository interface in `lib/features/[feature_name]/data/repositories/`. This class depends on one or more DataSources and handles mapping between DTOs and domain entities if necessary.

Example (Data Layer):

```dart
// lib/features/notification/data/models/notification_dto.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zinapp_v2/features/notification/domain/entities/notification.dart';

part 'notification_dto.freezed.dart';
part 'notification_dto.g.dart';

@freezed
class NotificationDto extends Notification with _$NotificationDto {
  const factory NotificationDto({
    required String id,
    required String title,
    required String message,
    required DateTime timestamp,
    required bool isRead,
    String? imageUrl,
    String? actionUrl,
  }) = _NotificationDto;

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);
}


// lib/features/notification/data/datasources/notification_remote_datasource.dart
import 'package:zinapp_v2/services/api_service.dart'; // Shared service
import 'package:zinapp_v2/features/notification/data/models/notification_dto.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationDto>> getNotifications(String userId);
  Future<void> markAsRead(String notificationId);
  Future<void> deleteNotification(String notificationId);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final ApiService _apiService; // Injected via Riverpod

  NotificationRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<NotificationDto>> getNotifications(String userId) async {
    final response = await _apiService.get('/notifications/$userId');
    // Assuming response.data is List<Map<String, dynamic>>
    return (response.data as List)
        .map((json) => NotificationDto.fromJson(json))
        .toList();
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await _apiService.post('/notifications/$notificationId/read');
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    await _apiService.delete('/notifications/$notificationId');
  }
}

// lib/features/notification/data/repositories/notification_repository_impl.dart
import 'package:zinapp_v2/features/notification/domain/entities/notification.dart';
import 'package:zinapp_v2/features/notification/domain/repositories/notification_repository.dart';
import 'package:zinapp_v2/features/notification/data/datasources/notification_remote_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Notification>> getNotifications(String userId) async {
    // DTOs extend Entities, so direct return is possible here
    // Add mapping logic if DTOs and Entities differ significantly
    return remoteDataSource.getNotifications(userId);
  }

  @override
  Future<void> markNotificationAsRead(String notificationId) async {
    return remoteDataSource.markAsRead(notificationId);
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    return remoteDataSource.deleteNotification(notificationId);
  }
}
```

## Presentation Layer (State Management, UI Components)

Connect the UI to the business logic using Riverpod.

1.  **State Management (Providers)**: Create Riverpod providers in `lib/features/[feature_name]/presentation/providers/`.
    *   Define state class(es) using `freezed`.
    *   Define `Notifier` class(es) using `@riverpod`. Notifiers typically depend on Use Cases from the domain layer.
    *   Inject dependencies (Use Cases, other providers) using `ref.watch` or `ref.read`.
    *   Implement methods in the Notifier that call Use Cases and update the state accordingly.
2.  **UI Components (Screens, Widgets)**: Build the UI in `lib/features/[feature_name]/presentation/screens/` and `lib/features/[feature_name]/presentation/widgets/`.
    *   Use `ConsumerWidget` or `ConsumerStatefulWidget`.
    *   Use `ref.watch` to listen to provider state changes and rebuild the UI.
    *   Use `ref.read` in callbacks (e.g., `onPressed`) to call methods on Notifiers.

Example (Presentation Layer):

```dart
// lib/features/notification/presentation/providers/notification_provider.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zinapp_v2/features/notification/domain/entities/notification.dart';
// Import Use Cases and Repository interfaces/providers
import 'package:zinapp_v2/features/notification/domain/usecases/get_notifications.dart';
import 'package:zinapp_v2/features/notification/domain/usecases/mark_notification_read.dart';
import 'package:zinapp_v2/features/notification/domain/usecases/delete_notification.dart';
// Import provider for repository implementation
import 'package:zinapp_v2/features/notification/presentation/providers/notification_repository_provider.dart';


part 'notification_provider.freezed.dart';
part 'notification_provider.g.dart';

// --- State Definition ---
@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = _Initial;
  const factory NotificationState.loading() = _Loading;
  const factory NotificationState.loaded({required List<Notification> notifications}) = _Loaded;
  const factory NotificationState.error({required String message}) = _Error;
}

// --- Notifier ---
@riverpod
class NotificationNotifier extends _$NotificationNotifier {
  // Depend on Use Cases
  late final GetNotifications _getNotifications;
  late final MarkNotificationRead _markNotificationRead;
  late final DeleteNotification _deleteNotification;

  @override
  NotificationState build() {
    // Initialize dependencies from providers
    final repository = ref.watch(notificationRepositoryProvider); // Assumes this provider exists
    _getNotifications = GetNotifications(repository);
    _markNotificationRead = MarkNotificationRead(repository);
    _deleteNotification = DeleteNotification(repository);
    return const NotificationState.initial();
  }

  Future<void> fetchNotifications(String userId) async {
    state = const NotificationState.loading();
    try {
      final notifications = await _getNotifications(userId);
      state = NotificationState.loaded(notifications: notifications);
    } catch (e) {
      state = NotificationState.error(message: e.toString());
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      await _markNotificationRead(notificationId);
      // Optimistically update UI or refetch
      state = state.maybeWhen(
        loaded: (notifications) => NotificationState.loaded(
          notifications: notifications.map((n) {
            return n.id == notificationId ? n.copyWith(isRead: true) : n;
          }).toList(),
        ),
        orElse: () => state, // Keep current state if not loaded
      );
    } catch (e) {
      // Handle error - maybe revert optimistic update or show message
      print("Error marking notification as read: $e");
      // Optionally update state to show error: state = NotificationState.error(message: 'Failed to mark as read');
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      await _deleteNotification(notificationId);
      // Optimistically update UI or refetch
       state = state.maybeWhen(
        loaded: (notifications) => NotificationState.loaded(
          notifications: notifications.where((n) => n.id != notificationId).toList(),
        ),
        orElse: () => state, // Keep current state if not loaded
      );
    } catch (e) {
       // Handle error - maybe revert optimistic update or show message
       print("Error deleting notification: $e");
       // Optionally update state to show error: state = NotificationState.error(message: 'Failed to delete');
    }
  }
}

// --- Provider for Repository Implementation (Example) ---
// This would typically live in its own file, e.g., notification_repository_provider.dart
// It connects the abstract repository to its concrete implementation

@riverpod
NotificationRemoteDataSource notificationRemoteDataSource(NotificationRemoteDataSourceRef ref) {
  // Depends on the shared ApiService provider
  return NotificationRemoteDataSourceImpl(ref.watch(apiServiceProvider));
}

@riverpod
NotificationRepository notificationRepository(NotificationRepositoryRef ref) {
  // Depends on the remote data source provider
  return NotificationRepositoryImpl(ref.watch(notificationRemoteDataSourceProvider));
}

```

## UI Components

Build the UI components within the feature's `presentation` layer.

1.  Create screen widgets in `lib/features/[feature_name]/presentation/screens/`.
2.  Create reusable widgets specific to this feature in `lib/features/[feature_name]/presentation/widgets/`.
3.  Use `ConsumerWidget` or `ConsumerStatefulWidget` to interact with Riverpod providers.

Example (Screen):

```dart
// lib/features/notification/presentation/screens/notifications_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import providers and widgets
import 'package:zinapp_v2/features/notification/presentation/providers/notification_provider.dart';
import 'package:zinapp_v2/features/notification/presentation/widgets/notification_card.dart';
// Import global auth provider to get user ID
import 'package:zinapp_v2/features/auth/presentation/providers/auth_provider.dart'; // Adjust path as needed

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch initial data after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchNotifications();
    });
  }

  void _fetchNotifications() {
    // Read user ID from global auth provider
    final userId = ref.read(authNotifierProvider).maybeWhen(
          authenticated: (user) => user.id,
          orElse: () => null,
        );
    if (userId != null) {
      // Call the notifier method
      ref.read(notificationNotifierProvider.notifier).fetchNotifications(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the notification state
    final notificationState = ref.watch(notificationNotifierProvider);
    final userId = ref.watch(authNotifierProvider).maybeWhen(
          authenticated: (user) => user.id,
          orElse: () => null,
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: userId == null
          ? const Center(child: Text('Please sign in')) // Handle not logged in
          : RefreshIndicator(
              onRefresh: () async => _fetchNotifications(),
              child: notificationState.when(
                initial: () => const Center(child: Text('Pull to refresh')),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (message) => Center(child: Text('Error: $message')),
                loaded: (notifications) {
                  if (notifications.isEmpty) {
                    return const Center(child: Text('No notifications'));
                  }
                  return ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return NotificationCard(
                        notification: notification,
                        onTap: () {
                          ref
                              .read(notificationNotifierProvider.notifier)
                              .markAsRead(notification.id);
                          // TODO: Handle navigation if actionUrl exists
                        },
                        onDismiss: () {
                          ref
                              .read(notificationNotifierProvider.notifier)
                              .deleteNotification(notification.id);
                        },
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
```

## Navigation

Navigation is handled using GoRouter. Update the router configuration in `lib/router/` (e.g., `app_router.dart`) to include routes for the new feature's screens.

1.  Define route constants/names if needed (e.g., in `lib/constants/app_routes.dart`).
2.  Add `GoRoute` definitions within the main `GoRouter` configuration.

Example:

```dart
// lib/router/app_router.dart (Simplified)
import 'package:go_router/go_router.dart';
import 'package:zinapp_v2/features/notification/presentation/screens/notifications_screen.dart';
// ... other imports

final router = GoRouter(
  initialLocation: '/home', // Or your initial route
  routes: [
    // ... other routes
    GoRoute(
      path: '/notifications',
      // name: AppRoutes.notifications, // Optional: Use named routes
      builder: (context, state) => const NotificationsScreen(),
    ),
  ],
  // ... error handler, redirects, etc.
);
```

## Testing

Follow the testing strategy outlined in `docs/V2_TEST_STRATEGY.md`.

1.  **Domain Layer**: Write unit tests for Use Cases in `test/features/[feature_name]/domain/usecases/`. Mock Repository interfaces.
2.  **Data Layer**: Write unit tests for Repository implementations in `test/features/[feature_name]/data/repositories/`. Mock DataSources. Write unit tests for DataSources, mocking `ApiService` or other external dependencies.
3.  **Presentation Layer**: Write unit tests for Notifiers in `test/features/[feature_name]/presentation/providers/`. Mock Use Cases or override repository providers. Write widget tests for Screens and Widgets in `test/features/[feature_name]/presentation/screens/` and `widgets/`. Override providers to supply mock state.
4.  **Integration Tests**: Create integration tests for key feature flows in `test/integration/`.

Example (Unit Test for Use Case):

```dart
// test/features/notification/domain/usecases/get_notifications_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:zinapp_v2/features/notification/domain/entities/notification.dart';
import 'package:zinapp_v2/features/notification/domain/repositories/notification_repository.dart';
import 'package:zinapp_v2/features/notification/domain/usecases/get_notifications.dart';

// Create a mock repository using mockito or similar
class MockNotificationRepository extends Mock implements NotificationRepository {}

void main() {
  late GetNotifications usecase;
  late MockNotificationRepository mockRepository;

  setUp(() {
    mockRepository = MockNotificationRepository();
    usecase = GetNotifications(mockRepository);
  });

  final tUserId = 'user123';
  final tNotifications = [
    Notification(id: '1', title: 'Test', message: 'Msg', timestamp: DateTime.now(), isRead: false),
  ];

  test('should get notifications from the repository', () async {
    // Arrange
    when(mockRepository.getNotifications(any)).thenAnswer((_) async => tNotifications);
    // Act
    final result = await usecase(tUserId);
    // Assert
    expect(result, tNotifications);
    verify(mockRepository.getNotifications(tUserId));
    verifyNoMoreInteractions(mockRepository);
  });
}
```

## Documentation

Document the new feature thoroughly.

1.  Consider adding a feature-specific README within the feature folder (`lib/features/[feature_name]/README.md`) explaining its purpose, structure, and key components.
2.  Update relevant architecture documents (`docs/technical_architecture.md`, `docs/V2_ARCHITECTURE.md`) if the feature introduces significant architectural patterns or changes.
3.  Add DartDoc comments to public classes, methods, and providers.

## Example: Adding a Notification Feature (Updated Structure)

Let's walk through adding the notification feature following the updated structure.

### 1. Planning (Remains the same)
   *(Define requirements, UI, data model, API, state, navigation)*

### 2. Directory Structure
   Create the structure as defined earlier: `lib/features/notification/` with `data`, `domain`, `presentation` subfolders.

### 3. Domain Layer
   - Create `lib/features/notification/domain/entities/notification.dart` (using `freezed`).
   - Create `lib/features/notification/domain/repositories/notification_repository.dart` (abstract interface).
   - Create `lib/features/notification/domain/usecases/get_notifications.dart`, `mark_notification_read.dart`, `delete_notification.dart`.

### 4. Data Layer
   - Create `lib/features/notification/data/models/notification_dto.dart` (if needed, extending entity, with `fromJson`).
   - Create `lib/features/notification/data/datasources/notification_remote_datasource.dart` (interface and implementation using `ApiService`).
   - Create `lib/features/notification/data/repositories/notification_repository_impl.dart` (implementing the domain interface, using the datasource).

### 5. Presentation Layer (Providers)
   - Create `lib/features/notification/presentation/providers/notification_provider.dart`:
     - Define `NotificationState` using `freezed` (`initial`, `loading`, `loaded`, `error`).
     - Define `NotificationNotifier` using `@riverpod`, depending on the use cases. Implement methods (`fetchNotifications`, `markAsRead`, `deleteNotification`) that call the use cases and update the state.
   - Create providers to inject the repository implementation and datasource (these might live alongside `notification_provider.dart` or in separate files within the providers folder):
     ```dart
     // Example provider setup (adjust based on actual dependencies)
     @riverpod
     NotificationRemoteDataSource notificationRemoteDataSource(NotificationRemoteDataSourceRef ref) {
       return NotificationRemoteDataSourceImpl(ref.watch(apiServiceProvider)); // Assumes global apiServiceProvider
     }

     @riverpod
     NotificationRepository notificationRepository(NotificationRepositoryRef ref) {
       return NotificationRepositoryImpl(ref.watch(notificationRemoteDataSourceProvider));
     }
     ```

### 6. Presentation Layer (UI)
   - Create `lib/features/notification/presentation/widgets/notification_card.dart`.
   - Create `lib/features/notification/presentation/screens/notifications_screen.dart` (using `ConsumerStatefulWidget`, `ref.watch` for state, `ref.read` for actions).

### 7. Navigation
   - Update `lib/router/app_router.dart` (or similar) to add the `/notifications` route pointing to `NotificationsScreen`.

### 8. Testing
   - Add unit tests for use cases, repository implementation, datasource, and notifier.
   - Add widget tests for `NotificationCard` and `NotificationsScreen`.

### 9. Documentation
   - Add DartDoc comments.
   - Consider adding `lib/features/notification/README.md`.

### 10. Code Generation
   - Run `flutter pub run build_runner build --delete-conflicting-outputs` to generate code for `freezed` and `riverpod`.

### 11. Test the Feature
   - Run the app and manually test the feature flow.

## Conclusion

By following this layered, feature-first approach guided by Clean Architecture principles and leveraging Riverpod effectively, you can add new features to ZinApp V2 in a structured, maintainable, and testable way. Remember to adhere to the established patterns and practices for consistency.
