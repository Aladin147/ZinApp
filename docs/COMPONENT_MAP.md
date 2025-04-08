# ZinApp Component Map

## 🧭 Purpose
This document tracks all reusable UI components in ZinApp, their props, usage locations, and scope. Helps maintain design consistency, avoid redundancy, and guide automated coding agents.

---

## 🔩 Reusable UI Components

| Component        | Description                       | Props                      | Used In                   | Tags       |
|------------------|-----------------------------------|----------------------------|---------------------------|------------|
| `ServiceIconBtn` | Icon button for haircut type      | `icon`, `label`, `onPress`| `ServiceSelectScreen`     | `core`     |
| `BarberCard`     | Stylist preview card              | `name`, `rating`, `photo` | `StylistListScreen`       | `shared`   |
| `AvatarBadge`    | Circular avatar with rating/flag  | `uri`, `verified`          | `Profile`, `LiveTrack`    | `shared`   |
| `RatingStars`    | 5-star feedback bar               | `value`, `editable`        | `Bsse7aScreen`, `Profile` | `shared`   |
| `MapTracker`     | Live map with route overlay       | `coords`, `eta`, `avatar`  | `LiveTrackScreen`         | `core`     |

---

## 🧪 Planned Components

| Component        | Purpose                                  |
|------------------|-------------------------------------------|
| `BookingCard`    | Rebook preview in home/favorites          |
| `Bsse7aConfetti` | Animated celebration + feedback trigger   |
| `QRScanner`      | Mock scan overlay                        |

---

## 🔖 Reusability Tags

- `core` = used in 2+ main flows
- `shared` = repeatable but scoped to one module
- `one-off` = avoid reuse without modification

> This map should be updated per UI commit or new screen build.
