// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stylist_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$stylistServiceHash() => r'57ebdfb655789e2365a0e3d9d0398304c293d578';

/// Provider for the StylistService
///
/// Copied from [stylistService].
@ProviderFor(stylistService)
final stylistServiceProvider = AutoDisposeProvider<StylistService>.internal(
  stylistService,
  name: r'stylistServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$stylistServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StylistServiceRef = AutoDisposeProviderRef<StylistService>;
String _$stylistProviderHash() => r'c3cb3eff12bd852f1c240948817fc2420764b077';

/// Provider for managing stylist data
///
/// Copied from [StylistProvider].
@ProviderFor(StylistProvider)
final stylistProviderProvider =
    AutoDisposeNotifierProvider<StylistProvider, StylistState>.internal(
      StylistProvider.new,
      name: r'stylistProviderProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$stylistProviderHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$StylistProvider = AutoDisposeNotifier<StylistState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
