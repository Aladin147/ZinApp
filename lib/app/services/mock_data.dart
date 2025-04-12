/// Mock data for testing without JSON Server
class MockData {
  /// Mock users data
  static final List<Map<String, dynamic>> users = [
    {
      "id": "user123",
      "email": "test@example.com",
      "password": "password123",
      "username": "TestUser",
      "profilePictureUrl": "assets/images/avatars/default.png",
      "xp": 100,
      "level": 2,
      "tokens": 50,
      "achievements": ["first_login", "profile_complete"],
      "badges": ["early_adopter"],
      "rank": "Style Enthusiast",
      "userType": "regular",
      "bio": "Hair enthusiast looking for the perfect style!",
      "location": "New York, NY",
      "favoriteStyles": ["bob", "pixie", "layers"],
      "favoriteStylistIds": [],
      "postsCount": 5,
      "bookingsCount": 2,
      "followersCount": 10,
      "followingCount": 15,
      "createdAt": "2023-06-15T10:30:00Z",
      "lastLogin": "2023-06-16T08:45:00Z",
      "preferences": {
        "enablePushNotifications": true,
        "enableEmailNotifications": false,
        "notifyOnBookingUpdates": true,
        "notifyOnSocialActivity": true,
        "notifyOnPromotions": false,
        "profileVisibility": "public",
        "showLocationOnProfile": true,
        "allowTagging": true,
        "themeMode": "system",
        "language": "en",
        "enableAnimations": true
      }
    }
  ];

