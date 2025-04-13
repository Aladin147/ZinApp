// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$feedServiceHash() => r'0a76a446955205bca2ec3c5cb4567e79ed595e42';

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
String _$feedHash() => r'067c839ab165cd6690209b33f152d04d6804b2b9';

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
