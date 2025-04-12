import 'package:flutter_test/flutter_test.dart';
import 'package:zinapp_v2/models/stylist.dart';

void main() {
  group('Stylist', () {
    test('fromJson creates a Stylist instance correctly', () {
      // Arrange
      final json = {
        'id': 'stylist123',
        'name': 'Test Stylist',
        'profilePictureUrl': 'https://example.com/stylist.jpg',
        'bio': 'This is a test stylist bio',
        'rating': 4.5,
        'reviewCount': 120,
        'specialties': ['Haircut', 'Coloring', 'Styling'],
        'location': 'New York, NY',
        'priceRange': '\$\$',
        'isAvailable': true,
        'isFeatured': true,
        'bookingUrl': 'https://example.com/booking/stylist123',
      };

      // Act
      final stylist = Stylist.fromJson(json);

      // Assert
      expect(stylist.id, 'stylist123');
      expect(stylist.name, 'Test Stylist');
      expect(stylist.profilePictureUrl, 'https://example.com/stylist.jpg');
      expect(stylist.bio, 'This is a test stylist bio');
      expect(stylist.rating, 4.5);
      expect(stylist.reviewCount, 120);
      expect(stylist.specialties, ['Haircut', 'Coloring', 'Styling']);
      expect(stylist.location, 'New York, NY');
      expect(stylist.priceRange, '\$\$');
      expect(stylist.isAvailable, true);
      expect(stylist.isFeatured, true);
      expect(stylist.bookingUrl, 'https://example.com/booking/stylist123');
    });

    test('toJson converts a Stylist instance to JSON correctly', () {
      // Arrange
      final stylist = Stylist(
        id: 'stylist123',
        name: 'Test Stylist',
        profilePictureUrl: 'https://example.com/stylist.jpg',
        bio: 'This is a test stylist bio',
        rating: 4.5,
        reviewCount: 120,
        specialties: ['Haircut', 'Coloring', 'Styling'],
        location: 'New York, NY',
        priceRange: '\$\$',
        isAvailable: true,
        isFeatured: true,
        bookingUrl: 'https://example.com/booking/stylist123',
      );

      // Act
      final json = stylist.toJson();

      // Assert
      expect(json['id'], 'stylist123');
      expect(json['name'], 'Test Stylist');
      expect(json['profilePictureUrl'], 'https://example.com/stylist.jpg');
      expect(json['bio'], 'This is a test stylist bio');
      expect(json['rating'], 4.5);
      expect(json['reviewCount'], 120);
      expect(json['specialties'], ['Haircut', 'Coloring', 'Styling']);
      expect(json['location'], 'New York, NY');
      expect(json['priceRange'], '\$\$');
      expect(json['isAvailable'], true);
      expect(json['isFeatured'], true);
      expect(json['bookingUrl'], 'https://example.com/booking/stylist123');
    });

    test('copyWith creates a new instance with updated values', () {
      // Arrange
      final stylist = Stylist(
        id: 'stylist123',
        name: 'Test Stylist',
        profilePictureUrl: 'https://example.com/stylist.jpg',
        bio: 'This is a test stylist bio',
        rating: 4.5,
        reviewCount: 120,
        specialties: ['Haircut', 'Coloring', 'Styling'],
        location: 'New York, NY',
        priceRange: '\$\$',
        isAvailable: true,
        isFeatured: true,
        bookingUrl: 'https://example.com/booking/stylist123',
      );

      // Act
      final updatedStylist = stylist.copyWith(
        name: 'Updated Stylist',
        rating: 4.8,
        reviewCount: 150,
        isAvailable: false,
      );

      // Assert
      expect(updatedStylist.id, 'stylist123'); // Unchanged
      expect(updatedStylist.name, 'Updated Stylist'); // Changed
      expect(updatedStylist.profilePictureUrl, 'https://example.com/stylist.jpg'); // Unchanged
      expect(updatedStylist.bio, 'This is a test stylist bio'); // Unchanged
      expect(updatedStylist.rating, 4.8); // Changed
      expect(updatedStylist.reviewCount, 150); // Changed
      expect(updatedStylist.specialties, ['Haircut', 'Coloring', 'Styling']); // Unchanged
      expect(updatedStylist.location, 'New York, NY'); // Unchanged
      expect(updatedStylist.priceRange, '\$\$'); // Unchanged
      expect(updatedStylist.isAvailable, false); // Changed
      expect(updatedStylist.isFeatured, true); // Unchanged
      expect(updatedStylist.bookingUrl, 'https://example.com/booking/stylist123'); // Unchanged
    });

    test('equality works correctly', () {
      // Arrange
      final stylist1 = Stylist(
        id: 'stylist123',
        name: 'Test Stylist',
        profilePictureUrl: 'https://example.com/stylist.jpg',
        bio: 'This is a test stylist bio',
        rating: 4.5,
        reviewCount: 120,
        specialties: ['Haircut', 'Coloring', 'Styling'],
        location: 'New York, NY',
        priceRange: '\$\$',
        isAvailable: true,
        isFeatured: true,
        bookingUrl: 'https://example.com/booking/stylist123',
      );

      final stylist2 = Stylist(
        id: 'stylist123',
        name: 'Test Stylist',
        profilePictureUrl: 'https://example.com/stylist.jpg',
        bio: 'This is a test stylist bio',
        rating: 4.5,
        reviewCount: 120,
        specialties: ['Haircut', 'Coloring', 'Styling'],
        location: 'New York, NY',
        priceRange: '\$\$',
        isAvailable: true,
        isFeatured: true,
        bookingUrl: 'https://example.com/booking/stylist123',
      );

      final stylist3 = Stylist(
        id: 'stylist456',
        name: 'Another Stylist',
        profilePictureUrl: 'https://example.com/another.jpg',
        bio: 'This is another stylist bio',
        rating: 4.2,
        reviewCount: 80,
        specialties: ['Haircut', 'Beard Trim'],
        location: 'Los Angeles, CA',
        priceRange: '\$\$\$',
        isAvailable: false,
        isFeatured: false,
        bookingUrl: 'https://example.com/booking/stylist456',
      );

      // Assert
      expect(stylist1, stylist2); // Same values, should be equal
      expect(stylist1, isNot(stylist3)); // Different values, should not be equal
    });
  });
}
