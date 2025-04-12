// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$apiServiceHash() => r'0c8081e89806b1b88685c41b22500d6df4f25d2b';

/// Riverpod provider for accessing the application's ApiService.
///
/// This provider reads the `useMockData` flag from [AppConfig] to determine
/// whether to provide the [MockApiService] or the [RealApiService].
///
/// Copied from [apiService].
@ProviderFor(apiService)
final apiServiceProvider = Provider<ApiService>.internal(
  apiService,
  name: r'apiServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$apiServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ApiServiceRef = ProviderRef<ApiService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
