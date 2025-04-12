#!/bin/bash

# ZinApp V2 - JSON Server Setup Script
# This script sets up a JSON Server for local authentication and data storage during MVP development.

echo "Setting up JSON Server for ZinApp V2 local development..."

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "Error: npm is not installed. Please install Node.js and npm first."
    exit 1
fi

# Install JSON Server globally
echo "Installing JSON Server globally..."
npm install -g json-server

# Create data directory if it doesn't exist
mkdir -p data

# Create initial db.json file with sample data
echo "Creating initial database with sample data..."
cat > data/db.json << EOL
{
  "users": [
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
  ],
  "stylists": [
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
    }
  ],
  "posts": [
    {
      "id": "post789",
      "userId": "stylist456",
      "content": "Check out this amazing color transformation! #balayage #haircolor",
      "imageUrls": ["assets/images/posts/post789_1.jpg", "assets/images/posts/post789_2.jpg"],
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
      "imageUrls": ["assets/images/posts/post790_1.jpg"],
      "tags": ["newhair", "happy", "transformation"],
      "location": "New York, NY",
      "likesCount": 45,
      "commentsCount": 8,
      "sharesCount": 2,
      "createdAt": "2023-06-16T09:45:00Z"
    }
  ],
  "comments": [
    {
      "id": "comment123",
      "postId": "post789",
      "userId": "user123",
      "content": "This looks amazing! I need to book an appointment!",
      "likesCount": 5,
      "createdAt": "2023-06-15T15:10:00Z"
    }
  ],
  "bookings": [
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
    }
  ],
  "achievements": [
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
    },
    {
      "id": "first_client",
      "title": "First Client",
      "description": "Complete your first client appointment",
      "iconUrl": "assets/images/achievements/first_client.png",
      "xpReward": 50,
      "tokenReward": 25,
      "category": "booking",
      "rarity": "common"
    },
    {
      "id": "perfect_rating",
      "title": "Perfect Service",
      "description": "Receive 10 five-star ratings",
      "iconUrl": "assets/images/achievements/perfect_rating.png",
      "xpReward": 100,
      "tokenReward": 50,
      "category": "milestone",
      "rarity": "uncommon"
    },
    {
      "id": "booking_master",
      "title": "Booking Master",
      "description": "Complete 100 bookings",
      "iconUrl": "assets/images/achievements/booking_master.png",
      "xpReward": 500,
      "tokenReward": 250,
      "category": "milestone",
      "rarity": "rare"
    },
    {
      "id": "social_butterfly",
      "title": "Social Butterfly",
      "description": "Make 10 posts and get 50 likes",
      "iconUrl": "assets/images/achievements/social_butterfly.png",
      "xpReward": 100,
      "tokenReward": 50,
      "category": "social",
      "rarity": "uncommon"
    }
  ],
  "badges": [
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
    },
    {
      "id": "trendsetter",
      "title": "Trendsetter",
      "description": "Consistently creates popular and trending styles",
      "iconUrl": "assets/images/badges/trendsetter.png"
    }
  ],
  "tokenTransactions": [
    {
      "id": "transaction123",
      "userId": "user123",
      "amount": 10,
      "type": "earned",
      "description": "Completed profile",
      "timestamp": "2023-06-15T11:30:00Z",
      "relatedEntityId": null
    },
    {
      "id": "transaction124",
      "userId": "user123",
      "amount": 15,
      "type": "earned",
      "description": "First booking achievement",
      "timestamp": "2023-06-15T14:45:00Z",
      "relatedEntityId": "booking123"
    },
    {
      "id": "transaction125",
      "userId": "stylist456",
      "amount": 25,
      "type": "earned",
      "description": "First client achievement",
      "timestamp": "2023-06-10T15:30:00Z",
      "relatedEntityId": "booking123"
    }
  ]
}
EOL

echo "JSON Server setup complete!"
echo "To start the server, run: json-server --watch data/db.json --host YOUR_LOCAL_IP --port 3000"
echo "Replace YOUR_LOCAL_IP with your actual local network IP address."
echo "Example: json-server --watch data/db.json --host 192.168.1.100 --port 3000"
