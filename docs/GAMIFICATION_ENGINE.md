
# ZinApp Gamification Engine

## 🎮 Purpose
ZinApp transforms haircut logistics into a **social game**, incentivizing real-world interaction between users and stylists. Gamification fosters:
- Retention
- Collaboration
- Organic growth
- Positive user behavior

## 👥 Roles

| Role | Primary Function |
|------|------------------|
| User | Interacts, rates, earns XP/ZIN, levels up |
| Stylist | Completes services, distributes tokens, builds credibility |

## 🎯 XP Trigger Events

| Action | XP |
|--------|----|
| Completed booking | +10 XP |
| Rating + text review | +5 XP |
| Style post reaction (like/share) | +1 XP |
| QR scan and follow | +3 XP |
| Weekly engagement streak | +10 XP |

> XP is **non-spendable** but determines account **level** and **social rank**

## 🧬 Tiers & Levels

| User Level | Title Example |
|------------|----------------|
| 1–10 | Rookie |
| 11–20 | Fresh |
| 21–40 | Gold |
| 41–60 | Prime |
| 61+ | Legend |

| Stylist Tier | Unlocks |
|--------------|---------|
| Apprentice | Basic booking |
| Pro | Token campaigns, custom post |
| Legend | Priority search, highlight banner |

## 🏅 Badges & Achievements
- Verified Stylist (blue check)
- 100+ haircuts done (Pro Stylist badge)
- 50+ reviews (Top Rated badge)
- “Fan of the Fade” (10+ fade reviews)

> All badges are **visual-only**, boosting social proof.

## 🧪 Implementation (Demo Stage)
- XP engine lives in `lib/services/xp_service.dart`
- User/stylist tiers defined in `models/tier_model.dart`
- Titles auto-assigned by `GamificationEngine` logic
- UI badges fetched from `/assets/badges/` as needed

## 🔁 Feedback Loop
- Leveling up triggers confetti, haptics, badge popup
- Token actions emit micro-animation + sound
- High XP users see more FYP interactions

## 🔒 Scaling & Abuse Prevention
- XP caps per day
- Rate-limit for interaction loops
- No XP for repeat ratings of same stylist

## 🧠 Future Features
- Leaderboard for top reviewers
- Seasonal gamified events (Ramadan XP boost, etc.)
- Collaborative XP tasks (e.g. team challenge: 100 cuts in 30 days)
