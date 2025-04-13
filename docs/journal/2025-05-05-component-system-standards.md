# Component System Standards

**Date:** May 5, 2025  
**Author:** Development Team  
**Status:** Complete

## Overview

This journal documents the standardization of our component system across all three layers of our architecture. With the implementation of the UI, Simulation, and Data layers, and the ongoing migration of features, it's essential to establish clear standards for components to ensure consistency, maintainability, and the efficient onboarding of new team members.

## Core Principles

Our component system standards are guided by these fundamental principles:

1. **Consistency** - Components should behave predictably and have consistent interfaces
2. **Composability** - Components should be designed to work well together
3. **Reusability** - Components should be applicable across different contexts
4. **Testability** - Components should be easy to test in isolation
5. **Accessibility** - Components should be accessible to all users
6. **Performance** - Components should be optimized for performance
7. **Documentation** - Components should be well-documented for developers

## UI Layer Standards

### Naming Conventions

All UI components follow a standardized naming pattern:

| Component Type | Prefix | Example |
|----------------|--------|---------|
| Core components | `Zin` | `ZinButton`, `ZinCard` |
| Layout components | `Zin` | `ZinColumn`, `ZinRow` |
| Screen components | No prefix | `ProfileScreen`, `FeedScreen` |
| Dialog components | `Dialog` | `ConfirmationDialog`, `SelectionDialog` |
| Widget parts | Descriptive | `CardHeader`, `ButtonLabel` |

```dart
// Core UI component example
class ZinButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ZinButtonVariant variant;
  final ZinButtonSize size;
  
  const ZinButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.variant = ZinButtonVariant.primary,
    this.size = ZinButtonSize.medium,
  }) : super(key: key);
  
  // Implementation...
}

// Screen component example
class StylistProfileScreen extends ConsumerWidget {
  final String stylistId;
  
  const StylistProfileScreen({
    Key? key,
    required this.stylistId,
  }) : super(key: key);
  
  // Implementation...
}
```

### Component Documentation

Every UI component must include the following documentation:

1. **Class Documentation** - Purpose, usage, and important notes
2. **Parameter Documentation** - Description of each parameter
3. **Example Usage** - Code snippet showing typical usage
4. **Screenshots** - Visual examples for complex components
5. **Accessibility Notes** - Special considerations for accessibility

```dart
/// A button component with various visual styles and sizes.
///
/// This button adapts to the current theme and supports different variants
/// (primary, secondary, tertiary) and sizes (small, medium, large).
///
/// Example usage:
/// ```dart
/// ZinButton(
///   label: 'Continue',
///   onPressed: () => Navigator.of(context).push(...),
///   variant: ZinButtonVariant.primary,
///   size: ZinButtonSize.large,
/// )
/// ```
///
/// Accessibility notes:
/// - Ensures minimum touch target size of 44x44 for all size variants
/// - Primary variant has contrast ratio >= 4.5:1
/// - Includes focus and hover states for keyboard navigation
class ZinButton extends StatelessWidget {
  /// The text displayed on the button.
  final String label;
  
  /// Callback triggered when the button is pressed.
  final VoidCallback onPressed;
  
  /// Visual style of the button.
  /// See [ZinButtonVariant] for available options.
  final ZinButtonVariant variant;
  
  /// Size of the button.
  /// See [ZinButtonSize] for available options.
  final ZinButtonSize size;
  
  // Implementation...
}
```

### Component Structure

UI components should adhere to a standard internal structure:

1. **Constructor and Fields** - At the top, with required parameters first
2. **Private Methods** - Helper methods used within the component
3. **Build Method** - Implementation of the component rendering
4. **State Management** - For stateful components, state logic grouped together
5. **External Interaction Methods** - Methods called by parent components

```dart
class ZinInteractiveCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool elevated;
  
  const ZinInteractiveCard({
    Key? key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.elevated = false,
  }) : super(key: key);
  
  @override
  State<ZinInteractiveCard> createState() => _ZinInteractiveCardState();
}

