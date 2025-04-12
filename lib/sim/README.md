# Simulation Layer

This directory contains the business logic and simulation engines that power ZinApp's features. It separates the application's core behavior from both presentation and data concerns.

## Purpose

The Simulation layer is responsible for:

1. **Business Logic** - Implementing the rules and behaviors of the application
2. **Token Economy** - Simulating the token-based incentive system
3. **Gamification** - Managing XP, levels, achievements, and challenges
4. **State Management** - Providing and managing application state

## Structure

- `token/` - Token economy simulation (earning, spending, balances)
- `gamification/` - XP system, levels, achievements, and challenges
- `booking/` - Booking logic and availability management
- `social/` - Social interactions (likes, comments, sharing)
- `providers/` - Riverpod providers for state management

## Guidelines

1. Simulation logic should be **UI-agnostic**
2. Use interfaces/abstract classes to define contracts with the UI layer
3. Domain models should be immutable where possible
4. All business rules should be documented with clear comments
5. Logic should be testable in isolation
6. Use Riverpod for state management and dependency injection

## Example

```dart
abstract class TokenService {
  Future<TokenTransaction> awardTokens(String userId, int amount, String reason);
  Future<TokenBalance> getBalance(String userId);
  Future<bool> canAfford(String userId, int amount);
  Future<TokenTransaction> spendTokens(String userId, int amount, String purpose);
}

class TokenServiceImpl implements TokenService {
  final TokenRepository repository;
  
  const TokenServiceImpl({required this.repository});
  
  @override
  Future<TokenTransaction> awardTokens(String userId, int amount, String reason) async {
    // Implementation
  }
  
  // Other implementations...
}