  /// Mock stylists data
  static final List<Map<String, dynamic>> stylists = [
    {
      "id": "stylist456",
      "email": "stylist@example.com",
      "password": "password123",
      "username": "MasterStylist",
      "profilePictureUrl": "assets/images/avatars/stylist456.png",
      "xp": 2500,
      "level": 15,
      "tokens": 350,
      "achievements": ["first_client", "perfect_rating", "booking_master"],
      "badges": ["certified_colorist", "texture_expert"],
      "rank": "Master Stylist",
      "userType": "stylist",
      "bio": "Specializing in color transformations and textured hair.",
      "location": "Los Angeles, CA",
      "postsCount": 87,
      "bookingsCount": 0,
      "followersCount": 1250,
      "followingCount": 45,
      "createdAt": "2023-05-10T09:15:00Z",
      "lastLogin": "2023-06-16T10:20:00Z",
      "stylistProfile": {
        "specialization": "Color Specialist",
        "services": ["haircut", "color", "highlights", "treatment"],
        "rating": 4.9,
        "reviewCount": 142,
        "businessName": "Style Studio",
        "businessAddress": "123 Fashion Ave, Los Angeles, CA",
        "businessHours": {
          "monday": {"isOpen": true, "openTime": "09:00", "closeTime": "18:00", "breaks": []},
          "tuesday": {"isOpen": true, "openTime": "09:00", "closeTime": "18:00", "breaks": []},
          "wednesday": {"isOpen": true, "openTime": "09:00", "closeTime": "18:00", "breaks": []},
          "thursday": {"isOpen": true, "openTime": "09:00", "closeTime": "20:00", "breaks": []},
          "friday": {"isOpen": true, "openTime": "09:00", "closeTime": "20:00", "breaks": []},
          "saturday": {"isOpen": true, "openTime": "10:00", "closeTime": "16:00", "breaks": []},
          "sunday": {"isOpen": false, "openTime": null, "closeTime": null, "breaks": []}
        },
        "portfolioUrls": [
          "assets/images/portfolio/stylist456_1.jpg",
          "assets/images/portfolio/stylist456_2.jpg",
          "assets/images/portfolio/stylist456_3.jpg"
        ],
        "isAvailable": true,
        "completedBookings": 1024,
        "clientCount": 345
      }
    },
    {
      "id": "stylist789",
      "email": "stylist2@example.com",
      "password": "password123",
      "username": "CurlSpecialist",
      "profilePictureUrl": "assets/images/avatars/stylist789.png",
      "xp": 1800,
      "level": 10,
      "tokens": 220,
      "achievements": ["first_client", "style_master"],
      "badges": ["curl_expert", "natural_hair"],
      "rank": "Expert Stylist",
      "userType": "stylist",
      "bio": "Curl specialist with expertise in natural hair textures.",
      "location": "Chicago, IL",
      "postsCount": 65,
      "bookingsCount": 0,
      "followersCount": 850,
      "followingCount": 32,
      "createdAt": "2023-05-15T11:20:00Z",
      "lastLogin": "2023-06-15T09:30:00Z",
      "stylistProfile": {
        "specialization": "Curl Specialist",
        "services": ["haircut", "styling", "treatment", "consultation"],
        "rating": 4.8,
        "reviewCount": 98,
        "businessName": "Curl Haven",
        "businessAddress": "456 Texture St, Chicago, IL",
        "businessHours": {
          "monday": {"isOpen": false, "openTime": null, "closeTime": null, "breaks": []},
          "tuesday": {"isOpen": true, "openTime": "10:00", "closeTime": "18:00", "breaks": []},
          "wednesday": {"isOpen": true, "openTime": "10:00", "closeTime": "18:00", "breaks": []},
          "thursday": {"isOpen": true, "openTime": "10:00", "closeTime": "18:00", "breaks": []},
          "friday": {"isOpen": true, "openTime": "10:00", "closeTime": "20:00", "breaks": []},
          "saturday": {"isOpen": true, "openTime": "09:00", "closeTime": "17:00", "breaks": []},
          "sunday": {"isOpen": false, "openTime": null, "closeTime": null, "breaks": []}
        },
        "portfolioUrls": [
          "assets/images/portfolio/stylist789_1.jpg",
          "assets/images/portfolio/stylist789_2.jpg"
        ],
        "isAvailable": true,
        "completedBookings": 756,
        "clientCount": 210
      }
    },
    {
      "id": "stylist101",
      "email": "stylist3@example.com",
      "password": "password123",
      "username": "PixiePro",
      "profilePictureUrl": "assets/images/avatars/stylist101.png",
      "xp": 1200,
      "level": 8,
      "tokens": 180,
      "achievements": ["first_client", "trend_setter"],
      "badges": ["short_hair_expert"],
      "rank": "Established Stylist",
      "userType": "stylist",
      "bio": "Specializing in short cuts and pixie styles.",
      "location": "Miami, FL",
      "postsCount": 42,
      "bookingsCount": 0,
      "followersCount": 620,
      "followingCount": 28,
      "createdAt": "2023-06-01T14:45:00Z",
      "lastLogin": "2023-06-16T11:15:00Z",
      "stylistProfile": {
        "specialization": "Short Hair Specialist",
        "services": ["haircut", "styling", "color"],
        "rating": 4.7,
        "reviewCount": 76,
        "businessName": "Pixie Paradise",
        "businessAddress": "789 Short St, Miami, FL",
        "businessHours": {
          "monday": {"isOpen": true, "openTime": "09:00", "closeTime": "17:00", "breaks": []},
          "tuesday": {"isOpen": true, "openTime": "09:00", "closeTime": "17:00", "breaks": []},
          "wednesday": {"isOpen": true, "openTime": "09:00", "closeTime": "17:00", "breaks": []},
          "thursday": {"isOpen": true, "openTime": "09:00", "closeTime": "17:00", "breaks": []},
          "friday": {"isOpen": true, "openTime": "09:00", "closeTime": "17:00", "breaks": []},
          "saturday": {"isOpen": false, "openTime": null, "closeTime": null, "breaks": []},
          "sunday": {"isOpen": false, "openTime": null, "closeTime": null, "breaks": []}
        },
        "portfolioUrls": [
          "assets/images/portfolio/stylist101_1.jpg",
          "assets/images/portfolio/stylist101_2.jpg",
          "assets/images/portfolio/stylist101_3.jpg"
        ],
        "isAvailable": false,
        "completedBookings": 512,
        "clientCount": 180
      }
    }
  ];

