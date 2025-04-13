import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/models/stylist.dart'; // Assuming Stylist model exists
import 'package:zinapp_v2/data/datasources/remote/user_remote_data_source.dart'; // For dioProvider

// Base URL defined in user_remote_data_source.dart
// const String _baseUrl = 'http://127.0.0.1:3000'; // Re-use or centralize later

/// Abstract class for remote stylist data operations.
abstract class StylistRemoteDataSource {
  /// Fetches a list of all stylists (or potentially filtered/paginated).
  Future<List<Stylist>> getStylists({Map<String, dynamic>? queryParams});

  /// Fetches a single stylist by their ID.
  Future<Stylist> getStylistById(String stylistId);

  // Add other methods as needed (e.g., searchStylists, updateStylist)
}

/// Implementation of [StylistRemoteDataSource] using Dio.
class StylistRemoteDataSourceImpl implements StylistRemoteDataSource {
  final Dio _dio;
  final String _baseUrl = 'http://127.0.0.1:3000'; // Define base URL locally for now

  StylistRemoteDataSourceImpl(this._dio);

  @override
  Future<List<Stylist>> getStylists({Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/stylists',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> stylistList = response.data as List<dynamic>;
        return stylistList
            .map((json) => Stylist.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to load stylists: Status code ${response.statusCode}',
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      print('DioError fetching stylists: $e');
      throw Exception('Network error fetching stylists: ${e.message}');
    } catch (e) {
      print('Error fetching stylists: $e');
      throw Exception('Failed to fetch stylist data.');
    }
  }

  @override
  Future<Stylist> getStylistById(String stylistId) async {
    try {
      final response = await _dio.get('$_baseUrl/stylists/$stylistId');

      if (response.statusCode == 200) {
        return Stylist.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to load stylist $stylistId: Status code ${response.statusCode}',
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      print('DioError fetching stylist $stylistId: $e');
      throw Exception('Network error fetching stylist: ${e.message}');
    } catch (e) {
      print('Error fetching stylist $stylistId: $e');
      throw Exception('Failed to fetch stylist data.');
    }
  }
}

// --- Riverpod Provider ---

/// Provider for the StylistRemoteDataSource implementation.
/// Reuses the dioProvider from user_remote_data_source.dart
final stylistRemoteDataSourceProvider = Provider<StylistRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider); // Reuse existing Dio instance
  return StylistRemoteDataSourceImpl(dio);
});
