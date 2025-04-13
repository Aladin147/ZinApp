# Token Economy Implementation

This document outlines the implementation of the token economy system in ZinApp V2.

## Overview

The token economy is a core feature of ZinApp, allowing users to earn, spend, and manage ZIN tokens throughout the app. Tokens serve as an in-app currency that incentivizes user engagement and provides a mechanism for rewarding desired behaviors.

## Key Components

### 1. Gamification Service

The `GamificationService` is the central service that manages all token and XP-related operations:

- **Token Rewards**: Awards tokens for various user actions
- **XP Management**: Tracks user experience points and level progression
- **Achievement Tracking**: Monitors user progress toward achievements
- **Daily/Weekly Challenges**: Manages time-based challenges and rewards

### 2. Token Transactions

The `TokenTransaction` model tracks all token movements with the following types:
- **Earned**: Tokens earned through actions and achievements
- **Spent**: Tokens spent on purchases or features
- **Received**: Tokens received from other users
- **Sent**: Tokens sent to other users
- **System**: System-generated token adjustments

### 3. Rewards Hub

The Rewards Hub serves as the central location for all token-related activities:
- **Token Balance Display**: Shows current token balance with visual effects
- **Earning Opportunities**: Provides access to ways to earn tokens
- **Spending Options**: Offers ways to spend tokens
- **Transaction History**: Displays recent token transactions

### 4. Daily Rewards

The Daily Rewards screen encourages regular app usage:
- **Daily Login Bonus**: Tokens and XP for logging in each day
- **Streak Rewards**: Bonus rewards for consecutive days of activity
- **Daily Challenges**: Small tasks that can be completed for rewards

### 5. Challenges

The Challenges screen provides more substantial ways to earn tokens:
- **Daily Challenges**: Quick tasks refreshed daily
- **Weekly Challenges**: More involved tasks with higher rewards
- **Special Challenges**: Long-term goals with significant rewards

### 6. Token Shop

The Token Shop allows users to spend their tokens:
- **Profile Customizations**: Visual enhancements for user profiles
- **Premium Features**: Access to advanced app features
- **Style Collections**: Exclusive hairstyle collections and trends

## Implementation Details

### Models

- **TokenTransaction**: Records all token movements with type, amount, description, and timestamp
- **GamificationState**: Tracks the current state of gamification features
- **UserProfile**: Extended with token balance, XP, level, and achievements

### Services

- **GamificationService**: Core service for token and XP management
- **UserProfileService**: Manages user profile data including token balance

### Providers

- **GamificationProvider**: Riverpod provider for gamification state
- **UserProfileProvider**: Manages user profile state including tokens

### Screens

- **RewardsHubScreen**: Central hub for all token-related activities
- **DailyRewardsScreen**: Daily login rewards and small challenges
- **ChallengesScreen**: More substantial challenges and quests
- **TokenShopScreen**: Shop for spending tokens

### Configuration

Token economy rules are defined in `gamification.json`:
- **Action Rewards**: Token and XP rewards for different actions
- **Level Requirements**: XP thresholds for each level
- **Daily Limits**: Limits on how many tokens can be earned from specific actions
- **Token Expiration**: Rules for token expiration

## Token Earning Mechanisms

Users can earn tokens through various mechanisms:

1. **Daily Login**: Small reward for logging in each day
2. **Streaks**: Bonus rewards for consecutive days of activity
3. **Challenges**: Completing specific tasks and challenges
4. **Social Interactions**: Engaging with content and other users
5. **Bookings**: Completing bookings with stylists
6. **Referrals**: Inviting friends to join ZinApp
7. **Profile Completion**: Filling out profile information
8. **Achievements**: Unlocking achievements and milestones

## Token Spending Options

Users can spend tokens on:

1. **Profile Customizations**: Frames, backgrounds, animations
2. **Premium Features**: Priority booking, advanced analytics
3. **Style Collections**: Exclusive hairstyle ideas and trends
4. **Stylist Tips**: Sending tokens to stylists as appreciation
5. **Feature Unlocks**: Access to premium app features

## Future Enhancements

1. **Token Analytics**: Detailed analytics on token earning and spending
2. **Seasonal Events**: Special events with unique token rewards
3. **Token Gifting**: Ability to gift tokens to friends
4. **Token Subscriptions**: Subscription-based token rewards
5. **Community Challenges**: Group challenges with shared rewards

## Integration with Other Features

The token economy integrates with several other app features:

- **User Profile**: Displays token balance and achievements
- **Booking System**: Awards tokens for completed bookings
- **Social Feed**: Rewards social interactions with tokens
- **Stylist Discovery**: Allows token tips for stylists
- **Achievements**: Unlocks achievements that award tokens

## Technical Considerations

1. **Token Security**: Measures to prevent token exploitation
2. **Daily Limits**: Caps on how many tokens can be earned from specific actions
3. **Token Expiration**: Tokens expire after 6 months of inactivity
4. **Transaction Logging**: All token movements are logged for transparency
5. **Offline Support**: Token transactions are queued when offline
