# Split-Screen Home Layout Specification

## Overview

This document specifies the implementation of the split-screen home layout for ZinApp V2, featuring a three-section design with a gamified HUD dashboard, action/discovery zone, and social feed. This innovative layout combines gamification elements with practical functionality to create an engaging and efficient user experience.

## Goals

1. Create a visually distinctive and engaging home screen
2. Combine gamification elements with practical functionality
3. Maximize engagement while reducing choice friction
4. Support both social and service aspects of the app
5. Provide clear visual hierarchy and intuitive navigation

## Layout Structure

The home screen is divided into three distinct sections:

1. **HUD Dashboard (Top 20%)**
   - Displays user stats, level, tokens, and achievements
   - Provides immediate feedback on user progress
   - Creates game-like engagement through visual elements

2. **Action & Discovery Zone (Middle 30%)**
   - Features horizontally scrollable content cards
   - Provides quick access to primary actions
   - Showcases personalized recommendations

3. **Social Feed (Bottom 50%)**
   - Displays scrollable feed of posts from stylists and users
   - Supports social engagement through likes, comments, shares
   - Provides visual inspiration and community connection

## Detailed Section Specifications

### HUD Dashboard

#### Content Elements

1. **User Stats Bar**
   - Profile avatar with tap to profile
   - Username and current rank/title
   - Level indicator (e.g., "Level 12")
   - XP progress bar (visual progress to next level)

2. **Token Display**
   - Zin token balance with icon
   - Subtle animation on balance changes
   - Tap to view transaction history

3. **Achievement Showcase**
   - Recently unlocked achievements (3-4 max)
   - "New" indicator for fresh achievements
   - Tap to view all achievements

4. **Quick Stats**
   - Booking streak
   - Follower count
   - Style points

#### Visual Design

- Dark background with neon accents
- Subtle ambient animations (pulsing, floating elements)
- Glow effects around important elements
- Semi-transparent overlays for depth

#### Interactions

- Tap on profile avatar to navigate to profile screen
- Tap on token display to view transaction history
- Tap on achievements to view achievement details
- Pull down gesture to reveal more detailed stats

### Action & Discovery Zone

#### Content Elements

1. **Featured Stylists**
   - Horizontally scrollable cards
   - Availability status indicators
   - Rating and specialty information
   - "Book Now" quick action

2. **Quick Action Buttons**
   - "Find Stylist" with location icon
   - "Book Appointment" with calendar icon
   - "Share Style" with camera icon
   - "Daily Quest" with reward indicator

3. **Personalized Recommendations**
   - "Trending Styles" carousel
   - "For You" style suggestions
   - "Nearby Stylists" with availability

4. **Challenges & Quests**
   - Daily challenges with reward indicators
   - Progress tracking for ongoing quests
   - Time-limited special events

#### Visual Design

- Slightly lighter background than HUD
- Card-based layout with clear visual hierarchy
- Animated highlights for time-sensitive content
- Consistent corner radii and shadow effects

#### Interactions

- Horizontal scrolling for carousels
- Tap on stylist cards to view profile
- Tap on action buttons to navigate to respective screens
- Pull to refresh for new recommendations

### Social Feed

#### Content Elements

1. **Post Cards**
   - User/stylist information
   - Visual content (images/videos)
   - Caption and hashtags
   - Engagement metrics (likes, comments)
   - Action buttons (like, comment, share)

2. **Feed Filters**
   - "For You" (algorithmic)
   - "Following" (accounts user follows)
   - "Trending" (popular content)
   - "Nearby" (location-based)

3. **Engagement Elements**
   - Comment preview (1-2 comments)
   - Like animation
   - Share options
   - "Try This Style" button on appropriate posts

#### Visual Design

- Full-width content cards
- Emphasis on visual content
- Clean typography for readability
- Subtle separators between posts

#### Interactions

- Vertical scrolling for feed content
- Double-tap to like
- Tap on comments to expand
- Tap on user/stylist to view profile
- Long-press for additional options

## Component Architecture

