# Data Layer

This directory contains all data sources, repositories, and models for ZinApp. It represents the lowest layer in our architecture, providing data to the Simulation layer.

## Purpose

The Data layer is responsible for:

1. **Data Access** - Providing interfaces to data sources (local and remote)
2. **Models** - Defining the data structures used throughout the application
3. **Persistence** - Managing local storage and caching
4. **Mock Data** - Simulating backend responses for development

## Structure

- `models/` - Data classes and serialization logic
- `repositories/` - Repository implementations that aggregate data sources
- `sources/` - Data source implementations (API clients, local storage)
- `mock/` - Mock data and simulated APIs

## Guidelines

1. Repositories should be the **only** way the Simulation layer accesses data
2. All models should be immutable when possible
3. Use JSON serializable for model definitions
4. Provide mock implementations of all repositories for development and testing
5. Data layer should be agnostic to business logic
6. Follow the Repository pattern for data access

## Example

```dart
// Model definition
@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String displayName,
    required String email,
    String? photoUrl,
    int? experiencePoints,
    int? tokenBalance,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => 
      _$UserProfileFromJson(json);
}

// Repository interface
abstract class UserRepository {
  Future<UserProfile> getUserProfile(String userId);
  Future<void> updateUserProfile(UserProfile profile);
  Stream<UserProfile> watchUserProfile(String userId);
}

// Repository implementation
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  
  const UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  
  @override
  Future<UserProfile> getUserProfile(String userId) async {
    try {
      final profile = await remoteDataSource.fetchUserProfile(userId);
      await localDataSource.cacheUserProfile(profile);
      return profile;
    } catch (e) {
      final cachedProfile = await localDataSource.getCachedUserProfile(userId);
      if (cachedProfile != null) {
        return cachedProfile;
      }
      rethrow;
    }
  }
  
  // Other implementations...
}
