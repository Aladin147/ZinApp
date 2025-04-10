# ZinApp V2 Social Engine & FYP Specification

## 🔄 Alias Note
This file covers topics referred to as `FYP_SYSTEM.md` in earlier documentation planning.
---

## 1. Vision & Goals
   - **Vision:** To transform ZinApp from a utility booking app into an engaging community platform centered around style, stylists, and user experiences. The social engine will foster discovery, interaction, and loyalty.
   - **Goals:**
     - Increase user engagement and time spent in-app.
     - Facilitate discovery of stylists and trending styles.
     - Provide a platform for users and stylists to share their work and experiences.
     - Integrate seamlessly with the gamification system (XP/token rewards for social actions).
     - Enhance the perceived value of the ZinApp ecosystem.

## 2. Core Concepts
   - **Content Types ("Posts"):**
     - **User Check-in:** User shares a photo/video after a service, potentially tagging the stylist and service.
     - **Stylist Showcase:** Stylist posts examples of their work, available slots, or promotions.
     - **Shared Style:** User posts a style inspiration photo or asks for advice.
     - **Review/Rating Post:** Automatically generated (or user-triggered) post when a high rating is given.
     - **System Announcement:** App updates, promotions, featured stylists/content.
   - **Social Graph (Mocked):**
     - **Explicit Follows:** Users can follow specific Stylists and other Users. Represented in `users.json` (e.g., `followingStylists: ["id1"], followingUsers: ["id2"]`).
     - **Implicit Connections:** Based on booking history (users who booked the same stylist). Not explicitly modeled in the graph initially but can be used for recommendations.
   - **Interactions:**
     - **Like:** Simple engagement metric. Stored within the post object (e.g., `likes: ["userId1", "userId2"]`).
     - **Comment:** Text-based interaction. Stored within the post object (e.g., `comments: [{commentId: "...", userId: "...", text: "...", timestamp: "..."}]`).
     - **Share:** (Future) Share post within the app or externally.
     - **Save/Bookmark:** User saves a post for later reference. Stored per user.
     - **Tagging:** Users can tag Stylists in their posts.

## 3. FYP (For You Page) Mechanics
   - **Content Sources:**
     - Posts from followed Users and Stylists.
     - Popular posts within the user's network or locality (based on likes/comments).
     - Recommended Stylists based on booking history or viewed profiles.
     - Potentially featured or sponsored content (clearly marked).
   - **Initial Algorithm Idea (V2 Mock Implementation):**
     - Simple chronological feed mixing posts from followed entities.
     - Basic "popularity" boost: Posts with more likes/comments might appear slightly higher or more frequently (simulated by simple sorting).
     - No complex personalization in the initial mock phase. Focus is on displaying different content types.
   - **Ranking Factors (Conceptual - For Future Iteration):**
     - Recency (most important initially).
     - Engagement Score (likes, comments, saves).
     - User's past interactions (styles liked, stylists booked).
     - Follow graph proximity.
     - Location relevance.
     - Content type preference.

## 4. User Interaction Loops
   - **Viewing & Interacting:** User scrolls FYP -> Taps Like/Comment/Save -> Interaction data is updated in `posts.json` (mocked).
   - **Posting:** User creates post -> Post added to `posts.json` -> Post appears in followers' FYP.
   - **Feedback -> Gamification:** Liking, commenting, posting triggers calls to `MockDataService` -> Updates user XP/tokens in `users.json` based on rules in `gamification.json`.
   - **Notifications (Conceptual):**
     - "User X liked your post."
     - "Stylist Y commented on your post."
     - "User Z started following you."
     - "New post from Stylist X."

## 5. Moderation & Content Guidelines (Placeholder)
   - To be defined. Initial focus is on positive interactions.
   - Basic filtering for inappropriate language might be considered even in mock phase.
   - Reporting mechanism (conceptual for now).

## 6. Mock Data Requirements
   - **`posts.json`:** Central store for all post content, including user/stylist ID, type, media URLs, captions, timestamps, likes array, comments array. (See `MOCK_API_SCHEMA.md` for structure).
   - **`users.json`:** Needs `followingStylists` and `followingUsers` arrays.
   - **`stylists.json`:** May need a list of follower user IDs if required for stylist-specific analytics (future).
   - **`gamification.json`:** Needs entries for rewards associated with social actions (liking, commenting, posting).
