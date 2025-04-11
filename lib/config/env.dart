/// Application configuration variables.
/// TODO: Load these from actual environment variables or build flavors later.
abstract class AppConfig {
  /// Flag to determine whether to use mock data or real API.
  /// Set to `false` to attempt using RealApiService (when implemented).
  static const bool useMockData = true; // <-- TOGGLE HERE FOR DEV/PROD

  /// Base URL for the real API.
  static const String apiBaseUrl = 'https://api.example-zinapp.com/v2'; // Replace with actual URL
}
