# ZinApp V2 Mock API Schema & Strategy

## 1. Overview
   - Purpose of the mock data system for V2 development and testing, particularly focusing on gamification and social features.
   - Strategy: Utilizing local JSON files stored within the Flutter project structure, likely under `/lib/mock_data/` (to be confirmed once Flutter project is initialized). This allows for easy modification and development without requiring a running backend.

## 2. Data Models (JSON Structure)
   - **`users.json`**:
     ```json
     [
       {
         "userId": "user123",
         "username": "Hassan",
         "profilePictureUrl": "path/to/hassan.png",
         "xp": 150,
         "zinTokens": 50,
         "level": "Silver",
         "followingStylists": ["stylist456"],
         "followingUsers": ["user789"],
         "bookingHistory": ["bookingABC", "bookingDEF"]
       }
       // ... more users
     ]
     ```
   - **`stylists.json`**:
     ```json
     [
       {
         "stylistId": "stylist456",
         "name": "Sarah J.",
         "profilePictureUrl": "path/to/sarah.png",
         "rating": 4.8,
         "specialties": ["Fades", "Braids"],
         "servicesOffered": ["service01", "service02"],
         "availability": { "Monday": "9am-5pm", "...": "..." },
         "isAvailableNow": true,
         "location": { "latitude": 34.0, "longitude": -6.8 }
       }
       // ... more stylists
     ]
     ```
   - **`services.json`**:
     ```json
     [
       {
         "serviceId": "service01",
         "name": "Premium Fade",
         "description": "Detailed fade with sharp lines.",
         "price": 25.00,
         "currency": "ZIN", // Or local currency if ZIN is separate
         "durationMinutes": 45,
         "xpReward": 20
       }
       // ... more services
     ]
     ```
   - **`bookings.json`**:
     ```json
     [
       {
         "bookingId": "bookingABC",
         "userId": "user123",
         "stylistId": "stylist456",
         "serviceId": "service01",
         "bookingTime": "2025-04-11T14:00:00Z",
         "status": "confirmed", // e.g., pending, confirmed, completed, cancelled
         "pricePaid": 25.00,
         "currency": "ZIN"
       }
       // ... more bookings
     ]
     ```
   - **`ratings.json`**:
     ```json
     [
       {
         "ratingId": "ratingXYZ",
         "bookingId": "bookingABC",
         "userId": "user123",
         "stylistId": "stylist456",
         "score": 5, // e.g., 1-5 stars
         "comment": "Amazing fade, Sarah is the best!",
         "timestamp": "2025-04-11T15:00:00Z",
         "xpReward": 5
       }
       // ... more ratings
     ]
     ```
   - **`gamification.json`**:
     ```json
     {
       "levels": [
         { "name": "Bronze", "minXP": 0 },
         { "name": "Silver", "minXP": 100 },
         { "name": "Gold", "minXP": 500 },
         { "name": "Prime", "minXP": 1500 },
         { "name": "Legend", "minXP": 5000 }
       ],
       "actionRewards": {
         "rateExperience": { "xp": 5 },
         "postPhoto": { "xp": 10, "zinTokens": 5 },
         "completeBooking": { "xp": 20 }, // Example, could vary by service
         "commentOnPost": { "xp": 3 },
         "tagPhoto": { "xp": 30, "zinTokens": 10 } // Example from memo
       }
     }
     ```
   - **`posts.json`** (For Social Engine):
     ```json
      [
        {
          "postId": "post001",
          "userId": "user123", // or stylistId
          "type": "check-in", // check-in, showcase, shared-style, review
          "imageUrl": "path/to/image.png", // Optional
          "caption": "Just got a fresh cut!",
          "timestamp": "2025-04-10T16:00:00Z",
          "likes": ["user789", "stylist456"],
          "comments": [
            { "commentId": "cmt01", "userId": "user789", "text": "Looks great!", "timestamp": "..." }
          ],
          "relatedBookingId": "bookingABC" // Optional link
        }
        // ... more posts
      ]
     ```

## 3. Gamification & Token Logic Simulation
   - **Triggering Actions:** UI interactions (e.g., tapping 'Rate', submitting a post) will call functions in a mock service utility.
   - **Mock Service Utility:** This utility (e.g., `MockDataService.dart`) will read the relevant JSON file (e.g., `gamification.json` to find rewards, `users.json` to find the user).
   - **Updating Data:** The utility will calculate new XP/token values and update the user's record in the `users.json` file (simulating a write operation). It will also create new records where necessary (e.g., add an entry to `ratings.json` or `posts.json`).
   - **UI Updates:** The UI will re-read the updated data (or listen to changes via a state management solution like Provider or Riverpod) to display the new XP, token balance, level, or new posts/ratings.
   - **Example Flow (Rating):**
     1. User completes booking `bookingABC`.
     2. User taps 'Rate' button on the rating screen for `bookingABC`.
     3. UI calls `MockDataService.submitRating(userId: 'user123', bookingId: 'bookingABC', score: 5, comment: '...')`.
     4. `MockDataService` reads `gamification.json`, finds `rateExperience` reward (5 XP).
     5. `MockDataService` reads `users.json`, finds `user123`.
     6. `MockDataService` updates `user123`'s XP (e.g., 150 + 5 = 155).
     7. `MockDataService` checks if new XP crosses a level threshold in `gamification.json`. Updates level if needed.
     8. `MockDataService` writes the updated `user123` record back to `users.json`.
     9. `MockDataService` creates a new entry in `ratings.json`.
     10. UI listening to user data updates and displays the new XP (155) and potentially a level-up notification.

## 4. File Location & Access
   - All mock JSON files will reside in `/lib/mock_data/` within the Flutter project.
   - A dedicated Flutter service (e.g., `MockDataService.dart`) will encapsulate all logic for reading and simulating writes to these JSON files using standard Dart file I/O and JSON decoding/encoding libraries. This service will provide methods like `getUser(userId)`, `updateUserXP(userId, xpToAdd)`, `getStylists()`, `createBooking()`, etc.
