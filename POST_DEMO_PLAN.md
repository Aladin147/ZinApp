# ZinApp Post-Demo Expansion Plan

## 🎯 Objective
This document outlines key steps to transition from the local mock demo to a scalable production-grade mobile platform.

---

## 🔧 Backend Evolution

| Phase        | Action                                      |
|--------------|---------------------------------------------|
| Alpha        | Supabase or Firebase setup                  |
| Beta         | Replace mock DB with live endpoint calls    |
| Scale        | Move to managed Postgres + Node stack       |

---

## 🧑‍💼 Authentication Roadmap

| Phase      | Action                                  |
|------------|------------------------------------------|
| Demo       | No auth, mock verification flag          |
| Alpha      | OTP login + persistent sessions          |
| Beta       | Social login options                     |
| Scale      | OAuth2 & role-based access control       |

---

## 💳 Payments & Trust

- Stripe or CashPlus integration
- Delayed capture (pre-auth) for card
- Trust metrics stored per user → unlock cash toggle

---

## 🌐 Web Companion

- Phase 2: separate Next.js admin panel
- Admin access for barbershop chains
- Profile management, analytics, QR generation

---

## 🧪 QA/Testing

- Detox for E2E testing
- Unit tests for all screen logic
- Real backend staging environment (CI)

---

## 🚀 Release Prep

| Milestone      | Goal                            |
|----------------|---------------------------------|
| TestFlight     | End-user testing w/ feedback loop|
| Google Beta    | Same build via Expo config       |
| Production     | CDN + analytics + crash logging  |

> Keep this doc updated as you demo, pitch, or recruit dev partners.
