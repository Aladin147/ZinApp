# Extended User Profile Specification

## Overview

This document specifies the extended user profile model for ZinApp V2, incorporating gamification elements such as XP, levels, tokens, and achievements. The enhanced profile model will support the gamified user experience while maintaining compatibility with future backend integration.

## Goals

1. Define a comprehensive user profile data model that supports gamification
2. Specify the relationships between gamification elements (XP, level, tokens)
3. Design a flexible achievement system
4. Support different user types (regular users vs. stylists)
5. Enable profile customization and personalization

## User Profile Data Model

### Core User Data

```dart
class User {
  final String id;           // Unique identifier
  final String email;        // User's email address
  final String username;     // Display name
  final DateTime createdAt;  // Account creation timestamp
  final DateTime lastLogin;  // Last login timestamp
  final UserType userType;   // Regular or Stylist
  
  // Constructor, serialization methods, etc.
}
```

### Extended Profile Data

```dart
class UserProfile extends User {
  // Gamification Elements
  final int xp;                      // Experience points
  final int level;                   // Current level
  final int tokens;                  // Zin tokens balance
  final List<String> achievements;   // Unlocked achievements
  final List<String> badges;         // Earned badges
  final String rank;                 // Current rank/title
  
  // Profile Customization
  final String profilePictureUrl;    // Avatar image
  final String bio;                  // User biography
  final String location;             // User location
  final Map<String, dynamic> preferences; // User preferences
  
  // Style Information
  final List<String> favoriteStyles;     // Preferred hairstyles
  final List<String> favoriteStylistIds; // Bookmarked stylists
  
  // Statistics
  final int postsCount;              // Number of posts created
  final int bookingsCount;           // Number of bookings made
  final int followersCount;          // Number of followers
  final int followingCount;          // Number of users following
  
  // Stylist-specific fields (null for regular users)
  final StylistProfile? stylistProfile;
  
  // Constructor, serialization methods, etc.
}
```

### Stylist Profile Data

```dart
class StylistProfile {
  final String specialization;       // Hair type specialization
  final List<String> services;       // Offered services
  final double rating;               // Average rating (1-5)
  final int reviewCount;             // Number of reviews
  final String businessName;         // Business/salon name
  final String businessAddress;      // Business location
  final BusinessHours businessHours; // Operating hours
  final List<String> portfolioUrls;  // Work samples
  final bool isAvailable;            // Current availability
  final int completedBookings;       // Total bookings completed
  final int clientCount;             // Number of unique clients
  
  // Constructor, serialization methods, etc.
}
```

### Business Hours

```dart
class BusinessHours {
  final Map<String, DaySchedule> schedule; // Key: day name, Value: schedule
  
  // Constructor, serialization methods, etc.
}

class DaySchedule {
  final bool isOpen;
  final TimeOfDay openTime;
  final TimeOfDay closeTime;
  final List<TimeSlot> breaks;
  
  // Constructor, serialization methods, etc.
}

class TimeSlot {
  final TimeOfDay start;
  final TimeOfDay end;
  
  // Constructor, serialization methods, etc.
}
```

## Gamification System

### XP and Leveling

```dart
class XpSystem {
  // XP required for each level
  static const Map<int, int> levelRequirements = {
    1: 0,
    2: 100,
    3: 250,
    4: 500,
    5: 1000,
    // Additional levels...
  };
  
  // Calculate level based on XP
  static int calculateLevel(int xp) {
    // Implementation...
  }
  
  // Calculate XP needed for next level
  static int xpForNextLevel(int currentLevel) {
    // Implementation...
  }
  
  // Calculate progress percentage to next level
  static double levelProgress(int xp) {
    // Implementation...
  }
}
```

### Ranks and Titles

```dart
class RankSystem {
  // Ranks for regular users
  static const Map<int, String> userRanks = {
    1: "Style Novice",
    5: "Style Enthusiast",
    10: "Style Explorer",
    15: "Style Connoisseur",
    20: "Style Maven",
    25: "Style Guru",
    30: "Style Legend",
    // Additional ranks...
  };
  
  // Ranks for stylists
  static const Map<int, String> stylistRanks = {
    1: "Apprentice Stylist",
    5: "Established Stylist",
    10: "Expert Stylist",
    15: "Master Stylist",
    20: "Elite Stylist",
    25: "Celebrity Stylist",
    30: "Legendary Stylist",
    // Additional ranks...
  };
  
  // Get rank title based on level and user type
  static String getRank(int level, UserType userType) {
    // Implementation...
  }
}
```

### Achievement System

