# ZinApp Known Issues

This file tracks known bugs, missing logic, or temporary hacks to be revisited.

## Active Issues
- "Cancel Booking" button doesn't trigger modal
- Image loader in gallery grid does not fallback gracefully
- Hardcoded mock stylist location — needs dynamic in later phase
- Styling overlap in Bsse7a confetti animation (rare flicker)
- **Deferred NPM Vulnerabilities (2025-04-08):** `npm audit` reported 11 vulnerabilities (9 high, 2 low) in dependencies (`ip`, `semver`, `send`). Decision made to defer fixing during the prototype phase to avoid potential breaking changes from `npm audit fix --force`. To be revisited before any wider distribution.

## Resolved History
- (2025-04-07) Issue with QR scan delay fixed with setTimeout
- (2025-04-06) Bsse7a rating not showing — resolved with component key reset
