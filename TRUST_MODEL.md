
# ZinApp Trust & Access Model (Guest → Verified Flow)

## 🧭 Overview
ZinApp’s access and trust system is engineered to offer **frictionless entry for new users** while progressively unlocking more convenient features based on usage behavior. The model supports:

- No-login discovery and bookings
- Gradual verification tied to trust behaviors
- Conditional UX responses based on state
- Payment flexibility based on account standing

This framework mimics modern apps like Uber, Glovo, and Airbnb while optimizing for the grooming space where word-of-mouth and familiarity carry heavy influence.

---

## 👤 User States (Trust Tiers)

### 1. **Guest** (Default / First-Time User)
- No account required
- Can browse stylists, services, galleries
- Must enter card info to confirm booking
- Cannot access:
  - Cash payments
  - Favorites list
  - Rebooking shortcut

### 2. **Verified** (After Successful Booking + Feedback)
- Card used and service completed
- Optional review left
- Unlocked perks:
  - Bookings without card (cash toggle available)
  - Favoriting stylists
  - Rebooking from history
  - Visible "Verified Client" badge in future social features

### 3. **Trusted Stylist** (Future Phase)
- Internal or manually flagged accounts
- Extra UI trust layer (e.g., trusted by X clients)
- Access to marketing tools (QR generator, dashboard)

---

## 🔒 Booking & Payment Logic

| State     | Booking Allowed | Payment Method         | Notes                                |
|----------|------------------|-------------------------|--------------------------------------|
| Guest    | ✅ Yes           | 💳 Card only            | Pre-auth to simulate commitment      |
| Verified | ✅ Yes           | 💳 or 💵 (toggleable)   | Cash only shows after first success  |
| Rebook   | ✅ FastBook      | Retains previous method | Skips some steps                     |

---

## 💬 UX Prompts

| Screen            | User State   | Prompt Example                            |
|-------------------|--------------|-------------------------------------------|
| BookingScreen     | Guest        | "Enter card to confirm your first booking"|
| BookingScreen     | Verified     | "Pay now or after service (toggle)"       |
| Bsse7aScreen      | Any          | "Leave a review to unlock new features"   |
| BarberProfile     | QR visitor   | "This stylist accepts trusted clients only" (if gated) |

---

## 🔁 Trust Upgrade Triggers

| Action                     | Result                                 |
|----------------------------|----------------------------------------|
| Completed booking (card)   | Upgrade to Verified                    |
| Review submitted           | Boost visibility and shortcut access   |
| QR visit and fast book     | Trust linked to stylist, pre-verified  |
| Repeated no-shows (future) | Downgrade to guest (cool-down logic)  |

> All user states are simulated in the demo via static toggle buttons or flags in local storage. No real auth system is active in the MVP.

---

## 🧪 Future Scaling Plan

In full production:
- Verified status can link to verified phone/email
- No-show and abuse monitoring will refine access
- Partner barbershops can pre-verify their clients via QR

---

## 🔚 Summary
ZinApp builds **trust by behavior**, not paperwork. 

No sign-up needed. No long forms. Just fast, intuitive flows that reward reliability and show real-world user intent.

This system enables:
- Quick onboarding without scaring users
- Strong psychological sense of progress
- Growth loops via QR and stylist referrals
