
# ZinApp UX Feature Flow & Screen Architecture

## 🧭 Overview
This document defines the complete user-facing experience of ZinApp. It outlines each screen in the mobile app, the state logic between them, their visual priority, and any conditional flow or UX variants. This feature flow is architected to simulate a real operational experience using mocked data, while remaining production-ready with minor backend substitutions.

This is a **critical foundation** for:
- UI/UX design and review
- Component mapping and reuse
- Event logging, analytics planning
- Future testing automation

---

## 🔄 Full User Flow (Unauthenticated Guest)

### 1. **LandingScreen**
- Hero greeting
- App icon / logo
- Animation or splash loop (Lottie or timed SVG)
- CTA: "Let’s Book"
- No sign-in required
- Deep link entry support (for QR demo backdoor)

➡️ Routes to: **ServiceSelectScreen**

---

### 2. **ServiceSelectScreen**
- Title: "What do you need today?"
- Options: `Haircut`, `Beard`, `Braids`, `Full Service`
- Touchable icons (interactive, bounce-on-tap)
- Use category tokens for filtered stylist discovery

➡️ Routes to: **StylistListScreen**

---

### 3. **StylistListScreen**
- Location-aware stylist feed (mocked to nearest 5 km)
- Cards show:
  - Avatar (rounded)
  - Name
  - Ratings ⭐ (1 decimal precision)
  - Distance (km, static)
  - Availability window (mocked slot)
  - Promo tag (optional)
- Filtering: service type, rating, distance

➡️ Select stylist → **BarberProfileScreen**
➡️ Skip to: BookingScreen (if fast-book mode enabled)

---

### 4. **BarberProfileScreen**
- Profile photo + Name
- Badge: "Verified Stylist" (icon + blue accent)
- About section (bio, years of experience)
- Gallery grid (6–10 images, touch to expand)
- Service list with pricing (e.g. Fade – 50 MAD)
- QR Button: "Generate QR Flyer"
- CTA: "Book this stylist"

➡️ Routes to: **BookingScreen**

---

### 5. **BookingScreen**
- Service type pre-filled
- Date/time picker
- Estimated duration
- Payment info:
  - Guest: "Add card to continue"
  - Verified: "Cash after service available"
- Confirm button (orange)

➡️ Routes to: **LiveTrackScreen**

---

### 6. **LiveTrackScreen**
- Map view
- Stylist avatar on route
- ETA countdown (mocked)
- Route line (animated path in coral)
- Contact buttons: Call / Message (faked)
- Cancel Booking (confirmation required)

➡️ Routes to: **Bsse7aScreen** (auto after timer or "Simulate Arrival")

---

### 7. **Bsse7aScreen**
- Confetti animation (Lottie)
- Avatar + service summary
- Tip buttons: +5 / +10 / Custom
- Rate experience (5-star component)
- CTA: "Rebook", "Add to Favorites", "Share Stylist QR"

➡️ Routes to: ServiceSelectScreen (flow restart)
➡️ OR idle into home (for testing cycle)

---

## 🧭 QR Entry Flow (Trust Loop Simulation)

### QR Entry
- Button: Scan QR → Opens mock camera
- After 2 sec → Redirect to: **BarberProfileScreen** (static barber demo)
- Context flag: `qrSource = true`

### Use Case:
- Printed flyers in salon → client scans → sees portfolio → books
- Stylists share QR link with clients to reduce acquisition friction

---

## 🧠 Conditional Logic & Mock Simulation Points

| Screen            | Condition                    | Action                             |
|------------------|------------------------------|------------------------------------|
| BookingScreen     | Guest user                   | Show card input                    |
| BookingScreen     | Verified user                | Show "Pay later" toggle            |
| StylistList       | Empty filter result          | Show "No stylists nearby" message  |
| LiveTrack         | Arrival time expired         | Auto-route to Bsse7a               |
| Bsse7a            | Tip skipped                  | Log feedback, proceed silently     |

All screens should be conditionally mockable via a debug toggle in dev mode.

---

## 📦 Reusable Components (Planned)

- `<AvatarBadge>` – with verified, rating overlay
- `<ServiceIconButton>` – for hair/beard/braid etc.
- `<StylishCard>` – used in list and favorites
- `<MapTracker>` – used in live route and ETA
- `<RatingStars>` – shared between Bsse7a and profile

---

## 🔚 Final Notes
- All screens should function offline, loading from local state/mock
- State persistence not required for demo, but navigational memory improves flow
- Focus on realism of transitions, data density, button feedback (Lottie bounce, shadow tap, shimmer loads)

This flow supports high-fidelity walkthroughs in Expo Go or TestFlight, and will scale directly into production builds with real backend integrations.
