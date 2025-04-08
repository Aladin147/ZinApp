# ZinApp Known Issues

This file tracks known bugs, missing logic, or temporary hacks to be revisited.

## Active Issues
- "Cancel Booking" button doesn't trigger modal
- Image loader in gallery grid does not fallback gracefully
- Hardcoded mock stylist location — needs dynamic in later phase
- Styling overlap in Bsse7a confetti animation (rare flicker)
- **Deferred NPM Vulnerabilities (2025-04-08):** `npm audit` reported 11 vulnerabilities (9 high, 2 low) in dependencies (`ip`, `semver`, `send`). Decision made to defer fixing during the prototype phase to avoid potential breaking changes from `npm audit fix --force`. To be revisited before any wider distribution.
- **Unresolved Build Error - `twrnc` Module Resolution (2025-04-09):** After migrating from NativeWind to `twrnc` to resolve build issues with Expo SDK 52, a persistent Metro error occurs: `Unable to resolve module ../twrnc from ...\screens\LandingScreen.tsx`. This error incorrectly references a relative path despite the code using a direct library import (`import tw from 'twrnc';`) and extensive cache clearing attempts (manual deletion of `.expo`, `.metro-cache`, `node_modules`, etc.). This suggests a deep Metro caching issue or a fundamental incompatibility between `twrnc` (v4.6.1) and the Expo 52/RN 0.75.3 environment. Development is currently blocked pending external review or alternative solutions. See `docs/journal.md` for detailed troubleshooting steps.

## Resolved History
- (2025-04-07) Issue with QR scan delay fixed with setTimeout
- (2025-04-06) Bsse7a rating not showing — resolved with component key reset