  /// Mock posts data
  static final List<Map<String, dynamic>> posts = [
    {
      "id": "post789",
      "userId": "stylist456",
      "content": "Check out this amazing color transformation! #balayage #haircolor",
      "imageUrls": ["assets/images/posts/post789_1.png"],
      "tags": ["balayage", "haircolor", "transformation"],
      "location": "Style Studio, Los Angeles",
      "likesCount": 128,
      "commentsCount": 24,
      "sharesCount": 12,
      "createdAt": "2023-06-15T14:30:00Z"
    },
    {
      "id": "post790",
      "userId": "user123",
      "content": "Loving my new haircut! Thanks @MasterStylist #newhair #happy",
      "imageUrls": ["assets/images/posts/post790_1.png"],
      "tags": ["newhair", "happy", "transformation"],
      "location": "New York, NY",
      "likesCount": 45,
      "commentsCount": 8,
      "sharesCount": 2,
      "createdAt": "2023-06-16T09:45:00Z"
    },
    {
      "id": "post791",
      "userId": "stylist789",
      "content": "Embracing natural curls is always a good idea! #curlyhair #naturalhair",
      "imageUrls": ["assets/images/posts/post791_1.png"],
      "tags": ["curlyhair", "naturalhair", "curls"],
      "location": "Curl Haven, Chicago",
      "likesCount": 95,
      "commentsCount": 15,
      "sharesCount": 8,
      "createdAt": "2023-06-14T16:20:00Z"
    },
    {
      "id": "post792",
      "userId": "stylist101",
      "content": "Short and chic! This pixie cut is perfect for summer. #pixie #shorthairdontcare",
      "imageUrls": ["assets/images/posts/post792_1.png"],
      "tags": ["pixie", "shorthairdontcare", "summerstyle"],
      "location": "Pixie Paradise, Miami",
      "likesCount": 76,
      "commentsCount": 12,
      "sharesCount": 5,
      "createdAt": "2023-06-15T10:15:00Z"
    }
  ];

  /// Mock comments data
  static final List<Map<String, dynamic>> comments = [
    {
      "id": "comment123",
      "postId": "post789",
      "userId": "user123",
      "content": "This looks amazing! I need to book an appointment!",
      "likesCount": 5,
      "createdAt": "2023-06-15T15:10:00Z"
    },
    {
      "id": "comment124",
      "postId": "post789",
      "userId": "stylist789",
      "content": "Beautiful work! Love the dimension in the color.",
      "likesCount": 3,
      "createdAt": "2023-06-15T16:30:00Z"
    },
    {
      "id": "comment125",
      "postId": "post791",
      "userId": "user123",
      "content": "Those curls are gorgeous! What products do you recommend?",
      "likesCount": 2,
      "createdAt": "2023-06-14T17:45:00Z"
    }
  ];

  /// Mock bookings data
  static final List<Map<String, dynamic>> bookings = [
    {
      "id": "booking123",
      "userId": "user123",
      "stylistId": "stylist456",
      "services": ["haircut", "color"],
      "status": "completed",
      "date": "2023-06-10T13:00:00Z",
      "duration": 120,
      "totalPrice": 150,
      "rating": 5,
      "review": "Amazing service! Loved my new look.",
      "createdAt": "2023-06-01T10:15:00Z"
    },
    {
      "id": "booking124",
      "userId": "user123",
      "stylistId": "stylist789",
      "services": ["consultation", "treatment"],
      "status": "upcoming",
      "date": "2023-06-20T14:30:00Z",
      "duration": 90,
      "totalPrice": 120,
      "createdAt": "2023-06-15T09:30:00Z"
    }
  ];

  /// Mock achievements data
  static final List<Map<String, dynamic>> achievements = [
    {
      "id": "first_login",
      "title": "First Steps",
      "description": "Log in to the app for the first time",
      "iconUrl": "assets/images/achievements/first_login.png",
      "xpReward": 10,
      "tokenReward": 5,
      "category": "onboarding",
      "rarity": "common"
    },
    {
      "id": "profile_complete",
      "title": "Identity Established",
      "description": "Complete your profile information",
      "iconUrl": "assets/images/achievements/profile_complete.png",
      "xpReward": 20,
      "tokenReward": 10,
      "category": "onboarding",
      "rarity": "common"
    },
    {
      "id": "first_booking",
      "title": "First Appointment",
      "description": "Book your first appointment with a stylist",
      "iconUrl": "assets/images/achievements/first_booking.png",
      "xpReward": 30,
      "tokenReward": 15,
      "category": "booking",
      "rarity": "common"
    }
  ];

  /// Mock badges data
  static final List<Map<String, dynamic>> badges = [
    {
      "id": "early_adopter",
      "title": "Early Adopter",
      "description": "One of the first users to join ZinApp",
      "iconUrl": "assets/images/badges/early_adopter.png"
    },
    {
      "id": "certified_colorist",
      "title": "Certified Colorist",
      "description": "Professionally certified in hair coloring techniques",
      "iconUrl": "assets/images/badges/certified_colorist.png"
    },
    {
      "id": "texture_expert",
      "title": "Texture Expert",
      "description": "Specialized in working with textured hair",
      "iconUrl": "assets/images/badges/texture_expert.png"
    }
  ];
}