### HomeScreen Container

```dart
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // HUD Dashboard (20% of screen height)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: HudDashboard(),
            ),
            
            // Action & Discovery Zone (30% of screen height)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ActionDiscoveryZone(),
            ),
            
            // Social Feed (50% of screen height)
            Expanded(
              child: SocialFeed(),
            ),
          ],
        ),
      ),
    );
  }
}
```

### HUD Dashboard Component

```dart
class HudDashboard extends StatelessWidget {
  const HudDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.baseDark,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top row: User info and tokens
          Row(
            children: [
              // User avatar and info
              UserInfoWidget(),
              
              Spacer(),
              
              // Token display
              TokenDisplayWidget(),
            ],
          ),
          
          SizedBox(height: 12),
          
          // Bottom row: XP progress and achievements
          Row(
            children: [
              // XP progress bar
              Expanded(
                flex: 3,
                child: XpProgressWidget(),
              ),
              
              SizedBox(width: 12),
              
              // Achievement showcase
              Expanded(
                flex: 2,
                child: AchievementShowcaseWidget(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

### Action & Discovery Zone Component

```dart
class ActionDiscoveryZone extends StatelessWidget {
  const ActionDiscoveryZone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.baseDark.withOpacity(0.9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Discover',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          
          SizedBox(height: 12),
          
          // Featured stylists carousel
          SizedBox(
            height: 120,
            child: FeaturedStylistsCarousel(),
          ),
          
          SizedBox(height: 16),
          
          // Quick action buttons
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ActionButton(
                  icon: Icons.search,
                  label: 'Find',
                  onTap: () => _handleFindTap(context),
                ),
                ActionButton(
                  icon: Icons.calendar_today,
                  label: 'Book',
                  onTap: () => _handleBookTap(context),
                ),
                ActionButton(
                  icon: Icons.camera_alt,
                  label: 'Share',
                  onTap: () => _handleShareTap(context),
                ),
                ActionButton(
                  icon: Icons.star,
                  label: 'Quests',
                  onTap: () => _handleQuestsTap(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Handler methods...
}
```

### Social Feed Component

```dart
class SocialFeed extends StatefulWidget {
  const SocialFeed({Key? key}) : super(key: key);

  @override
  _SocialFeedState createState() => _SocialFeedState();
}

class _SocialFeedState extends State<SocialFeed> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Feed filter tabs
        TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryHighlight,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primaryHighlight,
          tabs: [
            Tab(text: 'For You'),
            Tab(text: 'Following'),
            Tab(text: 'Trending'),
          ],
        ),
        
        // Feed content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // For You feed
              PostsList(feedType: FeedType.forYou),
              
              // Following feed
              PostsList(feedType: FeedType.following),
              
              // Trending feed
              PostsList(feedType: FeedType.trending),
            ],
          ),
        ),
      ],
    );
  }
}
```

## Responsive Behavior

### Small Screens (< 5.5")
- Reduce padding and margins
- Smaller avatar and icon sizes
- Simplified HUD with essential elements only
- Single-column action buttons

### Medium Screens (5.5" - 6.5")
- Standard layout as specified
- Balanced spacing and element sizes
- Full feature set

### Large Screens (> 6.5")
- Increased padding and margins
- Larger touch targets
- Enhanced visual elements
- Additional content in action zone

### Tablets
- Two-column layout for feed
- Expanded HUD with additional stats
- Grid layout for action buttons
- Side-by-side content in discovery zone

## State Management

### HomeScreenProvider

```dart
class HomeScreenProvider extends ChangeNotifier {
  final UserProfileService _profileService = UserProfileService();
  final StylistService _stylistService = StylistService();
  final PostService _postService = PostService();
  
  UserProfile? _userProfile;
  List<Stylist> _featuredStylists = [];
  List<Post> _forYouPosts = [];
  List<Post> _followingPosts = [];
  List<Post> _trendingPosts = [];
  List<Challenge> _dailyChallenges = [];
  
  bool _isLoading = false;
  String? _error;
  
