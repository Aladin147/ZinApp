# ZinApp V2 Gamification System

This document outlines the gamification system for ZinApp V2, including XP, levels, tokens, and rewards.

## Overview

ZinApp V2 incorporates a comprehensive gamification system to enhance user engagement and retention. The system includes experience points (XP), levels, Zin tokens, and rewards that users can earn through various actions within the app.

## Gamification Components

### 1. Experience Points (XP)

XP is earned through various actions in the app:

| Action | XP Reward |
|--------|-----------|
| Rate a stylist | 5 XP |
| Post a review | 10 XP |
| Share a tagged photo | 30 XP + 10 Zin |
| Comment on a post | 3 XP |
| Complete a booking | 15 XP |
| Refer a friend | 25 XP |
| First booking of the month | 20 XP |

XP accumulates over time and determines the user's level.

### 2. User Levels

Users progress through levels as they earn XP:

| Level | Name | XP Required | Benefits |
|-------|------|-------------|----------|
| 1 | Bronze | 0-99 XP | Basic app features |
| 2 | Silver | 100-299 XP | 5% discount on bookings |
| 3 | Gold | 300-599 XP | 10% discount on bookings, priority booking |
| 4 | Prime | 600-999 XP | 15% discount, priority booking, exclusive styles |
| 5 | Legend | 1000+ XP | 20% discount, VIP treatment, exclusive events |

### 3. Stylist Levels

Stylists also have progression levels:

| Level | Title | Requirements | Benefits |
|-------|-------|--------------|----------|
| 1 | Rising | New stylists | Standard visibility |
| 2 | Pro | 50+ completed bookings, 4.0+ rating | Enhanced visibility, featured listing |
| 3 | Veteran | 200+ completed bookings, 4.5+ rating | Premium visibility, custom pricing |
| 4 | Legend | 500+ completed bookings, 4.8+ rating | Top visibility, exclusive features |

### 4. Zin Tokens

Zin tokens are a virtual currency that can be earned and spent within the app:

- **Earning Tokens**:
  - Completing bookings: 5-20 Zin (based on booking value)
  - Sharing tagged photos: 10 Zin
  - Referrals: 15 Zin
  - Special promotions: Variable amounts

- **Spending Tokens**:
  - Discounts on bookings: 20 Zin = 5% off
  - Unlock exclusive styles: 30-50 Zin
  - Priority booking: 15 Zin
  - Gift to stylists: Any amount

### 5. Achievements and Badges

Users can earn achievements and badges for specific accomplishments:

- **Loyalty Badges**:
  - First Timer: Complete first booking
  - Regular: Complete 5 bookings
  - Loyal: Complete 10 bookings
  - VIP: Complete 25 bookings

- **Explorer Badges**:
  - Try 3 different services
  - Book 3 different stylists
  - Book in 3 different locations

- **Social Badges**:
  - Share 5 photos
  - Write 10 reviews
  - Refer 3 friends

## Visual Representation

### XP and Level Display

- User profile shows current level with visual indicator
- XP bar shows progress to next level
- Animation plays when leveling up
- Level badge appears next to user name throughout the app

### Token Display

- Token balance displayed in header or profile
- Token icon uses the primary highlight color (#D2FF4D)
- Animations play when tokens are earned or spent
- Token history available in user profile

### Achievements and Badges

- Badges displayed on user profile
- Notification and animation when badge is earned
- Badge collection view shows earned and locked badges
- Progress indicators for badges in progress

## Implementation Details

### Placeholder Logic

The gamification system is currently implemented with placeholder logic in `/lib/game_logic/demo_logic.dart`:

- XP, levels, and Zin tokens are simulated with local variables and JSON assets
- User actions trigger XP and token rewards
- Level progression is calculated based on XP thresholds
- Token balance is maintained locally

### Mock Data

Sample users and stylists are provided with seed profiles to test the gamification system:

- Users with various XP levels and token balances
- Stylists with different ratings and completion counts
- Sample achievements and badges

### Future Implementation

In the production version, the gamification system will be integrated with the backend:

- User profiles will store XP, level, and token data
- Actions will trigger API calls to update user stats
- Achievements will be tracked and awarded server-side
- Token transactions will be recorded and validated

## UI Components

### XP Bar

- Animated progress bar showing XP progress to next level
- Current XP and next level threshold displayed
- Color uses primary highlight (#D2FF4D)

### Level Badge

- Circular badge with level name
- Color indicates level (Bronze, Silver, Gold, etc.)
- Animation plays when displayed

### Token Display

- Icon + numeric value
- Uses primary highlight color (#D2FF4D)
- Animated when value changes

### Achievement Notification

- Toast or modal notification when achievement is earned
- Animation and sound effect
- Option to share achievement

## Integration Points

The gamification system integrates with several parts of the app:

1. **User Profile**: Displays level, XP, tokens, and achievements
2. **Booking Flow**: Awards XP and tokens on completion
3. **Social Features**: Awards XP and tokens for sharing and reviews
4. **Stylist Selection**: Shows stylist levels and ratings
5. **Rewards Shop**: Allows spending tokens on rewards

## Testing the Gamification System

To test the gamification system:

1. Use the sample actions in the app to trigger XP and token rewards
2. Check the user profile to see level progression
3. Verify that achievements are awarded correctly
4. Test token spending on various rewards
