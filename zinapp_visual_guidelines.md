
# ZinApp Visual Guidelines – Version 1.0

## 🎨 Visual Identity System Overview
ZinApp’s visual system is engineered to strike a balance between trust, accessibility, and modern lifestyle energy. The theme draws from user-first apps like Glovo, Uber, and Airbnb, while incorporating grooming-industry cultural cues and Moroccan contextual familiarity.

This document outlines the **technical foundation of ZinApp's visual identity**, including type hierarchy, color theory rationale, component shape theory, spacing conventions, iconography, and animation principles. This system was built for high-fidelity product development and scalable brand application.

---

## 🧱 1. Color System & Theory

### Primary Palette
| Color Name       | Hex       | Role                    | Notes                                                   |
|------------------|-----------|-------------------------|----------------------------------------------------------|
| Coral Orange     | #F4805D   | Primary accent          | CTA buttons, highlights, promo tags                      |
| Warm Sand        | #F8F3ED   | Base background         | Creates softness and approachability                     |
| Dark Slate       | #3C3C3C   | Text and contrast base  | Ensures clear readability, anchors visual elements       |
| Cool Blue Slate  | #8CBACD   | Profile theme accent    | Used exclusively for stylist identity visual cues        |
| Cream White      | #FCFBF9   | Secondary background    | Used to balance brightness and hierarchy clarity         |

### Color Theory
- The primary palette is **analogous + complementary**: coral and sand warm the interface, while slate and blue anchor readability and direction.
- The **Cool Blue Slate** is reserved for all stylist-related UI elements, creating a subconscious "trust aura" through visual repetition.
- High-saturation elements are paired with soft backgrounds to **preserve contrast without harshness**, supporting accessibility.

---

## 🧩 2. Typography

### Base Font
- **Font Family:** Uber Move (fallback: Inter / Satoshi)
- **Weight usage:**
  - Bold for headings and CTAs
  - Medium for stylist names, action cards
  - Regular for body and descriptions

### Sizing Convention
| Element                | Font Size | Line Height | Weight  |
|------------------------|-----------|-------------|---------|
| Screen Title           | 24px      | 32px        | Bold    |
| Section Header         | 18px      | 26px        | Bold    |
| Paragraph / Body       | 14px      | 20px        | Regular |
| Button Text            | 16px      | 20px        | Medium  |

### Typography Rationale
- Chosen for **legibility and modern minimalism**
- All caps and excessive weight shifts avoided to maintain a lifestyle tone rather than transactional or SaaS

---

## 🔘 3. Component Shape & Geometry

### Button Shape
- **Rounded Rectangle:** 12px border-radius
- Primary button color: Coral Orange
- Text color: Slate
- Width: full (default) or 70% for side-by-side actions
- Height: 48px standard, 56px for hero actions

### Card Geometry
- **8px inner padding**, **16px outer margin**
- Rounded corners: 16px on containers, 20px on profile avatars
- All cards are elevation-free (no shadows) to mimic flat material but can layer using z-index in scroll views

### Iconography
- All icons are **flat and line-based**, radius-matched to buttons
- Default stroke: 2px, icon color adapts to context (blue for stylists, coral for action, slate for UI navigation)

---

## 🌀 4. Motion & Interaction

### Animation Framework
- Built on **Reanimated 2** (Expo-compatible)
- Optional Lottie integrations for confetti, stylist wave, and route tracking

### Animation Philosophy
- Subtle and goal-oriented: **animate with purpose**, not decoration

### Examples:
- CTA Buttons: slight bounce on tap
- Screen transitions: fade-slide with 200–350ms delay
- Loading: shimmer placeholder + spinner combo
- "Bsse7a!" screen: Lottie confetti burst and avatar highlight flash
- Live Map: animated orange path + pulsing avatar icon

---

## 🧭 5. Spatial Rhythm & Layout Grid
- Base grid: **4pt spacing system**
- Margin baseline: 16px
- Card spacing: 8px internal, 12px external
- Vertical scroll sections: 24px header padding

This maintains a responsive and breathable feel on all devices (tested on iPhone 12–15 and Android Pixel 6).

---

## 💡 6. Branding Rules & Identity Usage

### Logo Composition
- Text: ZinApp (Uber-style font)
- Icon: Rounded barbershop pole with coral and sand spiral, flat vector style

### Use Cases
| Variant         | Use Case               |
|-----------------|------------------------|
| Coral + Cream   | Main logo, on light    |
| Slate + Sand    | Footer / navbar dark mode |
| All-cream on coral | Splash screen         |

### Logo Protection Rules
- Minimum size: 64px height
- Padding zone: 2x cap height
- Never distort, stretch, or angle the barber icon

---

## 🔚 Final Word
This visual system is designed to support a **scalable, credible mobile-first product**. The color, layout, and motion logic serve usability and storytelling in tandem.

These rules are not arbitrary—they are **engineered decisions** to produce a premium, venture-backable user experience. Further iterations will follow user feedback during prototype testing.
