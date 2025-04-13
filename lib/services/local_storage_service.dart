import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Service class for handling simple local storage using SharedPreferences.
class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  // --- Keys ---
  static const String _mockUserIdKey = 'mock_user_id';
  static const String _mockSessionTokenKey = 'mock_session_token'; // Example

  // --- Mock User Session ---

  Future<bool> saveMockUserId(String userId) async {
    return _prefs.setString(_mockUserIdKey, userId);
  }

  String? getMockUserId() {
    return _prefs.getString(_mockUserIdKey);
  }

  Future<bool> clearMockUserSession() async {
    // Clear user ID and any related mock session data
    await _prefs.remove(_mockUserIdKey);
    await _prefs.remove(_mockSessionTokenKey); // Example: clear token too
    return true; // Indicate success (remove returns bool, but we combine)
  }

  // --- Example: Mock Session Token ---

  Future<bool> saveMockSessionToken(String token) async {
    return _prefs.setString(_mockSessionTokenKey, token);
  }

  String? getMockSessionToken() {
    return _prefs.getString(_mockSessionTokenKey);
  }

  // --- Generic Methods (Optional) ---

  Future<bool> saveData(String key, dynamic value) async {
    if (value is String) {
      return _prefs.setString(key, value);
    } else if (value is int) {
      return _prefs.setInt(key, value);
    } else if (value is double) {
      return _prefs.setDouble(key, value);
    } else if (value is bool) {
      return _prefs.setBool(key, value);
    } else if (value is List<String>) {
      return _prefs.setStringList(key, value);
    }
    // Handle other types or throw error if needed
    print('LocalStorageService: Unsupported type for key $key');
    return false;
  }

  dynamic getData(String key) {
    return _prefs.get(key);
  }

  Future<bool> removeData(String key) async {
    return _prefs.remove(key);
  }
}

// --- Riverpod Provider ---

/// Provider to asynchronously get the SharedPreferences instance.
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

/// Provider for the LocalStorageService.
/// Depends on SharedPreferences being available.
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  // Watch the FutureProvider. When the future completes,
  // it will rebuild dependents with the SharedPreferences instance.
  // Using .when to handle loading/error states gracefully.
  final sharedPreferencesAsyncValue = ref.watch(sharedPreferencesProvider);

  return sharedPreferencesAsyncValue.when(
    data: (prefs) => LocalStorageService(prefs),
    // Provide a dummy/error state service or throw if SharedPreferences fails.
    // For simplicity here, we throw, but a real app might need a fallback.
    loading: () {
      // While loading, we could return a service that throws or returns defaults.
      // Throwing ensures dependents handle the loading state via AsyncValue.
      throw Exception('SharedPreferences not yet available');
    },
    error: (err, stack) {
      print('Error initializing SharedPreferences: $err');
      throw Exception('Failed to initialize SharedPreferences: $err');
    },
  );
});