```dart
class Achievement {
  final String id;           // Unique identifier
  final String title;        // Display name
  final String description;  // Achievement description
  final String iconUrl;      // Icon image
  final int xpReward;        // XP awarded when unlocked
  final int tokenReward;     // Tokens awarded when unlocked
  final AchievementCategory category; // Achievement type
  final AchievementRarity rarity;     // How difficult to earn
  
  // Constructor, serialization methods, etc.
}

enum AchievementCategory {
  onboarding,    // First-time actions
  social,        // Social interactions
  booking,       // Booking-related
  style,         // Style-related
  loyalty,       // Long-term engagement
  milestone,     // Numeric milestones
  special,       // Limited-time events
}

enum AchievementRarity {
  common,        // Easy to earn
  uncommon,      // Moderate effort
  rare,          // Significant effort
  epic,          // Difficult to earn
  legendary,     // Very challenging
}
```

### Token Economy

```dart
class TokenTransaction {
  final String id;
  final String userId;
  final int amount;
  final TokenTransactionType type;
  final String? description;
  final DateTime timestamp;
  final String? relatedEntityId;  // Post ID, booking ID, etc.
  
  // Constructor, serialization methods, etc.
}

enum TokenTransactionType {
  earned,     // Tokens earned through actions
  spent,      // Tokens spent on features/services
  received,   // Tokens received from another user
  sent,       // Tokens sent to another user
  system,     // System adjustments (e.g., bonuses)
}
```

## User Preferences

```dart
class UserPreferences {
  // Notification Preferences
  final bool enablePushNotifications;
  final bool enableEmailNotifications;
  final bool notifyOnBookingUpdates;
  final bool notifyOnSocialActivity;
  final bool notifyOnPromotions;
  
  // Privacy Preferences
  final PrivacyLevel profileVisibility;
  final bool showLocationOnProfile;
  final bool allowTagging;
  
  // App Preferences
  final ThemeMode themeMode;
  final String language;
  final bool enableAnimations;
  
  // Constructor, serialization methods, etc.
}

enum PrivacyLevel {
  public,     // Visible to everyone
  followers,  // Visible to followers only
  private,    // Visible to approved users only
}
```

## JSON Representation

Example of a user profile in JSON format (for JSON Server):

```json
{
  "id": "user123",
  "email": "user@example.com",
  "username": "StyleEnthusiast",
  "createdAt": "2023-06-15T10:30:00Z",
  "lastLogin": "2023-06-16T08:45:00Z",
  "userType": "regular",
  
  "xp": 750,
  "level": 4,
  "tokens": 120,
  "achievements": ["first_login", "first_booking", "social_butterfly"],
  "badges": ["early_adopter", "trendsetter"],
  "rank": "Style Explorer",
  
  "profilePictureUrl": "assets/images/avatars/user123.png",
  "bio": "Hair enthusiast looking for the perfect style!",
  "location": "New York, NY",
  "preferences": {
    "enablePushNotifications": true,
    "enableEmailNotifications": false,
    "notifyOnBookingUpdates": true,
    "notifyOnSocialActivity": true,
    "notifyOnPromotions": false,
    "profileVisibility": "public",
    "showLocationOnProfile": true,
    "allowTagging": true,
    "themeMode": "system",
    "language": "en",
    "enableAnimations": true
  },
  
  "favoriteStyles": ["bob", "pixie", "layers"],
  "favoriteStylistIds": ["stylist456", "stylist789"],
  
  "postsCount": 12,
  "bookingsCount": 5,
  "followersCount": 45,
  "followingCount": 32,
  
  "stylistProfile": null
}
```

Example of a stylist profile:

