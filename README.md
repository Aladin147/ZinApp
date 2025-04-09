# ZinApp - On-Demand Grooming Platform

ZinApp is a mobile-first platform that brings trusted hairdressers directly to your door — fast, professional, and frictionless. Designed in Morocco and globally scalable, it reimagines the grooming experience for the modern lifestyle.

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
├── /constants         # App-wide constants (colors, spacing, etc.)
├── /mock-api          # Mock API server for development
├── /screens           # App screens
├── /theme             # Theme configuration
├── /types             # TypeScript type definitions
├── /navigation        # Navigation configuration
├── /docs              # Documentation files
├── App.tsx            # Main app component
└── README.md          # This file
```

## 📚 Documentation

The project includes comprehensive documentation in the `/docs` directory:

- `DESIGN_TOKENS.md` - Design system specifications
- `COMPONENT_MAP.md` - Overview of all UI components
- `FEATURE_FLOW.md` - User flow and screen transitions
- `ANIMATION_INTERACTION_SYSTEM.md` - Animation specifications
- `TODO.md` - Current development tasks
- `STATUS_REPORT_*.md` - Progress reports

## 🛠️ Tech Stack

- **Framework**: React Native (via Expo)
- **Styling**: twrnc (TailwindCSS for React Native)
- **Navigation**: React Navigation
- **Animation**: React Native Reanimated & Lottie
- **Maps**: React Native Maps
- **Icons**: React Native Vector Icons
- **Mock API**: JSON Server

## 🧪 Current Status

The project is currently in active development. See the [CHANGELOG.md](CHANGELOG.md) for recent updates and the [TODO.md](docs/TODO.md) for current tasks.

## 🤝 Contributing

1. Check the [TODO.md](docs/TODO.md) file for current tasks
2. Create a new branch for your feature
3. Make your changes
4. Submit a pull request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Design inspiration from Uber, Glovo, and Airbnb
- Moroccan cultural context and grooming industry insights
