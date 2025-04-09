# ZinApp Component Map

## 🧭 Purpose

This document tracks all reusable UI components in ZinApp, their props, usage locations, and scope. Helps maintain design consistency, avoid redundancy, and guide automated coding agents.

---

## 🔩 Reusable UI Components

| Component        | Description                       | Props                      | Used In                   | Tags       |
|------------------|-----------------------------------|----------------------------|---------------------------|------------|
| `Button`         | Action button with variants       | `title`, `variant`, `icon` | All screens                | `core`     |
| `Card`           | Container with styling variants   | `variant`, `padding`       | All screens                | `core`     |
| `Typography`     | Text with consistent styling      | `variant`, `color`         | All screens                | `core`     |
| `HeroHeader`     | Screen header with coral background | `title`, `icon`, `bottomCornersOnly` | Multiple screens         | `core`     |
| `Logo`           | ZinApp logo with variants         | `variant`, `width`         | Multiple screens           | `core`     |
| `Avatar`         | Circular profile image            | `source`, `size`, `verified` | Multiple screens         | `core`     |
| `QRScanner`      | QR code scanner with visual frame | `onScan`, `headerText`     | `BarberProfileScreen`      | `core`     |
| `ServiceIconBtn` | Icon button for haircut type      | `icon`, `label`, `onPress` | `ServiceSelectScreen`     | `core`     |
| `BarberCard`     | Stylist preview card              | `name`, `rating`, `photo`  | `StylistListScreen`       | `shared`   |
| `RatingStars`    | 5-star feedback bar               | `rating`, `size`, `animated`| `Bsse7aScreen`, `Profile` | `shared`   |
| `MapTracker`     | Live map with route overlay       | `coords`, `eta`, `avatar`  | `LiveTrackScreen`         | `core`     |
| `BookingCard`    | Booking summary with actions      | `booking`, `stylist`       | `LandingScreen`           | `shared`   |
| `ErrorBoundary`  | Catches JS errors in children     | `children`                 | `LiveTrackScreen`         | `core`     |

---

## 🧪 Planned Components

| Component        | Purpose                                  |
|------------------|-------------------------------------------|
| `Bsse7aConfetti` | Animated celebration + feedback trigger   |

---

## 🔖 Reusability Tags

- `core` = used in 2+ main flows
- `shared` = repeatable but scoped to one module
- `one-off` = avoid reuse without modification

> This map should be updated per UI commit or new screen build.