  // Getters
  UserProfile? get userProfile => _userProfile;
  List<Stylist> get featuredStylists => _featuredStylists;
  List<Post> get forYouPosts => _forYouPosts;
  List<Post> get followingPosts => _followingPosts;
  List<Post> get trendingPosts => _trendingPosts;
  List<Challenge> get dailyChallenges => _dailyChallenges;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  // Initialize provider
  Future<void> initialize(String userId) async {
    // Implementation...
  }
  
  // Load featured stylists
  Future<void> loadFeaturedStylists() async {
    // Implementation...
  }
  
  // Load feed posts
  Future<void> loadFeedPosts(FeedType feedType) async {
    // Implementation...
  }
  
  // Load daily challenges
  Future<void> loadDailyChallenges() async {
    // Implementation...
  }
  
  // Handle post interaction
  Future<void> interactWithPost(Post post, PostInteraction interaction) async {
    // Implementation...
  }
  
  // Refresh all data
  Future<void> refreshAll() async {
    // Implementation...
  }
}
```

## Animation and Transitions

### Micro-Animations

1. **Token Balance Changes**
   - Subtle bounce effect
   - Number counter animation
   - Glow effect on increase

2. **XP Progress Updates**
   - Progress bar fill animation
   - Particle effects on level up
   - Pulsing glow on near completion

3. **Achievement Unlocks**
   - Fade in and scale up
   - Sparkle effect
   - Brief celebration animation

4. **Feed Interactions**
   - Heart burst on like
   - Comment bubble pop
   - Share icon spin

### Section Transitions

1. **Initial Load**
   - Staggered fade in of sections
   - Sequential loading animations
   - Shimmer placeholders during data fetch

2. **Pull to Refresh**
   - Circular progress indicator
   - Section-specific refresh animations
   - Success indicator on completion

3. **Section Expansion (Future Enhancement)**
   - Smooth animation when expanding a section
   - Fade out of other sections
   - Return button animation

## Performance Considerations

### Rendering Optimization

1. **Lazy Loading**
   - Load feed posts as needed
   - Implement pagination for large data sets
   - Cache images and profile data

2. **Widget Efficiency**
   - Use const constructors where possible
   - Implement shouldRebuild for custom widgets
   - Minimize rebuilds with selective notifyListeners()

3. **Image Handling**
   - Proper image caching
   - Progressive loading for feed images
   - Appropriate image resolution for device

### Memory Management

1. **Resource Cleanup**
   - Dispose controllers and animations
   - Cancel subscriptions when not needed
   - Clear caches when low on memory

2. **State Persistence**
   - Save scroll position when navigating away
   - Persist filter selections
   - Cache feed data for quick return

## Implementation Timeline

### Week 1: Basic Structure

- Implement the three-section layout container
- Create placeholder content for each section
- Set up responsive behavior
- Implement basic state management

### Week 2: HUD Dashboard

- Implement user stats display
- Create XP progress visualization
- Add token balance display
- Develop achievement showcase

### Week 3: Action & Discovery Zone

- Implement featured stylists carousel
- Create action buttons with navigation
- Add daily challenges display
- Develop personalized recommendations

### Week 4: Social Feed

- Implement feed tabs and filtering
- Create post card component
- Add interaction functionality
- Implement infinite scrolling

### Week 5: Polish & Integration

- Add animations and transitions
- Optimize performance
- Integrate with authentication and profile services
- Conduct comprehensive testing

## Testing Strategy

### Unit Tests

- Test individual components in isolation
- Verify state management logic
- Test responsive behavior calculations

### Widget Tests

- Test component rendering
- Verify interaction handling
- Test animations and transitions

### Integration Tests

- Test full home screen functionality
- Verify data flow between sections
- Test performance with realistic data volumes

## Conclusion

This split-screen home layout specification provides a comprehensive blueprint for implementing an innovative and engaging home screen for ZinApp V2. The three-section design combines gamification elements with practical functionality to create a unique user experience that differentiates the app from competitors while maximizing engagement and reducing choice friction.
