import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zinapp_v2/models/stylist.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/services/api_config.dart';
import 'package:zinapp_v2/services/mock_data.dart';

/// Exception thrown when stylist operations fail
class StylistException implements Exception {
  final String message;
  StylistException(this.message);

  @override
  String toString() => 'StylistException: $message';
}

/// Service responsible for stylist operations
class StylistService {
  final String baseUrl = ApiConfig.baseUrl;

  /// Get all stylists
  Future<List<Stylist>> getAllStylists() async {
    try {
      if (ApiConfig.useMockData) {
        // Use mock data
        return MockData.stylists.map((data) {
          final userProfile = UserProfile.fromJson(data);
          return Stylist.fromUserProfile(userProfile);
        }).toList();
      } else {
        final response = await http.get(
          Uri.parse('$baseUrl/stylists'),
        );

        if (response.statusCode == 200) {
          final List<dynamic> stylistsData = jsonDecode(response.body);
          return stylistsData.map((data) {
            final userProfile = UserProfile.fromJson(data);
            return Stylist.fromUserProfile(userProfile);
          }).toList();
        } else {
          throw StylistException(
              'Failed to get stylists: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (e is StylistException) rethrow;
      throw StylistException('Error getting stylists: $e');
    }
  }

  /// Get stylist by ID
  Future<Stylist> getStylistById(String id) async {
    try {
      if (ApiConfig.useMockData) {
        // Use mock data
        final stylistData = MockData.stylists.firstWhere(
          (s) => s['id'] == id,
          orElse: () => throw StylistException('Stylist not found'),
        );
        final userProfile = UserProfile.fromJson(stylistData);
        return Stylist.fromUserProfile(userProfile);
      } else {
        final response = await http.get(
          Uri.parse('$baseUrl/stylists/$id'),
        );

        if (response.statusCode == 200) {
          final stylistData = jsonDecode(response.body);
          final userProfile = UserProfile.fromJson(stylistData);
          return Stylist.fromUserProfile(userProfile);
        } else {
          throw StylistException(
              'Failed to get stylist: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (e is StylistException) rethrow;
      throw StylistException('Error getting stylist: $e');
    }
  }

  /// Search stylists by name, location, or specialization
  Future<List<Stylist>> searchStylists(String query) async {
    try {
      // JSON Server doesn't support full-text search, so we'll get all stylists
      // and filter them on the client side
      final allStylists = await getAllStylists();

      // Convert query to lowercase for case-insensitive search
      final lowerQuery = query.toLowerCase();

      // Filter stylists based on the query
      return allStylists.where((stylist) {
        return stylist.username.toLowerCase().contains(lowerQuery) ||
            (stylist.location?.toLowerCase().contains(lowerQuery) ?? false) ||
            stylist.stylistProfile.specialization.toLowerCase().contains(lowerQuery) ||
            stylist.stylistProfile.services.any((service) => service.toLowerCase().contains(lowerQuery));
      }).toList();
    } catch (e) {
      if (e is StylistException) rethrow;
      throw StylistException('Error searching stylists: $e');
    }
  }

  /// Get featured stylists (top rated or promoted)
  Future<List<Stylist>> getFeaturedStylists({int limit = 5}) async {
    try {
      final allStylists = await getAllStylists();

      // Sort by rating and limit the results
      final sortedStylists = List<Stylist>.from(allStylists)
        ..sort((a, b) => b.stylistProfile.rating.compareTo(a.stylistProfile.rating));

      return sortedStylists.take(limit).toList();
    } catch (e) {
      if (e is StylistException) rethrow;
      throw StylistException('Error getting featured stylists: $e');
    }
  }

  /// Get nearby stylists based on location
  Future<List<Stylist>> getNearbyStylists(String location, {int limit = 5}) async {
    try {
      // In a real app, this would use geolocation
      // For now, we'll just filter by location string
      final allStylists = await getAllStylists();

      final lowerLocation = location.toLowerCase();

      // Filter stylists by location
      final nearbyStylists = allStylists.where((stylist) {
        return stylist.location?.toLowerCase().contains(lowerLocation) ?? false;
      }).toList();

      return nearbyStylists.take(limit).toList();
    } catch (e) {
      if (e is StylistException) rethrow;
      throw StylistException('Error getting nearby stylists: $e');
    }
  }

  /// Get available stylists (those who are currently available)
  Future<List<Stylist>> getAvailableStylists({int limit = 5}) async {
    try {
      final allStylists = await getAllStylists();

      // Filter stylists by availability
      final availableStylists = allStylists.where((stylist) {
        return stylist.stylistProfile.isAvailable;
      }).toList();

      return availableStylists.take(limit).toList();
    } catch (e) {
      if (e is StylistException) rethrow;
      throw StylistException('Error getting available stylists: $e');
    }
  }
}
