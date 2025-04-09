# ZinApp - On-Demand Grooming Platform

ZinApp is a mobile-first platform that brings trusted hairdressers directly to your door — fast, professional, and frictionless. Designed in Morocco and globally scalable, it reimagines the grooming experience for the modern lifestyle with a playful, immersive design language.

## 📱 What Is ZinApp?

A playful, immersive app with Glovo-inspired design where users can:
- Book haircuts, beard trims, braids, or full services in seconds
- Discover stylists by proximity, rating, and portfolio
- Scan barbershop QR codes to view profiles and book instantly
- Pay by card or cash (post-trust unlock)

Stylists, on the other hand, can:
- Showcase portfolios and service menus
- Share personalized QR flyers to attract real-world clients
- Receive bookings and tips with zero cloud setup

## 🚀 Getting Started

### Prerequisites

- Node.js (v14 or later)
- npm or yarn
- Expo CLI (`npm install -g expo-cli`)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Aladin147/ZinApp.git
   cd ZinApp
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Start the development server:
   ```bash
   npm start
   ```

4. Start the mock API server (in a separate terminal):
   ```bash
   npm run mock-api
   ```

5. Run both servers simultaneously:
   ```bash
   npm run dev
   ```

### Running on a Device

- Use the Expo Go app on your iOS or Android device
- Scan the QR code from the terminal
- When working out of office (OoO), launch Expo with the '--tunnel' argument

## 🧩 Project Structure

```
/zinapp
├── /assets            # Images, fonts, and other static assets
├── /components        # Reusable UI components
│   ├── /common        # Common UI components (Button, Card, Typography, etc.)
│   └── /specific      # Screen-specific components
├── /constants         # App-wide constants (colors, spacing, etc.)
├── /mock-api          # Mock API server for development
├── /screens           # App screens with immersive design
├── /types             # TypeScript type definitions
├── /navigation        # Navigation with custom transitions
├── /docs              # Comprehensive documentation
├── App.tsx            # Main app component
└── README.md          # This file
```

## 📚 Documentation

The project includes comprehensive documentation in the `/docs` directory:

- `DESIGN_TOKENS.md` - Design system specifications
- `COMPONENT_MAP.md` - Overview of all UI components
- `FEATURE_FLOW.md` - User flow and screen transitions
- `ANIMATION_INTERACTION_SYSTEM.md` - Animation specifications
- `BARBER_PROFILE_SCREEN.md` - BarberProfileScreen implementation details
- `BOOKING_SCREEN.md` - BookingScreen implementation details
- `LIVE_TRACK_SCREEN.md` - LiveTrackScreen implementation details
- `BSSE7A_SCREEN.md` - Bsse7aScreen implementation details
- `NAVIGATION_TRANSITIONS.md` - Custom navigation transitions
- `PROGRESS_JOURNAL.md` - Development progress journal
- `PROGRESS_AND_NEXT_STEPS.md` - Implementation progress and next steps
- `FINAL_SUMMARY.md` - Final project summary

## 🛠️ Tech Stack

- **Framework**: React Native (via Expo)
- **Styling**: Custom components with immersive design
- **Navigation**: React Navigation with custom transitions
- **Animation**: React Native Animated & Lottie
- **Maps**: React Native Maps with custom styling
- **Icons**: React Native Vector Icons
- **Effects**: React Native Confetti Cannon
- **Gradients**: Expo Linear Gradient
- **Mock API**: JSON Server

## 🧪 Current Status

The project has been enhanced with a playful, immersive design language. All major screens have been implemented with the new design language, and custom navigation transitions have been added for a more cohesive user experience. See the [FINAL_SUMMARY.md](docs/FINAL_SUMMARY.md) for a comprehensive overview of the enhancements.

## 🤝 Contributing

1. Check the [TODO.md](docs/TODO.md) file for current tasks
2. Create a new branch for your feature
3. Make your changes
4. Submit a pull request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Design inspiration from Glovo, with playful and immersive elements
- Moroccan cultural context and grooming industry insights
- Enhanced with a focus on user engagement and visual appeal
