@echo off
REM ZinApp V2 - JSON Server Setup Script for Windows
REM This script sets up a JSON Server for local authentication and data storage during MVP development.

echo Setting up JSON Server for ZinApp V2 local development...

REM Check if npm is installed
where npm >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Error: npm is not installed. Please install Node.js and npm first.
    exit /b 1
)

REM Install JSON Server globally
echo Installing JSON Server globally...
call npm install -g json-server

REM Create data directory if it doesn't exist
if not exist data mkdir data

REM Create initial db.json file with sample data
echo Creating initial database with sample data...
(
echo {
echo   "users": [
echo     {
echo       "id": "user123",
echo       "email": "test@example.com",
echo       "password": "password123",
echo       "username": "TestUser",
echo       "profilePictureUrl": "assets/images/avatars/default.png",
echo       "xp": 100,
echo       "level": 2,
echo       "tokens": 50,
echo       "achievements": ["first_login", "profile_complete"],
echo       "badges": ["early_adopter"],
echo       "rank": "Style Enthusiast",
echo       "userType": "regular",
echo       "bio": "Hair enthusiast looking for the perfect style!",
echo       "location": "New York, NY",
echo       "favoriteStyles": ["bob", "pixie", "layers"],
echo       "favoriteStylistIds": [],
echo       "postsCount": 5,
echo       "bookingsCount": 2,
echo       "followersCount": 10,
echo       "followingCount": 15,
echo       "createdAt": "2023-06-15T10:30:00Z",
echo       "lastLogin": "2023-06-16T08:45:00Z",
echo       "preferences": {
echo         "enablePushNotifications": true,
echo         "enableEmailNotifications": false,
echo         "notifyOnBookingUpdates": true,
echo         "notifyOnSocialActivity": true,
echo         "notifyOnPromotions": false,
echo         "profileVisibility": "public",
echo         "showLocationOnProfile": true,
echo         "allowTagging": true,
echo         "themeMode": "system",
echo         "language": "en",
echo         "enableAnimations": true
echo       }
echo     }
echo   ],
echo   "stylists": [
echo     {
echo       "id": "stylist456",
echo       "email": "stylist@example.com",
echo       "password": "password123",
echo       "username": "MasterStylist",
echo       "profilePictureUrl": "assets/images/avatars/stylist456.png",
echo       "xp": 2500,
echo       "level": 15,
echo       "tokens": 350,
echo       "achievements": ["first_client", "perfect_rating", "booking_master"],
echo       "badges": ["certified_colorist", "texture_expert"],
echo       "rank": "Master Stylist",
echo       "userType": "stylist",
echo       "bio": "Specializing in color transformations and textured hair.",
echo       "location": "Los Angeles, CA",
echo       "postsCount": 87,
echo       "bookingsCount": 0,
echo       "followersCount": 1250,
echo       "followingCount": 45,
echo       "createdAt": "2023-05-10T09:15:00Z",
echo       "lastLogin": "2023-06-16T10:20:00Z",
echo       "stylistProfile": {
echo         "specialization": "Color Specialist",
echo         "services": ["haircut", "color", "highlights", "treatment"],
echo         "rating": 4.9,
echo         "reviewCount": 142,
echo         "businessName": "Style Studio",
echo         "businessAddress": "123 Fashion Ave, Los Angeles, CA",
echo         "businessHours": {
echo           "monday": {"isOpen": true, "openTime": "09:00", "closeTime": "18:00", "breaks": []},
echo           "tuesday": {"isOpen": true, "openTime": "09:00", "closeTime": "18:00", "breaks": []},
echo           "wednesday": {"isOpen": true, "openTime": "09:00", "closeTime": "18:00", "breaks": []},
echo           "thursday": {"isOpen": true, "openTime": "09:00", "closeTime": "20:00", "breaks": []},
echo           "friday": {"isOpen": true, "openTime": "09:00", "closeTime": "20:00", "breaks": []},
echo           "saturday": {"isOpen": true, "openTime": "10:00", "closeTime": "16:00", "breaks": []},
echo           "sunday": {"isOpen": false, "openTime": null, "closeTime": null, "breaks": []}
echo         },
echo         "portfolioUrls": [
echo           "assets/images/portfolio/stylist456_1.jpg",
echo           "assets/images/portfolio/stylist456_2.jpg",
echo           "assets/images/portfolio/stylist456_3.jpg"
echo         ],
echo         "isAvailable": true,
echo         "completedBookings": 1024,
echo         "clientCount": 345
echo       }
echo     }
echo   ],
echo   "posts": [
echo     {
echo       "id": "post789",
echo       "userId": "stylist456",
echo       "content": "Check out this amazing color transformation! #balayage #haircolor",
echo       "imageUrls": ["assets/images/posts/post789_1.jpg", "assets/images/posts/post789_2.jpg"],
echo       "tags": ["balayage", "haircolor", "transformation"],
echo       "location": "Style Studio, Los Angeles",
echo       "likesCount": 128,
echo       "commentsCount": 24,
echo       "sharesCount": 12,
echo       "createdAt": "2023-06-15T14:30:00Z"
echo     },
echo     {
echo       "id": "post790",
echo       "userId": "user123",
echo       "content": "Loving my new haircut! Thanks @MasterStylist #newhair #happy",
echo       "imageUrls": ["assets/images/posts/post790_1.jpg"],
echo       "tags": ["newhair", "happy", "transformation"],
echo       "location": "New York, NY",
echo       "likesCount": 45,
echo       "commentsCount": 8,
echo       "sharesCount": 2,
echo       "createdAt": "2023-06-16T09:45:00Z"
echo     }
echo   ],
echo   "comments": [
echo     {
echo       "id": "comment123",
echo       "postId": "post789",
echo       "userId": "user123",
echo       "content": "This looks amazing! I need to book an appointment!",
echo       "likesCount": 5,
echo       "createdAt": "2023-06-15T15:10:00Z"
echo     }
echo   ],
echo   "bookings": [
echo     {
echo       "id": "booking123",
echo       "userId": "user123",
echo       "stylistId": "stylist456",
echo       "services": ["haircut", "color"],
echo       "status": "completed",
echo       "date": "2023-06-10T13:00:00Z",
echo       "duration": 120,
echo       "totalPrice": 150,
echo       "rating": 5,
echo       "review": "Amazing service! Loved my new look.",
echo       "createdAt": "2023-06-01T10:15:00Z"
echo     }
echo   ],
echo   "achievements": [
echo     {
echo       "id": "first_login",
echo       "title": "First Steps",
echo       "description": "Log in to the app for the first time",
echo       "iconUrl": "assets/images/achievements/first_login.png",
echo       "xpReward": 10,
echo       "tokenReward": 5,
echo       "category": "onboarding",
echo       "rarity": "common"
echo     },
echo     {
echo       "id": "profile_complete",
echo       "title": "Identity Established",
echo       "description": "Complete your profile information",
echo       "iconUrl": "assets/images/achievements/profile_complete.png",
echo       "xpReward": 20,
echo       "tokenReward": 10,
echo       "category": "onboarding",
echo       "rarity": "common"
echo     },
echo     {
echo       "id": "first_booking",
echo       "title": "First Appointment",
echo       "description": "Book your first appointment with a stylist",
echo       "iconUrl": "assets/images/achievements/first_booking.png",
echo       "xpReward": 30,
echo       "tokenReward": 15,
echo       "category": "booking",
echo       "rarity": "common"
echo     },
echo     {
echo       "id": "first_client",
echo       "title": "First Client",
echo       "description": "Complete your first client appointment",
echo       "iconUrl": "assets/images/achievements/first_client.png",
echo       "xpReward": 50,
echo       "tokenReward": 25,
echo       "category": "booking",
echo       "rarity": "common"
echo     },
echo     {
echo       "id": "perfect_rating",
echo       "title": "Perfect Service",
echo       "description": "Receive 10 five-star ratings",
echo       "iconUrl": "assets/images/achievements/perfect_rating.png",
echo       "xpReward": 100,
echo       "tokenReward": 50,
echo       "category": "milestone",
echo       "rarity": "uncommon"
echo     },
echo     {
echo       "id": "booking_master",
echo       "title": "Booking Master",
echo       "description": "Complete 100 bookings",
echo       "iconUrl": "assets/images/achievements/booking_master.png",
echo       "xpReward": 500,
echo       "tokenReward": 250,
echo       "category": "milestone",
echo       "rarity": "rare"
echo     },
echo     {
echo       "id": "social_butterfly",
echo       "title": "Social Butterfly",
echo       "description": "Make 10 posts and get 50 likes",
echo       "iconUrl": "assets/images/achievements/social_butterfly.png",
echo       "xpReward": 100,
echo       "tokenReward": 50,
echo       "category": "social",
echo       "rarity": "uncommon"
echo     }
echo   ],
echo   "badges": [
echo     {
echo       "id": "early_adopter",
echo       "title": "Early Adopter",
echo       "description": "One of the first users to join ZinApp",
echo       "iconUrl": "assets/images/badges/early_adopter.png"
echo     },
echo     {
echo       "id": "certified_colorist",
echo       "title": "Certified Colorist",
echo       "description": "Professionally certified in hair coloring techniques",
echo       "iconUrl": "assets/images/badges/certified_colorist.png"
echo     },
echo     {
echo       "id": "texture_expert",
echo       "title": "Texture Expert",
echo       "description": "Specialized in working with textured hair",
echo       "iconUrl": "assets/images/badges/texture_expert.png"
echo     },
echo     {
echo       "id": "trendsetter",
echo       "title": "Trendsetter",
echo       "description": "Consistently creates popular and trending styles",
echo       "iconUrl": "assets/images/badges/trendsetter.png"
echo     }
echo   ],
echo   "tokenTransactions": [
echo     {
echo       "id": "transaction123",
echo       "userId": "user123",
echo       "amount": 10,
echo       "type": "earned",
echo       "description": "Completed profile",
echo       "timestamp": "2023-06-15T11:30:00Z",
echo       "relatedEntityId": null
echo     },
echo     {
echo       "id": "transaction124",
echo       "userId": "user123",
echo       "amount": 15,
echo       "type": "earned",
echo       "description": "First booking achievement",
echo       "timestamp": "2023-06-15T14:45:00Z",
echo       "relatedEntityId": "booking123"
echo     },
echo     {
echo       "id": "transaction125",
echo       "userId": "stylist456",
echo       "amount": 25,
echo       "type": "earned",
echo       "description": "First client achievement",
echo       "timestamp": "2023-06-10T15:30:00Z",
echo       "relatedEntityId": "booking123"
echo     }
echo   ]
echo }
) > data\db.json

echo JSON Server setup complete!
echo To start the server, run: json-server --watch data/db.json --host YOUR_LOCAL_IP --port 3000
echo Replace YOUR_LOCAL_IP with your actual local network IP address.
echo Example: json-server --watch data/db.json --host 192.168.1.100 --port 3000

REM Create a start server batch file for convenience
(
echo @echo off
echo REM Replace 192.168.1.100 with your actual local IP address
echo json-server --watch data/db.json --host 192.168.1.100 --port 3000
) > start_json_server.bat

echo Created start_json_server.bat - Edit this file to set your local IP address before running.
