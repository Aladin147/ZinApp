# ZinApp V2 Data Handling Strategy

This document outlines the strategy for handling data fetching, manipulation, and the transition between mock data and a real backend API for ZinApp V2.

## 1. Core Principle: Abstraction
   - All data fetching and manipulation logic will be accessed through an abstract `ApiService` interface. This decouples the application's UI and business logic from the specific data source (mock or real).
   - This allows for easy switching between development/testing using mock data and production using the real API.

## 2. API Service Interface (`lib/services/api_service.dart`)
   - Define an abstract class `ApiService` that declares all methods required for data interaction.
   - Examples:
     ```dart
     // lib/services/api_service.dart
     import '../models/user_profile.dart'; // Example model
     import '../models/stylist.dart'; // Example model
     // ... other models

     abstract class ApiService {
       Future<UserProfile> getUserProfile(String userId);
       Future<List<Stylist>> getNearbyStylists(double lat, double lon);
       Future<bool> submitBooking(String userId, String stylistId, String serviceId);
       Future<void> updateUserXP(String userId, int xpToAdd);
       Future<List<Post>> getFeedPosts(String userId); // For social feed
       Future<bool> submitRating(String bookingId, int score, String comment);
       // ... other methods for fetching services, ratings, updating profile, etc.
     }
     ```
   - Models (like `UserProfile`, `Stylist`, `Post`) will be defined in a separate `lib/models/` directory.

## 3. Mock API Implementation (`lib/services/mock_api_service.dart`)
   - Implements the `ApiService` abstract class.
   - Reads data from and simulates writes to local JSON files located in `/lib/mock_data/` (as defined in `MOCK_API_SCHEMA.md`).
   - Uses standard Dart `dart:io` for file access and `dart:convert` for JSON parsing.
   - Contains logic to simulate API delays (e.g., `Future.delayed`) to mimic network latency.
   - Simulates success and error responses based on input or predefined scenarios.
   - Handles the logic for updating mock data based on actions (e.g., calculating XP, adding ratings).
   - Example Snippet:
     ```dart
     // lib/services/mock_api_service.dart
     import 'dart:convert';
     import 'dart:io';
     import 'package:path_provider/path_provider.dart'; // To find docs directory
     import 'package:flutter/services.dart' show rootBundle; // To load from assets

     import 'api_service.dart';
     import '../models/user_profile.dart';
     // ... other imports

     class MockApiService implements ApiService {
       final String _mockDataPath = 'lib/mock_data'; // Relative path

       Future<Map<String, dynamic>> _loadJson(String fileName) async {
         // Simplified: Load from assets bundle during runtime
         // In a real scenario, might copy to app documents dir on first run
         try {
            final String jsonString = await rootBundle.loadString('$_mockDataPath/$fileName');
            return jsonDecode(jsonString) as Map<String, dynamic>;
         } catch (e) {
            print("Error loading mock data $fileName: $e");
            return {};
         }
       }

       // Example method implementation
       @override
       Future<UserProfile> getUserProfile(String userId) async {
         await Future.delayed(Duration(milliseconds: 300)); // Simulate delay
         final usersData = await _loadJson('users.json');
         final List<dynamic> users = usersData['users'] ?? [];
         final userData = users.firstWhere((user) => user['userId'] == userId, orElse: () => null);

         if (userData != null) {
           return UserProfile.fromJson(userData);
         } else {
           throw Exception('User not found in mock data');
         }
       }

       @override
       Future<void> updateUserXP(String userId, int xpToAdd) async {
          await Future.delayed(Duration(milliseconds: 100));
          // TODO: Implement logic to read users.json, find user, update XP, write back
          print("Simulating update user $userId XP by $xpToAdd");
          // This part needs careful implementation for file writing
       }

       // ... implement other methods
     }
     ```
   - **Note:** Writing back to JSON files within the asset bundle is not possible. For simulating writes, the mock service might update data in memory during the app session or copy files to the app's documents directory on first launch to allow modification. The in-memory approach is simpler for initial development.

## 4. Real API Implementation (`lib/services/real_api_service.dart`)
   - Implements the `ApiService` abstract class.
   - Uses an HTTP client package (e.g., `http` or `dio`) to make network requests to the actual backend API.
   - Handles request/response serialization/deserialization (JSON).
   - Implements error handling for network issues and API error responses.
   - Manages authentication tokens (e.g., adding Authorization headers).
   - Example Snippet (Conceptual):
     ```dart
     // lib/services/real_api_service.dart
     import 'package:http/http.dart' as http;
     import 'dart:convert';

     import 'api_service.dart';
     import '../models/user_profile.dart';
     import '../config/env.dart'; // For base URL

     class RealApiService implements ApiService {
       final String _baseUrl = AppConfig.apiBaseUrl;
       final http.Client _client = http.Client(); // Or Dio instance

       Future<Map<String, String>> _getHeaders() async {
         // TODO: Retrieve auth token from secure storage
         String? token = "YOUR_AUTH_TOKEN"; // Replace with actual token retrieval
         return {
           'Content-Type': 'application/json',
           'Authorization': 'Bearer $token',
         };
       }

       @override
       Future<UserProfile> getUserProfile(String userId) async {
         final response = await _client.get(
           Uri.parse('$_baseUrl/users/$userId'),
           headers: await _getHeaders(),
         );

         if (response.statusCode == 200) {
           return UserProfile.fromJson(jsonDecode(response.body));
         } else {
           // TODO: Handle specific API errors
           throw Exception('Failed to load user profile: ${response.statusCode}');
         }
       }

       // ... implement other methods using http calls
     }

     ```

## 5. Switching Mechanism
   - **Configuration Flag:** Use the `useMockData` flag defined in `lib/config/env.dart`.
     ```dart
     // lib/config/env.dart
     class AppConfig {
       static const bool useMockData = true; // <-- TOGGLE HERE
       // ... other config
     }
     ```
   - **Dependency Injection / Service Locator:** Use a provider (e.g., `Riverpod`, `Provider`) or a simple service locator (e.g., `get_it`) to provide the correct `ApiService` implementation throughout the app based on the flag.
   - **Example (using a simple factory):**
     ```dart
     // Somewhere during app initialization or via a provider

     ApiService getApiService() {
       if (AppConfig.useMockData) {
         return MockApiService();
       } else {
         return RealApiService();
       }
     }

     // Inject/provide the result of getApiService() to widgets/controllers that need it.
     final apiService = getApiService();
     ```

## 6. Error Handling
   - The `ApiService` methods should throw consistent, custom exceptions for different error types (e.g., `NetworkError`, `AuthenticationError`, `NotFoundError`, `ServerError`).
   - The UI layer (or business logic layer) will catch these exceptions and display appropriate user feedback (e.g., snackbars, error messages, retry options).
   - The `MockApiService` should also simulate throwing these exceptions to test error handling paths in the UI.

## 7. Data Models (`lib/models/`)
   - Define plain Dart classes for all data structures (User, Stylist, Booking, etc.).
   - Include `fromJson` factory constructors and potentially `toJson` methods for serialization.
   - These models will be used by both `MockApiService` and `RealApiService`.
