# ZinApp Known Issues

This file tracks known bugs, missing logic, or temporary hacks to be revisited.

## Active Issues
- "Cancel Booking" button doesn't trigger modal
- Image loader in gallery grid does not fallback gracefully
- Hardcoded mock stylist location — needs dynamic in later phase
- Styling overlap in Bsse7a confetti animation (rare flicker)
- **Deferred NPM Vulnerabilities (2025-04-08):** `npm audit` reported 11 vulnerabilities (9 high, 2 low) in dependencies (`ip`, `semver`, `send`). Decision made to defer fixing during the prototype phase to avoid potential breaking changes from `npm audit fix --force`. To be revisited before any wider distribution.
- **Unresolved Runtime Error - User Fetch TypeError (2025-04-09):** The `TypeError` persists when fetching user data in `services/api.ts -> getUserById`. Enhanced logging confirms the error occurs within the `try` block, likely during the `fetch` call or `response.text()` processing, even when the mock server is running and the user ID exists. Further investigation needed, potentially related to fetch polyfills or environment issues.
- **[Potentially Resolved] Build Error - `twrnc` Module Resolution (2025-04-09):** The previous Metro error resolving `twrnc` appears resolved after aggressive cache clearing and project cleanup.
- **[RESOLVED] Runtime Error - `"large"` String Conversion (2025-04-09):** Resolved by updating `react-native-screens` package to `~4.4.0` (recommended for Expo SDK 52).

## Resolved History
- (2025-04-07) Issue with QR scan delay fixed with setTimeout
- (2025-04-06) Bsse7a rating not showing — resolved with component key reset
