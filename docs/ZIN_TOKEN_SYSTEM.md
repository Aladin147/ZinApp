
# ZIN Token System Specification

## 🔑 Overview
ZIN tokens are **non-crypto**, off-chain digital reward points used within ZinApp to:
- Reward user engagement
- Encourage ethical collaboration with stylists
- Drive repeat bookings and platform loyalty

They are **pegged conceptually** to the Moroccan Dirham (MAD) for stable in-app logic but have **no real currency value** outside the app ecosystem.

## 🎯 Philosophy
- **Stylists** use ZIN to promote services, get visibility, and offer discounts.
- **Users** earn ZIN by interacting with stylists and helping boost platform credibility.
- The system favors **activity, not wealth** — ZIN cannot be purchased by users.

## 🏆 Earning Tokens – Reward Triggers

| Action | Zin Reward |
|--------|------------|
| Complete a booking | +10 ZIN |
| Leave a verified review | +5 ZIN |
| Allow post-cut photo tagging | +30 ZIN |
| Scan a stylist QR and follow | +3 ZIN |
| Share a stylist profile | +2 ZIN |
| Refer a new user | +15 ZIN |
| Rate a stylist with text | +4 ZIN |
| Daily login streak (3+) | +1 to +5 ZIN |

> ⚠️ Stylists earn visibility and tier perks by circulating tokens to users via actions.

## 💸 Token Utility – Spend Triggers

| Action | Token Cost |
|--------|------------|
| 5% discount on next cut | 30 ZIN |
| Unlock stylist booking priority | 50 ZIN |
| Access to limited time offer | Varies |
| Gamified profile skin upgrade | 75 ZIN |
| Custom emoji reaction pack | 25 ZIN |

> Tokens **expire after 6 months** to prevent hoarding and encourage flow.

## 🔐 Pegging Strategy
- 10 ZIN = ~1 MAD **conceptual peg**
- Used only for internal logic (not displayed as MAD equivalent)
- May inform future pricing for discount tiers or services

## 🧪 Demo Implementation (Prototype Stage)
- All logic simulated in `lib/services/zin_token_service.dart`
- Balances stored in `MockWallet` (local memory or JSON)
- All token actions logged in `token_log.json` (for future backend sync)
- Rate-limiting and abuse detection TBD (not implemented yet)

## 🔒 Security & Abuse Prevention
- QR scans throttled per device per day
- Self-rating or bot triggers are ignored
- Only stylists verified with ID can launch token campaigns

## 🔜 Future Integration
- Backend sync of wallet balances
- Firebase or Supabase integration for validation
- Analytics on token inflow/outflow per user segment
