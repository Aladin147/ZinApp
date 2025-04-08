
# ZinApp Mock API Schema

## 🧭 Purpose
This document defines the mock API schema that powers the demo version of ZinApp. It serves static JSON through a local server (`json-server` or basic Express.js), simulating a real backend without cloud dependencies. This enables seamless testing and visual flows for demo users, investors, or stakeholders.

---

## 🗂️ Endpoints Overview

| Endpoint           | Description                        |
|--------------------|-------------------------------------|
| `/stylists`        | All available stylists              |
| `/bookings`        | User bookings                      |
| `/users`           | User profiles (guest/verified)      |
| `/services`        | Service options + pricing           |
| `/ratings`         | Historical ratings for stylists     |

---

## 🔧 /stylists (GET)
```json
[
  {
    "id": 1,
    "name": "Hassan the Barber",
    "rating": 4.9,
    "distance_km": 2.1,
    "verified": true,
    "bio": "Fade specialist, 10+ yrs experience",
    "services": [1, 2, 4],
    "gallery": ["/img/fade1.jpg", "/img/fade2.jpg"],
    "availability": "09:00 - 19:00",
    "location": {
      "lat": 33.5899,
      "lng": -7.6039
    },
    "profile_picture": "/img/hassan.png",
    "qr_link": "/barber/hassan"
  }
]
```

---

## 🔧 /services (GET)
```json
[
  { "id": 1, "name": "Haircut", "price": 50 },
  { "id": 2, "name": "Beard Trim", "price": 30 },
  { "id": 3, "name": "Braids", "price": 70 },
  { "id": 4, "name": "Full Service", "price": 100 }
]
```

---

## 🔧 /bookings (GET, POST)
```json
[
  {
    "id": 101,
    "user_id": 10,
    "stylist_id": 1,
    "service_id": 1,
    "status": "confirmed",
    "datetime": "2025-04-10T14:30:00Z",
    "payment_method": "card",
    "rating_given": false
  }
]
```

---

## 🔧 /users (GET)
```json
[
  {
    "id": 10,
    "name": "Yassine",
    "is_verified": true,
    "trust_score": 87,
    "payment_methods": ["card", "cash"],
    "favorite_stylists": [1],
    "qr_discovery": true
  }
]
```

---

## 🔧 /ratings (GET, POST)
```json
[
  {
    "id": 201,
    "stylist_id": 1,
    "user_id": 10,
    "stars": 5,
    "comment": "Clean fade, came fast.",
    "timestamp": "2025-04-10T16:00:00Z"
  }
]
```

---

## 🔁 State Simulation Support
Each record may contain optional demo flags:
- `qr_discovery`: true → triggers trust UI elements
- `rating_given`: false → triggers Bsse7a flow
- `status`: can be `confirmed`, `en_route`, `arrived`, `canceled`

Use local JSON edits or toggle endpoints to simulate flows.

---

## 🔚 Notes
- File structure should mirror `/mock-api/db/*.json`
- Recommend 3 stylist records minimum for visual variance
- Include rating distribution for realism
- Use static timestamps in UTC for repeatable tests

> With this mock API, ZinApp’s demo functions 100% offline, simulating a production experience without backend fragility.
