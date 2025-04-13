// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookingServiceHash() => r'7f3511b5e52ca50a962ad27b81f4ab15abff75f7';

/// Provider for the BookingService
///
/// Copied from [bookingService].
@ProviderFor(bookingService)
final bookingServiceProvider = AutoDisposeProvider<BookingService>.internal(
  bookingService,
  name: r'bookingServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$bookingServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BookingServiceRef = AutoDisposeProviderRef<BookingService>;
String _$bookingProviderHash() => r'67caff676606bc390b5adb8469fe89151195e795';

/// Provider for managing booking data
///
/// Copied from [BookingProvider].
@ProviderFor(BookingProvider)
final bookingProviderProvider =
    AutoDisposeNotifierProvider<BookingProvider, BookingState>.internal(
      BookingProvider.new,
      name: r'bookingProviderProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$bookingProviderHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$BookingProvider = AutoDisposeNotifier<BookingState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
