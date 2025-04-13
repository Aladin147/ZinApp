import 'package:flutter_test/flutter_test.dart';
import 'package:zinapp_v2/models/stylist.dart';
import 'package:zinapp_v2/models/user_profile.dart'; // Import StylistProfile

void main() {
  group('Stylist', () {
    // Create a sample StylistProfile for testing
    const testStylistProfile = StylistProfile(
      specialization: 'Hair Cutting',
      services: ['Cut', 'Wash', 'Style'],
      rating: 4.5,
      reviewCount: 120,
      businessName: 'Test Salon',
      businessAddress: '123 Test St',
      isAvailable: true,
      completedBookings: 200,
      clientCount: 150,
    );

    // Create a sample Stylist instance
    const testStylist = Stylist(
      id: 'stylist123',
      username: 'test_stylist',
      profilePictureUrl: 'https://example.com/stylist.jpg',
      bio: 'Expert stylist.',
      location: 'New York, NY',
      stylistProfile: testStylistProfile,
      level: 10,
      rank: 'Gold',
      badges: ['Top Rated', 'Fast Booker'],
    );

    test('fromJson creates a Stylist instance correctly', () {
      // Arrange
      final json = {
        'id': 'stylist123',
        'username': 'test_stylist',
        'profilePictureUrl': 'https://example.com/stylist.jpg',
        'bio': 'Expert stylist.',
        'location': 'New York, NY',
        'stylistProfile': { // Nested profile
          'specialization': 'Hair Cutting',
          'services': ['Cut', 'Wash', 'Style'],
          'rating': 4.5,
          'reviewCount': 120,
          'businessName': 'Test Salon',
          'businessAddress': '123 Test St',
          'isAvailable': true,
          'completedBookings': 200,
          'clientCount': 150,
        },
        'level': 10,
        'rank': 'Gold',
        'badges': ['Top Rated', 'Fast Booker'],
      };

      // Act
      final stylist = Stylist.fromJson(json);

      // Assert
      expect(stylist.id, 'stylist123');
      expect(stylist.username, 'test_stylist');
      expect(stylist.profilePictureUrl, 'https://example.com/stylist.jpg');
      expect(stylist.bio, 'Expert stylist.');
      expect(stylist.location, 'New York, NY');
      expect(stylist.stylistProfile, testStylistProfile); // Compare nested object
      expect(stylist.level, 10);
      expect(stylist.rank, 'Gold');
      expect(stylist.badges, ['Top Rated', 'Fast Booker']);
    });

    test('toJson converts a Stylist instance to JSON correctly', () {
      // Arrange: Use the pre-defined testStylist

      // Act
      final json = testStylist.toJson();

      // Assert
      expect(json['id'], 'stylist123');
      expect(json['username'], 'test_stylist');
      expect(json['profilePictureUrl'], 'https://example.com/stylist.jpg');
      expect(json['bio'], 'Expert stylist.');
      expect(json['location'], 'New York, NY');
      expect(json['stylistProfile'], testStylistProfile.toJson()); // Compare nested JSON
      expect(json['level'], 10);
      expect(json['rank'], 'Gold');
      expect(json['badges'], ['Top Rated', 'Fast Booker']);
    });

    // Note: Stylist model itself doesn't have copyWith.
    // We test the copyWith of the nested StylistProfile.
    test('StylistProfile copyWith creates a new instance with updated values', () {
      // Arrange: Use the pre-defined testStylistProfile

      // Act
      final updatedProfile = testStylistProfile.copyWith(
        rating: 4.8,
        reviewCount: 150,
        isAvailable: false,
        services: ['Cut', 'Wash'], // Update a list
      );

      // Assert
      expect(updatedProfile.specialization, 'Hair Cutting'); // Unchanged
      expect(updatedProfile.services, ['Cut', 'Wash']); // Changed
      expect(updatedProfile.rating, 4.8); // Changed
      expect(updatedProfile.reviewCount, 150); // Changed
      expect(updatedProfile.businessName, 'Test Salon'); // Unchanged
      expect(updatedProfile.businessAddress, '123 Test St'); // Unchanged
      expect(updatedProfile.isAvailable, false); // Changed
      expect(updatedProfile.completedBookings, 200); // Unchanged
      expect(updatedProfile.clientCount, 150); // Unchanged
    });


    test('equality works correctly', () {
      // Arrange
      const stylist1 = Stylist( // Use testStylist defined above
        id: 'stylist123',
        username: 'test_stylist',
        profilePictureUrl: 'https://example.com/stylist.jpg',
        bio: 'Expert stylist.',
        location: 'New York, NY',
        stylistProfile: testStylistProfile,
        level: 10,
        rank: 'Gold',
        badges: ['Top Rated', 'Fast Booker'],
      );

       const stylist2 = Stylist( // Identical to stylist1
        id: 'stylist123',
        username: 'test_stylist',
        profilePictureUrl: 'https://example.com/stylist.jpg',
        bio: 'Expert stylist.',
        location: 'New York, NY',
        stylistProfile: testStylistProfile,
        level: 10,
        rank: 'Gold',
        badges: ['Top Rated', 'Fast Booker'],
      );

      const stylist3 = Stylist( // Different stylist
        id: 'stylist456',
        username: 'another_stylist',
        profilePictureUrl: 'https://example.com/another.jpg',
        bio: 'Another expert stylist.',
        location: 'Los Angeles, CA',
        stylistProfile: StylistProfile( // Different profile details
          specialization: 'Coloring',
          services: ['Color', 'Highlights'],
          rating: 4.2,
          reviewCount: 80,
          isAvailable: false,
          completedBookings: 100,
          clientCount: 90,
        ),
        level: 8,
        rank: 'Silver',
        badges: ['Creative Color'],
      );

      // Assert
      expect(stylist1, stylist2); // Same values, should be equal
      expect(stylist1, isNot(stylist3)); // Different values, should not be equal
    });
  });
}
