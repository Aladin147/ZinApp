// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamification_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gamificationServiceHash() =>
    r'2bd7af496515bc2a97466512a3887955de5c7cb1';

/// Provider for the GamificationService
///
/// Copied from [gamificationService].
@ProviderFor(gamificationService)
final gamificationServiceProvider = Provider<GamificationService>.internal(
  gamificationService,
  name: r'gamificationServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$gamificationServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GamificationServiceRef = ProviderRef<GamificationService>;
String _$gamificationNotifierHash() =>
    r'e096f6f632c196230ff77407b31879fad0f30933';

/// Provider for gamification state
///
/// Copied from [GamificationNotifier].
@ProviderFor(GamificationNotifier)
final gamificationNotifierProvider =
    NotifierProvider<GamificationNotifier, GamificationState>.internal(
      GamificationNotifier.new,
      name: r'gamificationNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$gamificationNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GamificationNotifier = Notifier<GamificationState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
