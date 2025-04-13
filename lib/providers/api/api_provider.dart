import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zinapp_v2/config/env.dart';
import 'package:zinapp_v2/services/api_service.dart';
import 'package:zinapp_v2/services/mock_api_service.dart';
// import 'package:zinapp_v2/services/real_api_service.dart'; // Import when created

part 'api_provider.g.dart';

/// Riverpod provider for accessing the application's ApiService.
///
/// This provider reads the `useMockData` flag from [AppConfig] to determine
/// whether to provide the [MockApiService] or the [RealApiService].
@Riverpod(keepAlive: true)
ApiService apiService(ApiServiceRef ref) {
  if (AppConfig.useMockData) {
    // Provide the Mock Service implementation
    return MockApiService();
  } else {
    // Provide the Real Service implementation
    // TODO: Instantiate RealApiService when it's created
    // return RealApiService(/* Pass necessary dependencies like HttpClient */);
    print("WARN: RealApiService not implemented yet, falling back to Mock temporarily.");
    // Fallback to mock temporarily if RealApiService isn't ready but flag is false
    return MockApiService();
    // Or throw an error if strict separation is required:
    // throw UnimplementedError('RealApiService is not yet implemented.');
  }
}
