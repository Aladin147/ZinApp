# ZinApp V2 Gamification System

## 1. Vision & Goals
   - **Vision:** To integrate game mechanics seamlessly into the ZinApp experience, making user actions more engaging, rewarding loyalty, and fostering a sense of progress and community.
   - **Goals:**
     - Increase user retention and frequency of use.
     - Encourage specific user behaviors (e.g., booking, rating, sharing content).
     - Create a more delightful and memorable user experience.
     - Provide tangible rewards (Zin Tokens) and status indicators (XP Levels).
     - Differentiate ZinApp from standard booking platforms.

## 2. Core Mechanics
   - **Experience Points (XP):** Awarded for completing various actions within the app. Accumulating XP leads to leveling up.
   - **Levels:** Tiers representing user engagement and progress (Bronze, Silver, Gold, Prime, Legend). Levels might unlock perks or visual badges in the future.
   - **Zin Tokens (ZIN):** An in-app currency awarded for specific high-value actions or achievements. Potentially redeemable for discounts or exclusive features later (scope TBD). Represented visually by the primary highlight color (`#D2FF4D`).

## 3. XP & Token Rewards System
   - **Source of Truth:** The `gamification.json` file within the mock data defines the XP/Token rewards for specific actions and the XP thresholds for each level. (See `MOCK_API_SCHEMA.md`).
   - **Actions Triggering Rewards (Examples from Memo & Schema):**
     - Rate Experience: +5 XP
     - Post Photo/Check-in: +10 XP, +5 ZIN
     - Tag Photo (Stylist/Service): +30 XP, +10 ZIN
     - Comment on Post: +3 XP
     - Complete Booking: +20 XP (Base value, could vary by service cost/type)
     - Refer Friend (Future): Significant XP/ZIN bonus.
     - Daily Login Streak (Future): Small XP bonus.
     - Complete Profile (Future): XP bonus.
   - **Implementation:** A dedicated `GamificationService` (`lib/services/gamification_service.dart`) will handle the logic. When an action occurs (e.g., booking completed, rating submitted), other services (like `ApiService` or feature-specific logic) will call methods on `GamificationService` (e.g., `awardXPForAction(userId, actionType)`). This service will consult `gamification.json` (via `MockApiService` initially) and update the user's profile data (XP, Tokens, Level).

## 4. Levels & Progression
   - **Levels (Defined in `gamification.json`):**
     - Bronze: 0 XP
     - Silver: 100 XP
     - Gold: 500 XP
     - Prime: 1500 XP
     - Legend: 5000 XP
   - **Leveling Up:** When a user's accumulated XP crosses the threshold for the next level, the `GamificationService` updates their level in the user data (`users.json`).
   - **UI Feedback:**
     - Display current XP and progress towards the next level (e.g., progress bar).
     - Show current Level name/badge prominently on the user profile.
     - Trigger a celebratory animation/notification upon leveling up.

## 5. Zin Token (ZIN) Economy (Conceptual - V2 Mock)
   - **Earning:** Awarded for specific actions as defined in `gamification.json`.
   - **Balance:** User's ZIN token balance stored in `users.json`.
   - **Display:** Show ZIN balance clearly, often near user profile info, always using the highlight color (`#D2FF4D`) and potentially a token icon.
   - **Spending/Redemption (Future Scope):**
     - Potential uses: Discounts on bookings, exclusive profile customizations, entry into contests.
     - **V2 Mock:** No actual spending mechanism implemented initially. Focus is on earning and display.

## 6. UI Integration
   - **Profile Screen:** Display User Level, XP progress bar, ZIN token balance.
   - **Action Feedback:** Show XP/ZIN earned immediately after a rewarding action (e.g., via toast, snackbar, or animation integrated into confirmation screens like "Bsse7a!").
   - **Gamification Hub (Future):** A dedicated section might show leaderboards, achievements, or challenges.
   - **Stylist Profiles:** Could potentially display stylist-specific levels or achievements in the future.

## 7. Mock Implementation Details
   - **`GamificationService`:** Contains methods like `calculateXP(actionType)`, `calculateTokens(actionType)`, `getLevelForXP(xp)`, `updateUserGamificationStats(userId, xpGained, tokensGained)`.
   - **`MockApiService`:** Implements `updateUserXP` (and potentially `updateUserTokens`) methods which call the `GamificationService` logic and simulate updating `users.json`.
   - **Data Flow:** UI Action -> Calls `ApiService` method -> `ApiService` (Mock) calls `GamificationService` -> `GamificationService` calculates rewards -> `ApiService` (Mock) updates user data in memory/JSON -> UI updates via state management.

## 8. Future Considerations
   - Leaderboards (by XP, location, etc.).
   - Badges/Achievements for specific milestones.
   - Challenges (e.g., "Try 3 different services this month").
   - Token redemption mechanisms.
   - Social Gamification (e.g., rewards for high engagement on posts).
   - Anti-cheat mechanisms (for real implementation).
