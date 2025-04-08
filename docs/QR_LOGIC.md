
# ZinApp QR Logic & Trust Loop Documentation

## 🧭 Purpose
This document defines the architecture and UX logic of the QR Code system used within the ZinApp prototype. This system is designed to simulate real-world discovery, trust-building, and referral mechanisms by enabling both **static QR flyers** and **interactive app-to-app onboarding**.

The goal is to demonstrate:
- A believable real-world usage loop
- Reduced friction between hairdresser and client
- Stylists’ ability to generate and distribute profile trust at low cost

---

## 📌 Key Use Cases

### 1. **Stylist-Side: Generate QR Flyer**
- Button shown on **BarberProfileScreen** for registered stylists
- Generates a **QR code linking to stylist profile**
- Output: shareable digital or printable flyer with:
  - QR code (target: zinapp://barber/hassan)
  - Stylist avatar, name, rating
  - CTA: “Scan to Book Instantly”

**Mock Behavior:**
- Generates fixed URL to fake profile (`/barber/hassan`)
- Simulates download or display of stylized flyer component

### 2. **Client-Side: Scan QR**
- Entry point on home screen ("Scan QR")
- Opens **fake camera overlay**
- After 2 seconds → auto-navigates to preloaded **BarberProfileScreen**
- Context passed: `qrSource = true`

**Visual Cue:**
- Blue outline effect on profile to signal QR trust origin
- Optional: “Discovered via QR” tag at top

---

## 🔄 Flowchart Overview

1. Stylist taps “Generate QR” → receives flyer → shares/posters it
2. User sees flyer → scans QR (in real world)
3. In demo: user presses "Scan QR" → app simulates scan → lands on profile
4. App logs `qrSource = true` → adjusts UI context (blue glow, CTA enabled)

---

## 🧱 QR Tech Spec (Demo)

| Component          | Behavior                            |
|-------------------|-------------------------------------|
| `QRCodeGenerator` | Generates QR from static string     |
| `QRScanScreen`    | Simulates scan, triggers delay      |
| `useQRContext()`  | Stores and returns `qrSource` flag  |
| `BarberProfile`   | Reads context to modify UI          |

> In production, QR links would route to web deep links or app protocol handlers (e.g. `zinapp://barber/12345` or `https://zinapp.com/barber/12345`). For demo purposes, all profiles are hardcoded and styled accordingly.

---

## 🎨 Design System Implications

- All stylist QR flows use **Cool Blue Slate (#8CBACD)** as identity color
- When accessed via QR:
  - Profile border uses animated blue accent (pulse or static glow)
  - Booking CTA appears pre-validated (trust shortcut)
  - Verified badge emphasized visually

---

## 🧠 Trust Loop Logic
| Action                       | Outcome                         |
|------------------------------|----------------------------------|
| Scan unknown QR              | Lands on profile, builds trust   |
| Reviews and gallery shown    | Social proof builds confidence   |
| QR flag enables instant book | No sign-in required              |
| Stylist rebooks repeat users | Loyalty loop                     |

> The QR flow simulates what would eventually become a stylists’ **top-of-funnel growth engine**, building long-term referral pathways organically.

---

## 🔚 Summary
The QR logic in ZinApp is not a gimmick—it’s a trust weapon.

In a market where clients need quick proof of professionalism and stylists need visibility without big marketing budgets, **QR integration becomes the silent middleman of trust**.

This system is designed to demonstrate:
- Seamless stylist-client linking
- Organic offline-to-online funneling
- UX and identity cohesion via QR-sourced visual context
