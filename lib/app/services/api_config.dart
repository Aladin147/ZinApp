/// Configuration for API endpoints
class ApiConfig {
  /// Base URL for the API
  ///
  /// For local development with JSON Server, this should be set to your
  /// local network IP address and port, e.g., 'http://192.168.1.100:3000'
  ///
  /// To find your IP address:
  /// - Windows: Run 'ipconfig' in Command Prompt and look for IPv4 Address
  /// - macOS: Run 'ifconfig en0' in Terminal and look for inet
  /// - Linux: Run 'hostname -I' in Terminal
  ///
  /// After updating this, run the JSON Server using the start_json_server script
  /// with the same IP address.
  ///
  /// For testing without JSON Server, we'll use a mock mode
  static const bool useMockData = true;
  static const String baseUrl = 'http://localhost:3000';

  /// Timeout duration for API requests in seconds
  static const int timeoutDuration = 30;
}
