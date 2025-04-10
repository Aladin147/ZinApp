# ZinApp V2 Application Lifecycle Handling

## 1. App States (Flutter Lifecycle)
   - **Definition of States:** Flutter's `AppLifecycleState` enum will be used:
     - `resumed`: The application is visible and responding to user input. (Foreground active)
     - `inactive`: The application is in an inactive state and is not receiving user input. (Foreground inactive, e.g., interrupted by a phone call, switching apps on iOS)
     - `paused`: The application is not currently visible to the user, not responding to user input, and running in the background. (Background)
     - `detached`: The application is still hosted on a Flutter engine but is detached from any host views. (Engine running without UI, e.g., during termination)
   - **Expected Transitions:** Standard transitions between these states as managed by the OS. We will use `WidgetsBindingObserver` to listen for and react to these changes.

## 2. Startup Behavior (Cold Boot)
   - **Splash Screen:** Display a branded splash screen (using `flutter_native_splash` or similar) immediately upon launch. Target duration: 2.5-3s (as per V2 Brand Identity).
   - **Initialization Sequence:**
     - Initialize essential services (Logging, Configuration, MockDataService).
     - Load necessary configuration/settings.
     - Check authentication status (validate stored token).
   - **Authentication Check:** Attempt to validate any stored authentication token (e.g., JWT) using `flutter_secure_storage`.
   - **Initial Data Fetching:** Based on auth status:
     - **Authenticated:** Fetch essential user data (profile, XP/tokens), initial FYP content, nearby stylists (if applicable). Show loading indicators on relevant UI parts.
     - **Unauthenticated:** Navigate to Landing/Login screen.
   - **Navigation:** Navigate to the appropriate initial screen (e.g., Home/FYP if authenticated, Landing/Login if not).

## 3. Resuming from Background (`paused` -> `resumed`)
   - **State Restoration:** Flutter generally handles widget state restoration well. Ensure critical UI states (e.g., scroll position, form inputs) are preserved where necessary using appropriate state management.
   - **Data Refresh Conditions:**
     - **Time-based:** Refresh key data (e.g., FYP, stylist availability) if the app has been paused for longer than a defined threshold (e.g., 5 minutes).
     - **Context-based:** Refresh data relevant to the currently visible screen.
     - **User-initiated:** Always allow manual refresh (e.g., pull-to-refresh).
   - **Handling Background Tasks:** If background tasks (e.g., location tracking for live booking - future feature) are implemented, ensure they are properly managed and synchronized upon resume.

## 4. Authentication Token Management
   - **Storage:** Use `flutter_secure_storage` package for securely storing authentication tokens (e.g., JWT access token, refresh token).
   - **Validation:**
     - **On Startup:** Validate stored token's expiry and signature (if possible locally, or via a quick API check).
     - **Before API Calls:** Implement logic (e.g., in an HTTP interceptor) to check token expiry before making protected API calls.
   - **Token Refresh Strategy:**
     - If using access/refresh tokens: When an API call returns an "unauthorized" (401) error due to an expired access token, use the stored refresh token to request a new access token from the authentication endpoint. Securely store the new tokens.
     - If the refresh token is also invalid/expired, clear stored tokens and navigate to the login screen.
   - **Handling Invalid/Expired Tokens:**
     - Clear tokens from `flutter_secure_storage`.
     - Reset application state (user data, etc.).
     - Force navigation to the Login screen.
     - Provide clear user feedback (e.g., "Session expired, please log in again").

## 5. Data Refresh & Caching
   - **User-Initiated Refresh:** Implement pull-to-refresh on scrollable views (FYP, stylist lists, booking history).
   - **Automatic Background Refresh:** (Future consideration) Could implement periodic background fetches for critical data if needed, respecting battery life.
   - **Caching:**
     - **Strategy:** Cache frequently accessed, less volatile data (e.g., user profile, stylist details, service list) locally to improve performance and provide basic offline support.
     - **Mechanism:** Use a simple caching solution (e.g., storing JSON in local files with timestamps, using packages like `hive` or `shared_preferences` for simpler data) or a more robust database like `sqflite` if complex offline capabilities are needed later.
     - **Staleness:** Implement a cache invalidation strategy (e.g., time-based expiry, refresh on specific triggers).

## 6. Crash Handling & Recovery
   - **Error Reporting:** Integrate `firebase_crashlytics` or `sentry_flutter` to automatically report crashes and unhandled exceptions. Include relevant context (user ID, device info, navigation stack).
   - **Graceful Degradation:** For non-critical errors (e.g., failed image load, failed fetch for secondary content), display placeholder UI or informative messages instead of crashing. Use `ErrorBoundary` widgets where appropriate.
   - **Recovery:** On next launch after a crash, check if recovery steps are needed (e.g., clearing corrupted cache - rare).
   - **User Messaging:** Provide user-friendly messages for critical errors that prevent app usage, guiding them to retry or contact support if necessary.
