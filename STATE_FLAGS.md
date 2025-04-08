# ZinApp State Flags Reference

## 🎯 Purpose
This file tracks all conditional demo flags and client states used to simulate UX flows in a logic-safe way across all environments.

---

## 📍 Demo Flags

| Flag             | Type    | Screens Affected      | Behavior Triggered                    |
|------------------|---------|------------------------|----------------------------------------|
| `qr_discovery`   | boolean | `BarberProfile`       | Adds trust glow + fast CTA             |
| `is_verified`    | boolean | `Booking`, `Payment`  | Enables cash payment                   |
| `rating_given`   | boolean | `Bsse7aScreen`        | Blocks/skips review modal              |
| `fast_book`      | boolean | `StylistList`         | Skips profile → goes direct to booking |
| `no_stylists`    | boolean | `StylistList`         | Triggers empty state screen            |

---

## 🧪 Simulation Strategy

- All flags editable in local JSON or via debug mode toggle
- State context tracked with context API or local storage
- Can be overridden via QR route injection

> These states must never be hardcoded in prod builds.
