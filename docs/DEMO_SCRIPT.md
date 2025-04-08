
# ZinApp Demo Walkthrough Script

## 🎯 Objective
This script guides a product demo walkthrough of ZinApp for internal reviewers, investors, or beta testers. It emphasizes the product’s unique value, smooth UI, and mobile-first innovation in grooming services.

The flow is designed to simulate a real experience using mock data, with UX cues engineered to make the app feel already operational and reliable.

---

## 🧪 Context
- Device: iPhone or Android running Expo Go
- Network: LAN / offline mode
- Backend: json-server (local mock API)
- Auth: Disabled (guest mode)

---

## 🧭 Live Walkthrough (Spoken or Narrated)

### 🟢 1. **Launch the App**
> "This is ZinApp — an on-demand haircut platform that brings trusted stylists to your door in under an hour. No accounts, no appointments, just seamless booking."
- App opens to splash animation → logo → CTA: “Let’s Book”

➡️ Tap “Let’s Book”

---

### 🟡 2. **Select Service**
> "Users choose what they need today. We keep it simple — just four categories: haircut, beard trim, braids, or full service."
- Tap one (e.g. Haircut)

➡️ Transition to stylist list

---

### 🟠 3. **View Stylists Nearby**
> "Here’s a curated list of available stylists nearby. Real ratings, real pictures, and verified badges help users trust instantly."
- Scroll list (min 3 stylists)
- Pick one with high reviews

➡️ Tap stylist card → open profile

---

### 🔵 4. **Barber Profile & QR Flow**
> "This is Hassan. Stylists on ZinApp have portfolios, service pricing, and shareable QR flyers — they become their own storefronts."
- Point out review score, gallery, and pricing
- Mention QR trust flow if relevant

➡️ Tap “Book this stylist”

---

### 🔴 5. **Booking Flow**
> "Booking is frictionless. No login required. Just choose a time and confirm. First-time users must add a card — verified users can pay cash."
- Pick 30 min later
- Choose payment method (mocked)

➡️ Tap “Confirm”

---

### 🟣 6. **Live Tracking**
> "Once confirmed, users can track the stylist in real time. This map is mocked, but mimics the live route and ETA you'd expect."
- Watch the avatar move (simulated route)

➡️ Wait ~10 sec or trigger auto-complete → Bsse7a screen

---

### 🟤 7. **Bsse7a Experience**
> "After the service, users land on the ‘Bsse7a’ screen — a cultural nod, with tip buttons, ratings, and rebooking options."
- Show confetti animation
- Tap 5⭐ and tip 10 MAD
- Tap “Rebook” → returns to landing

---

## 🔁 Optional Demo Extras
- QR Scan from home screen → simulate trust-first discovery
- Rebooking with saved stylist
- No-stylist fallback → “no stylists nearby” simulation

---

## 🧤 Style & Tone
- Friendly, confident, local-language sensitive
- Use Moroccan references when appropriate (e.g., Bsse7a, no-appointment culture)
- Reinforce: **ease, trust, no cloud dependency, speed to service**

---

## 🔚 Summary Close
> "ZinApp is a bold reimagining of how grooming should work in 2025 — spontaneous, trusted, and mobile-first. We start in Morocco, but the model is globally portable."

---

## 📦 Demo Checklist
- [ ] Expo app build installed
- [ ] json-server running on LAN
- [ ] 3 stylists in mock `/stylists`
- [ ] Gallery images linked
- [ ] QR Scan → profile path functional
- [ ] All transitions animated
- [ ] "Bsse7a" screen polished

> Demo takes ~2–3 minutes live. No login, no loading spinner stalls, no cloud risk.

Make it feel **real**. Make it feel **inevitable**.
