# ZinApp - Approaches That Did Not Work

This document tracks solutions and approaches that were attempted but did not resolve the issues. This helps prevent wasting time on approaches that have already been proven ineffective.

## API Connection Issues

### 1. Multi-URL Fallback System (2025-04-10)

**What was tried:**
- Created a list of potential API URLs to try (`localhost:3001`, `127.0.0.1:3001`, etc.)
- Implemented a `fetchWithFallbackUrls` helper function that tries each URL in sequence
- Added shorter timeouts (3 seconds) for faster fallback between URLs
- Added proper AbortController handling for all fetch calls

**Why it didn't work:**
- The app still encountered the same TypeError in getUserById API call
- Port conflicts when running multiple servers in office environment remained unresolved
- The error persisted despite trying multiple localhost variants

**Error observed:**
```
[getUserById] Caught TypeError specifically.
[getUserById] Error fetching or processing user with ID 10: TypeError: Network request failed
```

### 2. API Base URL Updates (2025-04-10)

**What was tried:**
- Changed the API_BASE_URL from a specific IP address (192.168.100.24:3001) to localhost
- Added fallback mechanism for all API endpoints
- Added centralized FALLBACK_DATA object with mock data for all entity types

**Why it didn't work:**
- The app still encountered the same TypeError in getUserById API call
- The error persisted despite changing the API base URL

## Lessons Learned

1. **Network Configuration Complexity:**
   - Office environments with multiple servers running simultaneously can create complex networking issues that aren't easily solved by just changing URLs or adding fallbacks.

2. **Port Conflicts:**
   - When Expo asks to use a different port (e.g., 8084 instead of 8081), this doesn't necessarily resolve API connection issues if the API server is running on a separate port.

3. **Timeout Adjustments:**
   - Adjusting timeouts doesn't help if the fundamental connection issue remains unresolved.

## QR Scanner Component Issues

### 1. Expo Camera Integration (2025-04-13)

**What was tried:**
- Installed expo-camera and expo-barcode-scanner packages
- Created a QRScanner component that used the Camera component from expo-camera
- Added camera permissions to app.json
- Implemented proper permission handling and UI for the scanner

**Why it didn't work:**
- Encountered "Cannot find native module 'ExponentCamera'" error when trying to use the Camera component
- The error persisted despite reinstalling packages and trying different versions
- Attempted to use BarCodeScanner directly instead of Camera, but still encountered issues

**Error observed:**
```
Uncaught Error: Cannot find native module 'ExponentCamera'
```

## Potential Alternative Approaches

1. **Direct Hardcoding:**
   - Consider hardcoding critical data directly in the app for demo purposes, bypassing API calls entirely.

2. **Mock Service Worker:**
   - Implement a service worker to intercept and mock API requests at the network level.

3. **Environment-Specific Configuration:**
   - Create different configuration files for different environments (office, home, demo).

4. **Offline-First Approach:**
   - Design the app to work primarily with local data and only sync with the API when available.

5. **QR Scanner Alternatives:**
   - Try using Expo's managed workflow with prebuild step for QR scanning
   - Consider using a different QR scanning library
   - Implement QR scanning when the app is more stable and core functionality is complete
