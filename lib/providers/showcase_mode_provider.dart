import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Key used to store the showcase mode preference
const String _showcaseModeKey = 'showcase_mode_enabled';

/// Provider that supplies the SharedPreferences instance
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

/// Provider that tracks whether showcase mode is enabled
final showcaseModeProvider = StateNotifierProvider<ShowcaseModeNotifier, bool>((ref) {
  return ShowcaseModeNotifier(ref);
});

/// Notifier class to manage the showcase mode state
class ShowcaseModeNotifier extends StateNotifier<bool> {
  final Ref ref;

  ShowcaseModeNotifier(this.ref) : super(false) {
    // Initialize immediately
    initialize();
  }

  /// Initialize from shared preferences
  Future<void> initialize() async {
    try {
      final prefs = await ref.read(sharedPreferencesProvider.future);
      state = prefs.getBool(_showcaseModeKey) ?? false;
    } catch (e) {
      // If there's an error, default to false
      state = false;
    }
  }

  /// Toggle the showcase mode
  Future<void> toggle() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    state = !state;
    await prefs.setBool(_showcaseModeKey, state);
  }

  /// Set the showcase mode explicitly
  Future<void> set(bool value) async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    state = value;
    await prefs.setBool(_showcaseModeKey, state);
  }
}
