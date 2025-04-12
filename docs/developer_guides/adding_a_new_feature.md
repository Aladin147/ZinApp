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

ZinApp V2 follows a feature-first directory structure. When adding a new feature, create a new directory in the `lib/features` directory with the following structure:

```
lib/features/feature_name/
├── models/            # Feature-specific models
├── providers/         # Feature-specific providers
│   └── riverpod/      # Riverpod providers
├── repositories/      # Feature-specific repositories
├── screens/           # Feature-specific screens
│   └── riverpod/      # Screens using Riverpod
├── services/          # Feature-specific services
└── widgets/           # Feature-specific widgets
```

## Models

Models represent the data structures used in the feature. They should be immutable and use the `freezed` package for code generation.

1. Create a new file in the `lib/features/feature_name/models` directory or in the `lib/models` directory if the model is shared across features.
2. Define the model class using the `freezed` package.
3. Implement `fromJson` and `toJson` methods if the model will be serialized/deserialized.

Example:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

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

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}
```

## Services

Services handle the business logic and external interactions for the feature.

1. Create a new file in the `lib/features/feature_name/services` directory or in the `lib/services` directory if the service is shared across features.
2. Define the service interface.
3. Implement the service.

Example:

```dart
abstract class NotificationService {
  Future<List<Notification>> getNotifications(String userId);
  Future<void> markAsRead(String notificationId);
  Future<void> deleteNotification(String notificationId);
}

class NotificationServiceImpl implements NotificationService {
  final ApiService _apiService;

  NotificationServiceImpl(this._apiService);

