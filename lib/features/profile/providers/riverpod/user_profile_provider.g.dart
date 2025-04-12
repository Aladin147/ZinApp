// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userProfileServiceHash() =>
    r'a1eee342eb29dfcf297ca814f73956ad6d38e29b';

/// Provider for the UserProfileService
///
/// Copied from [userProfileService].
@ProviderFor(userProfileService)
final userProfileServiceProvider =
    AutoDisposeProvider<UserProfileService>.internal(
      userProfileService,
      name: r'userProfileServiceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$userProfileServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserProfileServiceRef = AutoDisposeProviderRef<UserProfileService>;
String _$userProfileHash() => r'a98584ef0fc1b2039295cc0087067f0a2bdf7c96';

/// Provider for user profile state
///
/// Copied from [UserProfile].
@ProviderFor(UserProfile)
final userProfileProvider =
    AutoDisposeNotifierProvider<UserProfile, UserProfileState>.internal(
      UserProfile.new,
      name: r'userProfileProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$userProfileHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$UserProfile = AutoDisposeNotifier<UserProfileState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
