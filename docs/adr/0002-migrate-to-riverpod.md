# ADR 0002: Migrate from Provider to Riverpod for State Management

## Status
Accepted and Implemented

## Date
2025-04-15

## Context
The ZinApp V2 project was initially using the Provider package for state management. While Provider is a solid solution, it has several limitations:

1. **Limited Reactivity**: Provider requires manual context watching and doesn't offer fine-grained reactivity.
2. **No Code Generation**: Provider doesn't support code generation, leading to more boilerplate code.
3. **Limited Testing Support**: Provider is harder to test due to its tight coupling with the widget tree.
4. **No Family Support**: Provider doesn't support parameterized providers (families).
5. **No Auto-Disposal**: Provider doesn't automatically dispose of providers when they're no longer needed.

As the application grows in complexity, these limitations would increasingly impact development velocity and code quality.

## Decision
We decided to migrate from Provider to Riverpod for state management throughout the application. This migration involved:

1. Adding Riverpod dependencies (flutter_riverpod, riverpod, riverpod_annotation)
2. Creating Riverpod-based versions of all providers
3. Converting screens to use ConsumerWidget/ConsumerStatefulWidget
4. Updating the router to use Riverpod
5. Removing all Provider-based code

We chose to implement a complete migration rather than maintaining dual compatibility to ensure a clean codebase and avoid confusion.

## Approach
We followed a feature-by-feature migration approach:

1. **Auth Feature**: Migrated authentication-related providers and screens
2. **Profile Feature**: Migrated user profile providers and screens
3. **Feed Feature**: Migrated feed-related providers and screens
4. **Home Feature**: Migrated home screen components
5. **Stylist Feature**: Migrated stylist-related providers and screens
6. **Router**: Updated router to use Riverpod for navigation state

For each feature, we:
- Created Riverpod versions of providers with proper state classes
- Updated screens to use Riverpod's ref.watch/ref.read pattern
- Added extension methods where needed for backward compatibility
- Updated tests to work with Riverpod

## Consequences

### Positive
1. **Improved Code Organization**: Riverpod's provider pattern allows for better separation of concerns.
2. **Enhanced Testability**: Riverpod providers are easier to test in isolation.
3. **Reduced Boilerplate**: Code generation reduces boilerplate code.
4. **Better Performance**: More granular rebuilds improve performance.
5. **Improved Developer Experience**: Better tooling and debugging support.
6. **Future-Proofing**: Riverpod is actively maintained and evolving.

### Negative
1. **Learning Curve**: Team members need to learn Riverpod concepts.
2. **Migration Effort**: Significant effort required to migrate existing code.
3. **Potential Bugs**: Risk of introducing bugs during migration.

### Neutral
1. **Different Mental Model**: Riverpod uses a different mental model than Provider.
2. **Documentation Updates**: Documentation needs to be updated to reflect Riverpod usage.

## Alternatives Considered

### Keep Using Provider
We could have continued using Provider, but this would limit our ability to scale the application and would result in more complex code as the application grows.

### Bloc/Cubit
We considered using Bloc/Cubit for state management, but Riverpod offered a more flexible and less verbose solution that better fit our needs.

### MobX
MobX was considered for its reactive programming model, but Riverpod's integration with Flutter and its code generation capabilities made it a better choice for our project.

## Implementation Notes
The migration was completed over several days, with careful attention to maintaining functionality throughout the process. We created comprehensive documentation and updated our development journal to track progress and decisions.

## References
- [Riverpod Documentation](https://riverpod.dev/)
- [Provider vs Riverpod Comparison](https://riverpod.dev/docs/from_provider)
- [Riverpod Migration Guide](https://riverpod.dev/docs/migration/from_provider)
