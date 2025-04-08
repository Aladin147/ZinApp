
# ZinApp Tech Stack & Architecture – Pre-Demo Build Strategy

## 🧭 Purpose
This document outlines the technical foundation and architectural rationale behind the ZinApp prototype build. It is structured to support rapid development for a high-fidelity mobile demo while ensuring long-term scalability and clean migration paths for future production environments.

---

## 📱 Frontend: Mobile Application

### Framework: **React Native (via Expo)**
- **Why:** Cross-platform support (iOS/Android) with native performance.
- **Expo Benefits:** Fast prototyping, OTA updates, no native build config needed during MVP.
- **Consideration:** If scaling to native hardware integration (e.g. Bluetooth tools), ejecting from Expo may be necessary later.

### UI Styling: **NativeWind**
- TailwindCSS-like utility-first styling inside RN.
- Ensures **theme consistency**, fast iteration, and responsive spacing.
- Matches ZinApp’s visual guideline system (coral/sand/blue/slate, 4pt grid).

### Navigation: **React Navigation**
- Stack + Tab navigation system.
- Deep link friendly (enables future QR flow).
- Smooth screen transitions with minimal config.

### Animation: **Reanimated 2 + Lottie**
- Reanimated: GPU-based, buttery transitions.
- Lottie: Rich animations (e.g. “Bsse7a!” confetti, stylist entrance). 
- Used for CTA feedback, page transitions, and emotional payoff.

### List Handling: **FlashList (Shopify)**
- High-performance replacement for FlatList.
- Optimized for long stylist/gallery lists with image-heavy cards.
- Reduces scroll jank on older devices.

---

## 🔧 Backend: Local Mock Server (Pre-Demo)

### Reasoning:
- Avoids cloud costs, auth bugs, network failures.
- Controlled environment = frictionless demo.
- Can run on a local office machine, accessible via LAN.

### Option 1: **json-server**
- Serves JSON files as REST endpoints.
- Fastest setup, zero logic required.
- Ideal for serving `/stylists`, `/users`, `/bookings`, `/services`, etc.

### Option 2 (Upgrade Path): **Express.js**
- Enables conditional routing, mock auth gates.
- Can simulate API success/fail, loading delays, real-time ETA updates.
- Future-upgradable to connect to Postgres/Supabase.

### Directory Example:
```
/mock-api
├── db
│   ├── stylists.json
│   ├── users.json
│   └── bookings.json
├── routes
│   └── stylists.js (optional logic)
└── server.js
```

---

## 🗂 Directory Structure (Planned)
```
/zineapp
├── /assets
├── /components
├── /constants
├── /mock
├── /screens
│   ├── LandingScreen.tsx
│   ├── ServiceSelect.tsx
│   ├── StylistList.tsx
│   ├── BookingScreen.tsx
│   ├── LiveTrackScreen.tsx
│   ├── Bsse7aScreen.tsx
│   ├── BarberProfile.tsx
│   └── QRScanner.tsx
├── /theme
│   └── tailwind.config.js
├── App.tsx
└── README.md
```

---

## 🧠 Design-to-Dev Consistency

### UI Tokens:
- Follows 4pt spacing grid
- Color tokens: `coral`, `sand`, `slate`, `blueAccent`
- Button height: 48px (standard), 56px (hero)
- Radius: 12px (buttons), 16px (cards), 20px (avatars)

### Animation Patterns:
| Element          | Animation               | Tool      |
|------------------|--------------------------|-----------|
| CTA Tap          | Bounce in, color pulse   | Reanimated|
| Screen Enter     | Slide fade (200–350ms)   | Reanimated|
| Map Marker Pulse | Scale loop               | Lottie    |
| Bsse7a! Screen   | Confetti, avatar shine   | Lottie    |

---

## 🔒 Security / UX Access Strategy

| State             | UX Behavior                             |
|------------------|------------------------------------------|
| Guest User        | Browse app, no sign-in required          |
| First Booking     | Must input card to proceed               |
| Verified User     | Can pay cash after service (post-2 uses) |
| Stylist Account   | Full auth required (future)              |

No user auth needed in demo. State is controlled manually via UI toggles or mock data.

---

## 🌐 Future-Proofing & Migration Plan

### When Going Live:
- Swap mock server → real backend (e.g., Supabase)
- Add authentication (Supabase/Auth0/Firebase)
- Migrate card logic to Stripe Checkout + Webhooks
- Upgrade map logic to Mapbox or Google Maps API
- Move image hosting to S3 or Supabase storage

### Web Platform (Phase 2):
- Use **Next.js** with Tailwind + Supabase
- Share logic with React Native using monorepo (Turborepo or Nx)
- Stylists/admin dashboard may launch separately

---

## 🧪 Testing Approach
- Manual only for demo
- E2E: optional Detox integration post-funding
- Component-level: Storybook setup deferred until post-demo

---

## 📦 Deployment Plan
- Expo Go via LAN sharing (internal testing)
- Optional: EAS Build for internal TestFlight deployment
- API served via localhost or local IP

---

## 🧤 Final Thoughts
This stack is designed to feel like a venture-backed app while being executable by one person with limited resources.

- Zero cloud dependency for demo = fast recovery & control
- Realistic UI + mocked logic = confident investor presentation
- Expo + Tailwind + Lottie + json-server = top-tier demo experience without tech debt

The technical runway is built. Development begins when strategy is airtight.
