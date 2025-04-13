// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamification_simulation.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gamificationSimulationHash() =>
    r'3f9ffef9bcf7c41c5762d82dbc0d0e95688593af';

/// Simulation provider for managing gamification logic (XP, levels, tokens, etc.)
///
/// This simulation currently operates independently of the data layer.
/// It will need to be integrated with repositories later to persist state.
///
/// Copied from [GamificationSimulation].
@ProviderFor(GamificationSimulation)
final gamificationSimulationProvider = AutoDisposeNotifierProvider<
  GamificationSimulation,
  GamificationState
>.internal(
  GamificationSimulation.new,
  name: r'gamificationSimulationProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$gamificationSimulationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GamificationSimulation = AutoDisposeNotifier<GamificationState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
