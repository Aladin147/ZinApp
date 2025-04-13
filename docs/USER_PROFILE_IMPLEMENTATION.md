# User Profile Implementation

This document outlines the implementation of the game-inspired user profile in ZinApp V2.

## Overview

The user profile is designed as a game character sheet, showcasing the user's achievements, tokens, level, and other gamification elements. It provides a visually engaging and interactive experience that encourages users to invest in their profile and participate in the ZinApp ecosystem.

## Key Features

### 1. Game Character Profile

- **Profile Header**: Displays user avatar with level indicator, username, rank, and XP progress bar
- **Stats Display**: Shows key stats like tokens, achievements, bookings, and followers
- **Character Tab**: Provides detailed information about the user, including level progress, token balance, bio, and favorite styles
- **Achievements Tab**: Displays unlocked achievements and progress toward new ones
- **Tokens Tab**: Shows token balance, transaction history, and token management options

### 2. Gamification Elements

- **Level System**: Users earn XP and progress through levels
- **Achievement System**: Users unlock achievements for various actions
- **Token Economy**: Users earn, spend, and manage ZIN tokens
- **Visual Progression**: Progress bars, level indicators, and visual effects show advancement

### 3. Navigation

- **Tab-Based Layout**: Easy navigation between different profile sections
- **Deep-Dive Sections**: Tap on elements to see more detailed information
- **Smooth Transitions**: Animated transitions between sections enhance the experience

## Implementation Details

### Models

- **UserProfile**: Extended user model with gamification elements (XP, level, tokens, achievements)
- **Achievement**: Model for achievements with properties like title, description, rewards
- **TokenTransaction**: Model for token transactions with type, amount, description

### Screens

- **GameProfileScreen**: Main profile screen with tabs for Character, Achievements, and Tokens
- **ProfileEditScreen**: Screen for editing profile information

### Widgets

- **AchievementCard**: Displays an achievement with its icon, title, and locked/unlocked state
- **LevelProgressCard**: Shows level progress and rewards for the next level
- **TokenBalanceCard**: Displays token balance with visual effects
- **TokenTransactionItem**: List item for token transactions

### Navigation

- Profile screen accessible from:
  - Avatar in the GamerDashboardSection
  - Profile button in the floating action buttons
  - (Future) Bottom navigation bar

## Future Enhancements

1. **Enhanced Animations**: Add more micro-animations for level-ups, token transactions, etc.
2. **Customization Options**: Allow users to customize their profile appearance
3. **Social Features**: Add friend connections, leaderboards, and social sharing
4. **Achievement Sets**: Group related achievements with completion bonuses
5. **Token Earning Opportunities**: Add more ways to earn tokens through the profile

## Design Decisions

1. **Game Character Approach**: The profile is designed as a game character sheet to leverage game psychology (FOMO, collection, progression) and encourage user investment.
2. **Visual Hierarchy**: Important elements like level, tokens, and achievements are prominently displayed to emphasize progression.
3. **Tab-Based Organization**: Content is organized into tabs to provide a clean, focused experience while allowing access to all profile aspects.
4. **Token Integration**: Token economy is deeply integrated into the profile to emphasize its importance in the ZinApp ecosystem.

## Usage

The profile screen is accessible through:

1. Tapping on the user avatar in the home screen's gamer dashboard
2. Tapping the profile button in the floating action buttons
3. (Future) Through the bottom navigation bar

## Related Components

- **AuthProvider**: Manages user authentication and provides user data
- **UserProfileProvider**: Manages user profile state and operations
- **TokenProvider**: Handles token transactions and balance
- **AchievementProvider**: Tracks achievements and progress
