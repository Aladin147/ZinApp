import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/data/datasources/remote/user_profile_remote_data_source.dart';
import 'package:zinapp_v2/models/user_profile.dart';

/// Abstract class defining the user profile repository contract.
abstract class UserProfileRepository {
  /// Fetches the user profile for the given user ID.
  Future<UserProfile> getUserProfile(String userId);

  /// Updates the user profile.
  Future<UserProfile> updateUserProfile(UserProfile userProfile);
}

/// Implementation of the [UserProfileRepository].
class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileRemoteDataSource _remoteDataSource;
  // Potentially add a LocalDataSource later for caching

  UserProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<UserProfile> getUserProfile(String userId) async {
    try {
      // Fetch from remote data source
      // TODO: Implement caching logic if needed
      final userProfile = await _remoteDataSource.getUserProfile(userId);
      return userProfile;
    } catch (e) {
      // Handle or rethrow errors
      print('Error in UserProfileRepository fetching profile $userId: $e');
      rethrow;
    }
  }

  @override
  Future<UserProfile> updateUserProfile(UserProfile userProfile) async {
    try {
      // Update remote data source
      // TODO: Update cache if implemented
      final updatedProfile = await _remoteDataSource.updateUserProfile(userProfile);
      return updatedProfile;
    } catch (e) {
      print('Error in UserProfileRepository updating profile ${userProfile.id}: $e');
      rethrow;
    }
  }
}

// --- Riverpod Provider ---
final userProfileRepositoryProvider = Provider<UserProfileRepository>((ref) {
  final remoteDataSource = ref.watch(userProfileRemoteDataSourceProvider);
  // final localDataSource = ref.watch(userProfileLocalDataSourceProvider); // If caching added
  return UserProfileRepositoryImpl(remoteDataSource);
});
