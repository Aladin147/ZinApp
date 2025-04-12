// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$feedServiceHash() => r'9dcee6cdacbed3f936f6412789b9aea3ccf7204e';

/// Provider for the FeedService
///
/// Copied from [feedService].
@ProviderFor(feedService)
final feedServiceProvider = AutoDisposeProvider<FeedService>.internal(
  feedService,
  name: r'feedServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$feedServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FeedServiceRef = AutoDisposeProviderRef<FeedService>;
String _$feedHash() => r'dfa5a7e7366641bff4edb91da4d360b83285de49';

/// Provider for feed state
///
/// Copied from [Feed].
@ProviderFor(Feed)
final feedProvider = AutoDisposeNotifierProvider<Feed, FeedState>.internal(
  Feed.new,
  name: r'feedProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$feedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Feed = AutoDisposeNotifier<FeedState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
