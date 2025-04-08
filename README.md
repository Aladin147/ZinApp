# ZinApp – On-Demand Grooming Platform

ZinApp is a mobile-first platform that brings trusted hairdressers directly to your door — fast, professional, and frictionless. Designed in Morocco and globally scalable, it reimagines the grooming experience for the modern lifestyle.

---

## 📱 What Is ZinApp?
A sleek, Uber-style app where users can:
- Book haircuts, beard trims, braids, or full services in seconds
- Discover stylists by proximity, rating, and portfolio
- Scan barbershop QR codes to view profiles and book instantly
- Pay by card or cash (post-trust unlock)

Stylists, on the other hand, can:
- Showcase portfolios and service menus
- Share personalized QR flyers to attract real-world clients
- Receive bookings and tips with zero cloud setup

---

## 🧠 Key Concepts
| Feature             | Description                                          |
|---------------------|------------------------------------------------------|
| **Guest Mode**       | Users browse and book without login                 |
| **Trust Upgrade**    | Card → Verified → Cash privileges                  |
| **QR Discovery**     | Scan stylist flyer → land directly on profile       |
| **Live Tracking**    | Avatar ETA and map path during booking              |
| **Bsse7a Screen**    | Post-service screen: rating, tip, rebook            |

---

## 🛠️ Tech Stack
| Layer         | Tech Used                    |
|---------------|------------------------------|
| Mobile        | React Native via Expo        |
| Styling       | NativeWind (Tailwind for RN) |
| Animation     | Reanimated 2, Lottie         |
| Mock Backend  | JSON Server (localhost)      |
| Storage       | Static JSON & image assets   |

---

## 🧪 Demo Setup
1. Clone repo
2. Run local API server:
```bash
cd mock-api && json-server --watch db.json --port 3001
```
3. Start app:
```bash
npx expo start
```
4. Open on Expo Go (same Wi-Fi)

> All data served from `/mock-api/db/` with full offline simulation

---

## 📂 Project Structure (Planned)
```
/zineapp
├── /assets
├── /components
├── /constants
├── /mock
├── /screens
├── /theme
├── App.tsx
└── README.md
```

---

## 🌍 Roadmap
- [x] Design system and branding locked
- [x] QR system and trust model documented
- [x] Full UI/UX flow mapped
- [ ] Component system development
- [ ] Internal prototype build
- [ ] TestFlight submission (beta)
- [ ] Production backend (Supabase or Firebase)

---

## 🤝 License
MIT

---

## 👤 Creator
Built with love by [Aladin @ BlackWoodsCreative]
> "Built to look like a VC-backed startup. Executed by one man with a vision."

---

For pitch decks, visual systems, and architecture docs, see `/docs/` or the [project canvas].