class _ZinInteractiveCardState extends State<ZinInteractiveCard> {
  // State variables
  bool _isPressed = false;
  bool _isFocused = false;
  
  // Private helper methods
  double _getElevation() {
    if (!widget.elevated) return 0;
    if (_isPressed) return 1;
    if (_isFocused) return 4;
    return 2;
  }
  
  // Build method
  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: _handleFocusChange,
      child: GestureDetector(
        onTap: _handleTap,
        onLongPress: _handleLongPress,
        onTapDown: (_) => _updatePressedState(true),
        onTapUp: (_) => _updatePressedState(false),
        onTapCancel: () => _updatePressedState(false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: _buildShadow(),
          ),
          child: widget.child,
        ),
      ),
    );
  }
  
  // State management methods
  void _updatePressedState(bool pressed) {
    if (_isPressed != pressed) {
      setState(() {
        _isPressed = pressed;
      });
    }
  }
  
  void _handleFocusChange(bool focused) {
    setState(() {
      _isFocused = focused;
    });
  }
  
  // External interaction methods
  void _handleTap() {
    if (widget.onTap != null) {
      widget.onTap!();
    }
  }
  
  void _handleLongPress() {
    if (widget.onLongPress != null) {
      widget.onLongPress!();
    }
  }
  
  // Additional helpers
  List<BoxShadow> _buildShadow() {
    // Implementation...
  }
}
```

### Accessibility Guidelines

All UI components must meet the following accessibility requirements:

1. **Contrast Ratios** - Text contrast ratio ≥ 4.5:1, UI controls ≥ 3:1
2. **Touch Targets** - Minimum size of 44x44 logical pixels
3. **Screen Reader Support** - Semantic labels for all interactive elements
4. **Keyboard Navigation** - Focus indicators and logical tab order
5. **Text Scaling** - Support font scaling up to 200%
6. **Reduced Motion** - Respect system reduced motion settings

```dart
class ZinChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool selected;
  
  const ZinChip({
    Key? key,
    required this.label,
    this.onTap,
    this.icon,
    this.selected = false,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isInteractive = onTap != null;
    
    // Ensure chip is accessible
    return Semantics(
      label: label,
      button: isInteractive,
      selected: selected,
      excludeSemantics: true, // We're providing our own semantics
      child: MergeSemantics(
        child: GestureDetector(
          onTap: onTap,
          // Ensure minimum size for touch target
          behavior: HitTestBehavior.opaque,
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 44,
              minHeight: 44,
            ),
            decoration: BoxDecoration(
              color: selected ? theme.colorScheme.primary : theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: selected ? theme.colorScheme.primary : theme.colorScheme.outline,
                width: 1,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 18,
                    color: selected 
                        ? theme.colorScheme.onPrimary 
                        : theme.colorScheme.onSurface,
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  label,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: selected 
                        ? theme.colorScheme.onPrimary 
                        : theme.colorScheme.onSurface,
                  ),
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

## Simulation Layer Standards

### Naming Conventions

Simulation layer components follow these naming conventions:

| Component Type | Suffix | Example |
|----------------|--------|---------|
| Simulation | `Simulation` | `UserProfileSimulation`, `FeedSimulation` |
| State | `State` | `UserProfileState`, `FeedState` |
| Command | `Command` | `UpdateProfileCommand`, `PostCommentCommand` |
| Event | `Event` | `ProfileUpdatedEvent`, `CommentPostedEvent` |
| Effect | `Effect` | `ShowAchievementEffect`, `NavigateToProfileEffect` |

```dart
class FeedSimulation extends StateNotifier<FeedState> {
  final FeedRepository _repository;
  
  FeedSimulation({
    required FeedRepository repository,
  }) : 
    _repository = repository,
    super(FeedState.initial());
}

@immutable
class FeedState {
  final List<Post> posts;
  final bool isLoading;
  final String? errorMessage;
  
  const FeedState({
    required this.posts,
    required this.isLoading,
    this.errorMessage,
  });
  
  factory FeedState.initial() {
    return const FeedState(
      posts: [],
      isLoading: false,
    );
  }
  
  FeedState copyWith({
    List<Post>? posts,
    bool? isLoading,
    String? errorMessage,
  }) {
    return FeedState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
```

### Simulation Documentation

Each Simulation layer component must include:

1. **Class Purpose** - What the simulation represents and its responsibilities
2. **State Documentation** - Description of the state structure
3. **Command Documentation** - Each command's purpose and parameters
4. **Integration Notes** - How the simulation interacts with other simulations
5. **Repository Dependencies** - Required repositories and their usage

```dart
/// Manages user profile data and operations.
///
/// Responsibilities:
/// - Loading and caching user profile information
/// - Processing profile updates
/// - Managing profile-related UI effects
/// - Tracking profile completion and achievements
///
/// Integration with other simulations:
/// - Notifies [AchievementSimulation] when profile updates might trigger achievements
/// - Consumes events from [AuthSimulation] for user session changes
class UserProfileSimulation extends StateNotifier<UserProfileState> {
  final UserProfileRepository _repository;
  final EffectController _effectController;
  
  /// Creates a new UserProfileSimulation.
  ///
  /// Requires a [UserProfileRepository] for data access and an
  /// [EffectController] for dispatching UI effects.
  UserProfileSimulation({
    required UserProfileRepository repository,
    required EffectController effectController,
  }) : 
    _repository = repository,
    _effectController = effectController,
    super(UserProfileState.initial());
  
  /// Loads a user profile by ID.
  ///
  /// Sets [UserProfileState.isLoading] while in progress and
  /// updates state with the loaded profile on success or
  /// sets an error message on failure.
  Future<void> loadProfile(String userId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final profile = await _repository.getUserProfile(userId);
      state = state.copyWith(
        profile: profile,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load profile: ${e.toString()}',
      );
    }
  }
  
  // Other methods...
}
```

### Command Pattern

All state modifications use the Command pattern with these guidelines:

1. **Immutable** - Commands should be immutable data classes
2. **Single Responsibility** - Each command does one specific thing
3. **Validation** - Commands validate inputs before execution
4. **Result Handling** - Commands return success or failure results
5. **Idempotency** - When possible, commands should be idempotent

```dart
/// Command to update a user's profile information.
@immutable
class UpdateProfileCommand {
  final String userId;
  final String? displayName;
  final String? bio;
  final String? profileImageUrl;
  
  /// Creates a command to update profile information.
  ///
  /// At least one of [displayName], [bio], or [profileImageUrl]
  /// must be non-null.
  const UpdateProfileCommand({
    required this.userId,
    this.displayName,
    this.bio,
    this.profileImageUrl,
  }) : assert(
         displayName != null || bio != null || profileImageUrl != null,
         'At least one profile field must be updated'
       );
  
  /// Validates the command parameters.
  ///
  /// Returns a [ValidationResult] indicating whether the command
  /// is valid for execution.
  ValidationResult validate() {
    if (userId.isEmpty) {
      return ValidationResult.error('User ID cannot be empty');
    }
    
    if (displayName != null && displayName!.length < 2) {
      return ValidationResult.error('Display name must be at least 2 characters');
    }
    
    if (bio != null && bio!.length > 500) {
      return ValidationResult.error('Bio cannot exceed 500 characters');
    }
    
    return ValidationResult.success();
  }
}

// In the simulation
Future<CommandResult> updateProfile(UpdateProfileCommand command) async {
  // Validate command
  final validation = command.validate();
  if (!validation.isValid) {
    return CommandResult.failure(validation.errorMessage!);
  }
  
  // Execute command
  state = state.copyWith(isLoading: true);
  
  try {
    // Create updated profile
    final currentProfile = state.profile;
    if (currentProfile == null) {
      return CommandResult.failure('No profile loaded');
    }
    
    final updatedProfile = currentProfile.copyWith(
      displayName: command.displayName ?? currentProfile.displayName,
      bio: command.bio ?? currentProfile.bio,
      profileImageUrl: command.profileImageUrl ?? currentProfile.profileImageUrl,
    );
    
    // Save to repository
    await _repository.updateProfile(updatedProfile);
    
    // Update state
    state = state.copyWith(
      profile: updatedProfile,
      isLoading: false,
    );
    
    // Dispatch effects
    _effectController.dispatch(ProfileUpdatedEffect(updatedProfile));
    
    return CommandResult.success();
  } catch (e) {
    state = state.copyWith(
      isLoading: false,
      errorMessage: 'Failed to update profile: ${e.toString()}',
    );
    
    return CommandResult.failure(e.toString());
  }
}
```

### Effect System

UI effects triggered by simulations follow these guidelines:

1. **Immutable** - Effects are immutable data classes
2. **Descriptive** - Effect names clearly describe their purpose
3. **Self-Contained** - Effects include all data needed for handling
4. **Typed** - Effects use a type hierarchy for structured handling

```dart
/// Base class for all effects in the system.
@immutable
abstract class Effect {
  const Effect();
}

/// Effect for showing an achievement notification.
class ShowAchievementEffect extends Effect {
  final Achievement achievement;
  final int tokenReward;
  
  const ShowAchievementEffect({
    required this.achievement,
    required this.tokenReward,
  });
}

/// Effect for navigating to a profile screen.
class NavigateToProfileEffect extends Effect {
  final String userId;
  final bool animated;
  
  const NavigateToProfileEffect({
    required this.userId,
    this.animated = true,
  });
}

// In the UI layer
class EffectHandler extends ConsumerWidget {
  final Widget child;
  
  const EffectHandler({
    Key? key,
    required this.child,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to effects
    ref.listen<Effect?>(effectProvider, (previous, effect) {
      if (effect == null) return;
      
      // Handle different effect types
      if (effect is ShowAchievementEffect) {
        _showAchievement(context, effect);
      } else if (effect is NavigateToProfileEffect) {
        _navigateToProfile(context, effect);
      }
      
      // Clear effect after handling
      ref.read(effectProvider.notifier).clearEffect();
    });
    
    return child;
  }
  
  void _showAchievement(BuildContext context, ShowAchievementEffect effect) {
    // Show achievement notification
  }
  
  void _navigateToProfile(BuildContext context, NavigateToProfileEffect effect) {
    // Navigate to profile
  }
}
```

## Data Layer Standards

### Naming Conventions

Data layer components adhere to these naming conventions:

| Component Type | Suffix | Example |
|----------------|--------|---------|
| Repository Interface | `Repository` | `UserRepository`, `FeedRepository` |
| Repository Implementation | `RepositoryImpl` | `UserRepositoryImpl`, `FeedRepositoryImpl` |
| Data Source | `DataSource` | `UserRemoteDataSource`, `FeedLocalDataSource` |
| Data Model | `Model` or `Entity` | `UserModel`, `PostEntity` |
| Response/Request | `Response`/`Request` | `LoginResponse`, `UpdateProfileRequest` |

```dart
abstract class StylistRepository {
  Future<List<Stylist>> getTrendingStylists();
  Future<Stylist> getStylistDetails(String id);
  Future<List<Stylist>> searchStylists(String query);
}

class StylistRepositoryImpl implements StylistRepository {
  final StylistRemoteDataSource _remoteDataSource;
  final StylistLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  
  StylistRepositoryImpl({
    required StylistRemoteDataSource remoteDataSource,
    required StylistLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  }) : 
    _remoteDataSource = remoteDataSource,
    _localDataSource = localDataSource,
    _networkInfo = networkInfo;
  
  @override
  Future<List<Stylist>> getTrendingStylists() async {
    // Implementation...
  }
  
  // Other methods...
}
```

### Repository Documentation

Each repository must include:

1. **Interface Documentation** - Purpose and responsibilities of the repository
2. **Method Documentation** - Purpose, parameters, return values, and exceptions
3. **Error Handling** - Common error scenarios and how they're handled
4. **Caching Strategy** - How data is cached and refreshed
5. **Offline Support** - Behavior when offline

```dart
/// Repository for managing feed content, including posts and comments.
///
/// Responsibilities:
/// - Retrieving feed posts with pagination
/// - Managing post interactions (likes, comments, shares)
/// - Tracking read status and engagement metrics
///
/// Caching strategy:
/// - Feed posts are cached for 15 minutes
/// - User's own posts are cached indefinitely
/// - Comments are cached along with their parent posts
///
/// Offline support:
/// - Read operations use cached data when offline
/// - Write operations are queued for sync when online
abstract class FeedRepository {
  /// Retrieves a paginated feed of posts.
  ///
  /// The [page] parameter specifies which page to retrieve (0-based).
  /// The [pageSize] parameter specifies how many posts per page.
  ///
  /// Returns a list of [Post] objects ordered by recency.
  ///
  /// Throws [NetworkException] if a network error occurs.
  /// Throws [AuthException] if the user is not authenticated.
  ///
  /// When offline, returns cached posts if available or an empty list
  /// if no cached data exists.
  Future<List<Post>> getFeedPosts({
    required int page,
    int pageSize = 20,
  });
  
  /// Creates a new post.
  ///
  /// The [content] parameter contains the post text.
  /// The [mediaUrls] parameter contains optional media attachments.
  ///
  /// Returns the created [Post] object.
  ///
  /// Throws [NetworkException] if a network error occurs.
  /// Throws [ValidationException] if the content is invalid.
  /// Throws [AuthException] if the user is not authenticated.
  ///
  /// When offline, stores the post locally and returns a temporary
  /// post object. The post will be synced when online.
  Future<Post> createPost({
    required String content,
    List<String> mediaUrls = const [],
  });
  
  // Other methods...
}
```

### Model Structure

Data models follow these structural guidelines:

1. **Immutability** - Models are immutable data classes
2. **Factory Constructors** - Named constructors for different creation scenarios
3. **JSON Handling** - `fromJson` and `toJson` methods for serialization
4. **Domain Conversion** - Methods to convert between data and domain models
5. **Equality** - Implementation of `==` and `hashCode` for comparison

```dart
@JsonSerializable()
class PostModel {
  final String id;
  final String userId;
  final String content;
  final List<String> mediaUrls;
  final int likeCount;
  final int commentCount;
  final DateTime createdAt;
  final DateTime? updatedAt;
  
  const PostModel({
    required this.id,
    required this.userId,
    required this.content,
    required this.mediaUrls,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
    this.updatedAt,
  });
  
  /// Creates a model from JSON data.
  factory PostModel.fromJson(Map<String, dynamic> json) => 
    _$PostModelFromJson(json);
  
  /// Creates a model from a domain Post entity.
  factory PostModel.fromDomain(Post post) {
    return PostModel(
      id: post.id,
      userId: post.author.id,
      content: post.content,
      mediaUrls: post.media.map((m) => m.url).toList(),
      likeCount: post.likeCount,
      commentCount: post.commentCount,
      createdAt: post.createdAt,
      updatedAt: post.updatedAt,
    );
  }
  
  /// Creates an empty model with default values.
  factory PostModel.empty() {
    return PostModel(
      id: '',
      userId: '',
      content: '',
      mediaUrls: const [],
      likeCount: 0,
      commentCount: 0,
      createdAt: DateTime.now(),
    );
  }
  
  /// Converts to JSON data.
  Map<String, dynamic> toJson() => _$PostModelToJson(this);
  
  /// Converts to a domain Post entity.
  Post toDomain() {
    return Post(
      id: id,
      author: UserProfile(id: userId), // Simplified, real code would do a proper conversion
      content: content,
      media: mediaUrls.map((url) => Media(url: url)).toList(),
      likeCount: likeCount,
      commentCount: commentCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
  
  /// Creates a copy with updated fields.
  PostModel copyWith({
    String? id,
    String? userId,
    String? content,
    List<String>? mediaUrls,
    int? likeCount,
    int? commentCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is PostModel &&
    runtimeType == other.runtimeType &&
    id == other.id &&
    userId == other.userId &&
    content == other.content &&
    listEquals(mediaUrls, other.mediaUrls) &&
    likeCount == other.likeCount &&
    commentCount == other.commentCount &&
    createdAt == other.createdAt &&
    updatedAt == other.updatedAt;

  @override
  int get hashCode =>
    id.hashCode ^
    userId.hashCode ^
    content.hashCode ^
    mediaUrls.hashCode ^
    likeCount.hashCode ^
    commentCount.hashCode ^
    createdAt.hashCode ^
    updatedAt.hashCode;
}
```

## Testing Requirements

### UI Layer Testing

UI components must meet these testing requirements:

1. **Widget Tests** - Basic rendering and interaction tests
2. **Golden Tests** - Visual appearance verification for key components
3. **Accessibility Tests** - Verify semantic properties and screen reader support
4. **Theme Tests** - Verify appearance in different themes

```dart
void main() {
  group('ZinButton', () {
    testWidgets('renders correctly with label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZinButton(
              label: 'Test Button',
              onPressed: () {},
            ),
          ),
        ),
      );
      
      expect(find.text('Test Button'), findsOneWidget);
    });
    
    testWidgets('calls onPressed when tapped', (WidgetTester tester) async {
      bool pressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZinButton(
              label: 'Test Button',
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );
      
      await tester.tap(find.byType(ZinButton));
      expect(pressed, true);
    });
    
    testWidgets('has correct semantics', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZinButton(
              label: 'Test Button',
              onPressed: () {},
            ),
          ),
        ),
      );
      
      final SemanticsHandle handle = tester.ensureSemantics();
      expect(
        tester.getSemantics(find.byType(ZinButton)),
        matchesSemantics(
          label: 'Test Button',
          isButton: true,
          isFocusable: true,
          hasEnabledState: true,
          isEnabled: true,
        ),
      );
      handle.dispose();
    });
    
    testGoldens('matches golden file', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ZinButton(
                    label: 'Primary Button',
                    onPressed: () {},
                    variant: ZinButtonVariant.primary,
                  ),
                  SizedBox(height: 16),
                  ZinButton(
                    label: 'Secondary Button',
                    onPressed: () {},
                    variant: ZinButtonVariant.secondary,
                  ),
                  SizedBox(height: 16),
                  ZinButton(
                    label: 'Tertiary Button',
                    onPressed: () {},
                    variant: ZinButtonVariant.tertiary,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      
      await expectLater(
        find.byType(Column),
        matchesGoldenFile('goldens/zin_button_variants.png'),
      );
    });
  });
}
```

### Simulation Layer Testing

Simulation layer components require:

1. **Unit Tests** - Test state transitions for all commands
2. **Mock Tests** - Test interactions with dependencies using mocks
3. **Integration Tests** - Test interactions between simulations
4. **Error Tests** - Verify error handling and recovery

```dart
void main() {
  group('UserProfileSimulation', () {
    late MockUserProfileRepository mockRepository;
    late MockEffectController mockEffectController;
    late UserProfileSimulation simulation;
    
    setUp(() {
      mockRepository = MockUserProfileRepository();
      mockEffectController = MockEffectController();
      simulation = UserProfileSimulation(
        repository: mockRepository,
        effectController: mockEffectController,
      );
    });
    
    test('initial state is correct', () {
      expect(simulation.state.profile, null);
      expect(simulation.state.isLoading, false);
      expect(simulation.state.errorMessage, null);
    });
    
    group('loadProfile', () {
      final testProfile = UserProfile(
        id: 'test-user',
        displayName: 'Test User',
      );
      
      test('updates state with profile on success', () async {
        // Arrange
        when(() => mockRepository.getUserProfile('test-user'))
          .thenAnswer((_) async => testProfile);
        
        // Act
        await simulation.loadProfile('test-user');
        
        // Assert
        expect(simulation.state.profile, testProfile);
        expect(simulation.state.isLoading, false);
        expect(simulation.state.errorMessage, null);
        verify(() => mockRepository.getUserProfile('test-user')).called(1);
      });
      
      test('sets error message on failure', () async {
        // Arrange
        when(() => mockRepository.getUserProfile('test-user'))
          .thenThrow(Exception('Network error'));