  @override
  Future<List<Notification>> getNotifications(String userId) async {
    final response = await _apiService.get('/notifications/$userId');
    return (response.data as List)
        .map((json) => Notification.fromJson(json))
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
```

## State Management

ZinApp V2 uses Riverpod for state management. When adding a new feature, create the necessary providers and notifiers.

1. Create a new file in the `lib/features/feature_name/providers/riverpod` directory.
2. Define the state class using the `freezed` package.
3. Define the notifier class using the `@riverpod` annotation.
4. Implement the necessary methods to update the state.

Example:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zinapp_v2/features/notification/models/notification.dart';
import 'package:zinapp_v2/features/notification/services/notification_service.dart';

part 'notification_provider.freezed.dart';
part 'notification_provider.g.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState({
    required bool isLoading,
    required List<Notification> notifications,
    String? errorMessage,
  }) = _NotificationState;

  factory NotificationState.initial() => const NotificationState(
        isLoading: false,
        notifications: [],
      );
}

@riverpod
class NotificationNotifier extends _$NotificationNotifier {
  late final NotificationService _notificationService;

  @override
  NotificationState build() {
    _notificationService = ref.watch(notificationServiceProvider);
    return NotificationState.initial();
  }

  Future<void> fetchNotifications(String userId) async {
    state = state.copyWith(isLoading: true);
    try {
      final notifications = await _notificationService.getNotifications(userId);
      state = state.copyWith(
        isLoading: false,
        notifications: notifications,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      await _notificationService.markAsRead(notificationId);
      state = state.copyWith(
        notifications: state.notifications.map((notification) {
          if (notification.id == notificationId) {
            return notification.copyWith(isRead: true);
          }
          return notification;
        }).toList(),
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      await _notificationService.deleteNotification(notificationId);
      state = state.copyWith(
        notifications: state.notifications
            .where((notification) => notification.id != notificationId)
            .toList(),
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
      );
    }
  }
}

@riverpod
NotificationService notificationService(NotificationServiceRef ref) {
  final apiService = ref.watch(apiServiceProvider);
  return NotificationServiceImpl(apiService);
}
```

## UI Components

UI components are the building blocks of the feature's user interface. They include screens and widgets.

1. Create a new file in the `lib/features/feature_name/screens/riverpod` directory for screens.
2. Create a new file in the `lib/features/feature_name/widgets` directory for widgets.
3. Implement the UI components using Flutter widgets and Riverpod providers.

Example:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/notification/providers/riverpod/notification_provider.dart';
import 'package:zinapp_v2/features/notification/widgets/notification_card.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationState = ref.watch(notificationNotifierProvider);
    final userId = ref.watch(userIdProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref
            .read(notificationNotifierProvider.notifier)
            .fetchNotifications(userId),
        child: Builder(
          builder: (context) {
            if (notificationState.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (notificationState.errorMessage != null) {
              return Center(
                child: Text(notificationState.errorMessage!),
              );
            }

            if (notificationState.notifications.isEmpty) {
              return const Center(
                child: Text('No notifications'),
              );
            }

            return ListView.builder(
              itemCount: notificationState.notifications.length,
              itemBuilder: (context, index) {
                final notification = notificationState.notifications[index];
                return NotificationCard(
                  notification: notification,
                  onTap: () {
                    ref
                        .read(notificationNotifierProvider.notifier)
                        .markAsRead(notification.id);
                    // Navigate to the notification's action URL if available
                    if (notification.actionUrl != null) {
                      // Navigate to the action URL
                    }
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

Navigation is handled using GoRouter. When adding a new feature, update the router configuration to include the new screens.

1. Open the `lib/router/app_routes.dart` file.
2. Add a new route for the feature's main screen.
3. Add any additional routes for sub-screens.

Example:

```dart
final router = GoRouter(
  initialLocation: '/home',
  routes: [
    // Existing routes...
    
    GoRoute(
      path: '/notifications',
      name: AppRoutes.notifications,
      builder: (context, state) => const NotificationsScreen(),
    ),
  ],
);
```

## Testing

ZinApp V2 follows a comprehensive testing strategy that includes unit tests, widget tests, and integration tests.

1. Create unit tests for models, services, and providers in the `test/unit` directory.
2. Create widget tests for UI components in the `test/widget` directory.
3. Create integration tests for feature flows in the `test/integration` directory.

Example:

```dart
// Unit test for NotificationService
void main() {
  group('NotificationService', () {
    late MockApiService mockApiService;
    late NotificationService notificationService;

    setUp(() {
      mockApiService = MockApiService();
      notificationService = NotificationServiceImpl(mockApiService);
    });

    test('getNotifications returns a list of notifications', () async {
      // Arrange
      when(mockApiService.get('/notifications/user123')).thenAnswer(
        (_) async => ApiResponse(
          data: [
            {
              'id': 'notification1',
              'title': 'Test Notification',
              'message': 'This is a test notification',
              'timestamp': '2023-01-01T00:00:00.000Z',
              'isRead': false,
            },
          ],
        ),
      );

      // Act
      final notifications = await notificationService.getNotifications('user123');

      // Assert
      expect(notifications, isA<List<Notification>>());
      expect(notifications.length, 1);
      expect(notifications[0].id, 'notification1');
      expect(notifications[0].title, 'Test Notification');
      expect(notifications[0].message, 'This is a test notification');
      expect(notifications[0].timestamp, DateTime.parse('2023-01-01T00:00:00.000Z'));
      expect(notifications[0].isRead, false);
    });
  });
}
```

## Documentation

Document the new feature to help other developers understand how it works.

1. Update the architecture documentation to include the new feature.
2. Create a feature-specific documentation file if necessary.
3. Add comments to the code to explain complex logic.

Example:

```markdown
# Notification Feature

The notification feature allows users to receive and manage notifications within the application.

## Components

- **NotificationService**: Handles fetching, marking as read, and deleting notifications.
- **NotificationNotifier**: Manages the state of notifications and provides methods to update them.
- **NotificationsScreen**: Displays a list of notifications to the user.
- **NotificationCard**: Displays a single notification with options to mark as read and delete.

## Usage

To display the notifications screen, navigate to the `/notifications` route:

```dart
context.go('/notifications');
```

To fetch notifications for a user:

```dart
ref.read(notificationNotifierProvider.notifier).fetchNotifications(userId);
```

To mark a notification as read:

```dart
ref.read(notificationNotifierProvider.notifier).markAsRead(notificationId);
```

To delete a notification:

```dart
ref.read(notificationNotifierProvider.notifier).deleteNotification(notificationId);
```
```

## Example: Adding a Notification Feature

Let's walk through the process of adding a notification feature to the ZinApp V2 application.

### 1. Planning

**Feature Requirements:**
- Users should be able to view a list of notifications.
- Users should be able to mark notifications as read.
- Users should be able to delete notifications.
- Notifications should include a title, message, timestamp, and read status.
- Some notifications may include an image and an action URL.

**UI Design:**
- A notifications screen that displays a list of notifications.
- Each notification is displayed as a card with the title, message, timestamp, and read status.
- Notifications can be swiped to delete.
- Tapping a notification marks it as read and navigates to the action URL if available.

**Data Model:**
- Notification model with id, title, message, timestamp, isRead, imageUrl, and actionUrl fields.

**API Integration:**
- GET /notifications/{userId} to fetch notifications.
- POST /notifications/{notificationId}/read to mark a notification as read.
- DELETE /notifications/{notificationId} to delete a notification.

**State Management:**
- NotificationState to track the loading state, notifications list, and error message.
- NotificationNotifier to handle fetching, marking as read, and deleting notifications.

**Navigation:**
- A route to the notifications screen.

### 2. Directory Structure

Create the following directory structure:

```
lib/features/notification/
├── models/
├── providers/
│   └── riverpod/
├── screens/
│   └── riverpod/
├── services/
└── widgets/
```

### 3. Models

Create the notification model:

```dart
// lib/features/notification/models/notification.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

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

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}
```

### 4. Services

Create the notification service:

```dart
// lib/features/notification/services/notification_service.dart
import 'package:zinapp_v2/features/notification/models/notification.dart';
import 'package:zinapp_v2/services/api_service.dart';

abstract class NotificationService {
  Future<List<Notification>> getNotifications(String userId);
  Future<void> markAsRead(String notificationId);
  Future<void> deleteNotification(String notificationId);
}

class NotificationServiceImpl implements NotificationService {
  final ApiService _apiService;

  NotificationServiceImpl(this._apiService);

  @override
  Future<List<Notification>> getNotifications(String userId) async {
    final response = await _apiService.get('/notifications/$userId');
    return (response.data as List)
        .map((json) => Notification.fromJson(json))
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
```

### 5. State Management

Create the notification provider:

```dart
// lib/features/notification/providers/riverpod/notification_provider.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zinapp_v2/features/notification/models/notification.dart';
import 'package:zinapp_v2/features/notification/services/notification_service.dart';
import 'package:zinapp_v2/providers/api/api_provider.dart';

part 'notification_provider.freezed.dart';
part 'notification_provider.g.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState({
    required bool isLoading,
    required List<Notification> notifications,
    String? errorMessage,
  }) = _NotificationState;

  factory NotificationState.initial() => const NotificationState(
        isLoading: false,
        notifications: [],
      );
}

@riverpod
class NotificationNotifier extends _$NotificationNotifier {
  late final NotificationService _notificationService;

  @override
  NotificationState build() {
    _notificationService = ref.watch(notificationServiceProvider);
    return NotificationState.initial();
  }

  Future<void> fetchNotifications(String userId) async {
    state = state.copyWith(isLoading: true);
    try {
      final notifications = await _notificationService.getNotifications(userId);
      state = state.copyWith(
        isLoading: false,
        notifications: notifications,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      await _notificationService.markAsRead(notificationId);
      state = state.copyWith(
        notifications: state.notifications.map((notification) {
          if (notification.id == notificationId) {
            return notification.copyWith(isRead: true);
          }
          return notification;
        }).toList(),
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      await _notificationService.deleteNotification(notificationId);
      state = state.copyWith(
        notifications: state.notifications
            .where((notification) => notification.id != notificationId)
            .toList(),
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
      );
    }
  }
}

@riverpod
NotificationService notificationService(NotificationServiceRef ref) {
  final apiService = ref.watch(apiServiceProvider);
  return NotificationServiceImpl(apiService);
}
```

### 6. UI Components

Create the notification card widget:

```dart
// lib/features/notification/widgets/notification_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zinapp_v2/features/notification/models/notification.dart';

class NotificationCard extends StatelessWidget {
  final Notification notification;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const NotificationCard({
    Key? key,
    required this.notification,
    required this.onTap,
    required this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat.yMMMd().add_jm();

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss(),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight:
                              notification.isRead ? FontWeight.normal : FontWeight.bold,
                        ),
                      ),
                    ),
                    if (!notification.isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  notification.message,
                  style: theme.textTheme.bodyMedium,
                ),
                if (notification.imageUrl != null) ...[
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      notification.imageUrl!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  dateFormat.format(notification.timestamp),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

Create the notifications screen:

```dart
// lib/features/notification/screens/riverpod/notifications_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/features/notification/providers/riverpod/notification_provider.dart';
import 'package:zinapp_v2/features/notification/widgets/notification_card.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = ref.read(authStateProvider).userProfile?.id;
      if (userId != null) {
        ref.read(notificationNotifierProvider.notifier).fetchNotifications(userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final notificationState = ref.watch(notificationNotifierProvider);
    final userId = ref.watch(authStateProvider).userProfile?.id;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: userId == null
          ? const Center(
              child: Text('Please sign in to view notifications'),
            )
          : RefreshIndicator(
              onRefresh: () => ref
                  .read(notificationNotifierProvider.notifier)
                  .fetchNotifications(userId),
              child: Builder(
                builder: (context) {
                  if (notificationState.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (notificationState.errorMessage != null) {
                    return Center(
                      child: Text(notificationState.errorMessage!),
                    );
                  }

                  if (notificationState.notifications.isEmpty) {
                    return const Center(
                      child: Text('No notifications'),
                    );
                  }

                  return ListView.builder(
                    itemCount: notificationState.notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notificationState.notifications[index];
                      return NotificationCard(
                        notification: notification,
                        onTap: () {
                          ref
                              .read(notificationNotifierProvider.notifier)
                              .markAsRead(notification.id);
                          // Navigate to the notification's action URL if available
                          if (notification.actionUrl != null) {
                            // Navigate to the action URL
                          }
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

### 7. Navigation

Update the router configuration:

```dart
// lib/router/app_routes.dart
final router = GoRouter(
  initialLocation: '/home',
  routes: [
    // Existing routes...
    
    GoRoute(
      path: '/notifications',
      name: AppRoutes.notifications,
      builder: (context, state) => const NotificationsScreen(),
    ),
  ],
);
```

### 8. Testing

Create unit tests for the notification service:

```dart
// test/unit/features/notification/services/notification_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:zinapp_v2/features/notification/models/notification.dart';
import 'package:zinapp_v2/features/notification/services/notification_service.dart';
import 'package:zinapp_v2/services/api_service.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  group('NotificationService', () {
    late MockApiService mockApiService;
    late NotificationService notificationService;

    setUp(() {
      mockApiService = MockApiService();
      notificationService = NotificationServiceImpl(mockApiService);
    });

    test('getNotifications returns a list of notifications', () async {
      // Arrange
      when(mockApiService.get('/notifications/user123')).thenAnswer(
        (_) async => ApiResponse(
          data: [
            {
              'id': 'notification1',
              'title': 'Test Notification',
              'message': 'This is a test notification',
              'timestamp': '2023-01-01T00:00:00.000Z',
              'isRead': false,
            },
          ],
        ),
      );

      // Act
      final notifications = await notificationService.getNotifications('user123');

      // Assert
      expect(notifications, isA<List<Notification>>());
      expect(notifications.length, 1);
      expect(notifications[0].id, 'notification1');
      expect(notifications[0].title, 'Test Notification');
      expect(notifications[0].message, 'This is a test notification');
      expect(notifications[0].timestamp, DateTime.parse('2023-01-01T00:00:00.000Z'));
      expect(notifications[0].isRead, false);
    });
  });
}
```

Create widget tests for the notification card:

```dart
// test/widget/features/notification/widgets/notification_card_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zinapp_v2/features/notification/models/notification.dart';
import 'package:zinapp_v2/features/notification/widgets/notification_card.dart';

void main() {
  testWidgets('NotificationCard displays notification details', (tester) async {
    // Arrange
    final notification = Notification(
      id: 'notification1',
      title: 'Test Notification',
      message: 'This is a test notification',
      timestamp: DateTime.parse('2023-01-01T00:00:00.000Z'),
      isRead: false,
    );
    bool tapped = false;
    bool dismissed = false;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NotificationCard(
            notification: notification,
            onTap: () => tapped = true,
            onDismiss: () => dismissed = true,
          ),
        ),
      ),
    );

    // Assert
    expect(find.text('Test Notification'), findsOneWidget);
    expect(find.text('This is a test notification'), findsOneWidget);
    expect(find.text('Jan 1, 2023 12:00 AM'), findsOneWidget);

    // Test tap
    await tester.tap(find.byType(InkWell));
    expect(tapped, true);

    // Test dismiss
    await tester.drag(find.byType(Dismissible), const Offset(-500, 0));
    await tester.pumpAndSettle();
    expect(dismissed, true);
  });
}
```

### 9. Documentation

Create documentation for the notification feature:

```markdown
# Notification Feature

The notification feature allows users to receive and manage notifications within the application.

## Components

- **NotificationService**: Handles fetching, marking as read, and deleting notifications.
- **NotificationNotifier**: Manages the state of notifications and provides methods to update them.
- **NotificationsScreen**: Displays a list of notifications to the user.
- **NotificationCard**: Displays a single notification with options to mark as read and delete.

## Usage

To display the notifications screen, navigate to the `/notifications` route:

```dart
context.go('/notifications');
```

To fetch notifications for a user:

```dart
ref.read(notificationNotifierProvider.notifier).fetchNotifications(userId);
```

To mark a notification as read:

```dart
ref.read(notificationNotifierProvider.notifier).markAsRead(notificationId);
```

To delete a notification:

```dart
ref.read(notificationNotifierProvider.notifier).deleteNotification(notificationId);
```
```

### 10. Run the build_runner

Run the build_runner to generate the necessary code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 11. Test the Feature

Run the application and test the notification feature to ensure it works as expected.

## Conclusion

By following this guide, you should be able to add a new feature to the ZinApp V2 application in a structured and maintainable way. Remember to follow the established patterns and practices to ensure consistency across the codebase.
