# ADR-001: Migrating from Provider to Riverpod

## Status
Accepted

## Date
2025-04-13

## Context
The ZinApp V2 project currently uses the Provider package for state management. While Provider has served us well, it has several limitations:

1. **Type Safety**: Provider has limited type safety, which can lead to runtime errors.
2. **Testing**: Testing components that use Provider can be challenging, especially when overriding dependencies.
3. **Dependency Management**: Provider makes it difficult to manage complex dependency trees.
4. **State Refreshing**: Provider lacks built-in support for refreshing providers based on dependencies.

Riverpod addresses these issues while maintaining a similar mental model to Provider, making it a natural evolution for our state management approach.

## Decision
We will migrate from Provider to Riverpod using a feature-by-feature approach. This will allow us to:

1. Maintain a working application throughout the migration
2. Test each migrated feature thoroughly
3. Learn from early migrations to improve later ones
4. Deliver value continuously rather than having a long feature freeze

We will use the code generation approach with `@riverpod` annotations for better type safety and reduced boilerplate.

## Migration Strategy
1. **Setup and Preparation**
   - Add Riverpod dependencies to `pubspec.yaml`
   - Set up ProviderScope at the app root
   - Create utility functions to bridge Provider and Riverpod during transition

2. **Feature-by-Feature Migration**
   - Start with simpler providers (e.g., services, repositories)
   - Create Riverpod equivalents for each Provider
   - Update UI to consume Riverpod providers
   - Test thoroughly
   - Remove old Provider implementation once stable

3. **Migration Order**
   - Auth Feature
   - User Profile Feature
   - Feed Feature
   - Stylist Feature

4. **Clean Up**
   - Remove Provider package
   - Remove legacy providers
   - Update tests
   - Final performance review

## Consequences

### Positive
- Better type safety and compile-time checking
- Improved testability with easier dependency overrides
- More flexible state management patterns
- Better separation of concerns
- Future-proofing the codebase with actively maintained technology

### Negative
- Learning curve for team members
- Temporary code duplication during migration
- Potential for regression bugs during transition
- Additional build time due to code generation

## Implementation Plan
1. Add Riverpod dependencies (already completed)
2. Create parallel implementations starting with Auth feature
3. Migrate features one by one
4. Remove Provider once migration is complete

## References
- [Riverpod Documentation](https://riverpod.dev)
- [Flutter Riverpod Code Generation](https://riverpod.dev/docs/concepts/about_code_generation)
- [Migrating from Provider to Riverpod](https://riverpod.dev/docs/from_provider/quickstart)