```json
{
  "id": "stylist456",
  "email": "stylist@example.com",
  "username": "MasterStylist",
  "createdAt": "2023-05-10T09:15:00Z",
  "lastLogin": "2023-06-16T10:20:00Z",
  "userType": "stylist",
  
  "xp": 2500,
  "level": 15,
  "tokens": 350,
  "achievements": ["first_client", "perfect_rating", "booking_master"],
  "badges": ["certified_colorist", "texture_expert"],
  "rank": "Master Stylist",
  
  "profilePictureUrl": "assets/images/avatars/stylist456.png",
  "bio": "Specializing in color transformations and textured hair.",
  "location": "Los Angeles, CA",
  "preferences": {
    "enablePushNotifications": true,
    "enableEmailNotifications": true,
    "notifyOnBookingUpdates": true,
    "notifyOnSocialActivity": true,
    "notifyOnPromotions": true,
    "profileVisibility": "public",
    "showLocationOnProfile": true,
    "allowTagging": true,
    "themeMode": "dark",
    "language": "en",
    "enableAnimations": true
  },
  
  "favoriteStyles": ["balayage", "ombre", "curly"],
  "favoriteStylistIds": [],
  
  "postsCount": 87,
  "bookingsCount": 0,
  "followersCount": 1250,
  "followingCount": 45,
  
  "stylistProfile": {
    "specialization": "Color Specialist",
    "services": ["haircut", "color", "highlights", "treatment"],
    "rating": 4.9,
    "reviewCount": 142,
    "businessName": "Style Studio",
    "businessAddress": "123 Fashion Ave, Los Angeles, CA",
    "businessHours": {
      "monday": {"isOpen": true, "openTime": "09:00", "closeTime": "18:00", "breaks": []},
      "tuesday": {"isOpen": true, "openTime": "09:00", "closeTime": "18:00", "breaks": []},
      "wednesday": {"isOpen": true, "openTime": "09:00", "closeTime": "18:00", "breaks": []},
      "thursday": {"isOpen": true, "openTime": "09:00", "closeTime": "20:00", "breaks": []},
      "friday": {"isOpen": true, "openTime": "09:00", "closeTime": "20:00", "breaks": []},
      "saturday": {"isOpen": true, "openTime": "10:00", "closeTime": "16:00", "breaks": []},
      "sunday": {"isOpen": false, "openTime": null, "closeTime": null, "breaks": []}
    },
    "portfolioUrls": [
      "assets/images/portfolio/stylist456_1.jpg",
      "assets/images/portfolio/stylist456_2.jpg",
      "assets/images/portfolio/stylist456_3.jpg"
    ],
    "isAvailable": true,
    "completedBookings": 1024,
    "clientCount": 345
  }
}
```

## Service Layer

### UserProfileService

```dart
class UserProfileService {
  final String baseUrl = 'http://192.168.1.X:3000';
  
  // Get user profile by ID
  Future<UserProfile> getUserProfile(String userId) async {
    // Implementation...
  }
  
  // Update user profile
  Future<UserProfile> updateUserProfile(String userId, Map<String, dynamic> updates) async {
    // Implementation...
  }
  
  // Add XP to user
  Future<UserProfile> addXp(String userId, int amount, String reason) async {
    // Implementation...
  }
  
  // Add/remove tokens
  Future<UserProfile> updateTokens(String userId, int amount, TokenTransactionType type, String description) async {
    // Implementation...
  }
  
  // Unlock achievement
  Future<UserProfile> unlockAchievement(String userId, String achievementId) async {
    // Implementation...
  }
  
  // Get token transaction history
  Future<List<TokenTransaction>> getTokenHistory(String userId) async {
    // Implementation...
  }
}
```

### UserProfileProvider

```dart
class UserProfileProvider extends ChangeNotifier {
  final UserProfileService _profileService = UserProfileService();
  
  UserProfile? _userProfile;
  bool _isLoading = false;
  String? _error;
  
  UserProfile? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  // Load user profile
  Future<void> loadUserProfile(String userId) async {
    // Implementation...
  }
  
  // Update profile
  Future<bool> updateProfile(Map<String, dynamic> updates) async {
    // Implementation...
  }
  
  // Add XP
  Future<bool> addXp(int amount, String reason) async {
    // Implementation...
  }
  
  // Update tokens
  Future<bool> updateTokens(int amount, TokenTransactionType type, String description) async {
    // Implementation...
  }
  
  // Unlock achievement
  Future<bool> unlockAchievement(String achievementId) async {
    // Implementation...
  }
}
```

## UI Components

### ProfileHeader

- Displays user avatar, name, and rank
- Shows level and XP progress bar
- Displays token balance
- Shows key stats (posts, followers, etc.)

### AchievementsList

- Displays unlocked achievements
- Shows locked achievements with requirements
- Provides details on tap
- Animates new achievements

### TokenHistoryView

- Lists recent token transactions
- Shows transaction type and amount
- Displays timestamp and description
- Supports filtering by transaction type

### LevelProgressCard

- Shows current level and rank
- Displays XP progress to next level
- Visualizes progress with animated bar
- Shows rewards for next level

## Implementation Timeline

### Week 1: Core Models

- Implement basic User and UserProfile models
- Create JSON serialization/deserialization
- Set up UserProfileService with basic methods
- Implement profile loading and caching

### Week 2: Gamification Elements

- Implement XP and leveling system
- Create achievement tracking
- Add token transaction handling
- Develop rank progression logic

### Week 3: UI Components

- Build profile header component
- Create achievement list and details view
- Implement token history display
- Develop level progress visualization

## Migration Path to Cloud Services

When ready to migrate to Firebase or Supabase:

1. Map local data model to cloud database schema
2. Create data migration scripts
3. Update UserProfileService to use cloud APIs
4. Implement server-side validation and business logic
5. Add real-time synchronization for multi-device support

## Conclusion

This extended user profile specification provides a comprehensive foundation for implementing the gamified user experience in ZinApp V2. The design supports both regular users and stylists while enabling future expansion of the gamification system and eventual migration to cloud services.
