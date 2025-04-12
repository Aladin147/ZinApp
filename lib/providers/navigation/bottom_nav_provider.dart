import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_nav_provider.g.dart';

/// Provider for the current navigation index
@riverpod
class BottomNavIndex extends _$BottomNavIndex {
  // This provider is exposed as bottomNavIndexProvider
  @override
  int build() {
    return 0;
  }

  /// Update the current navigation index
  void setIndex(int index) {
    state = index;
  }
}
