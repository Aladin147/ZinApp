# Local Authentication System Specification

## Overview

This document specifies the implementation of a local authentication system for ZinApp V2 MVP testing. The system will use a JSON Server to simulate a backend API while allowing for easy migration to Firebase or Supabase in the future.

## Goals

1. Provide a functional authentication system for internal testing
2. Simulate real-world authentication flows without cloud dependencies
3. Support user registration, login, and profile management
4. Store gamification data (XP, level, tokens) for testing the full experience
5. Design with future cloud migration in mind

## Non-Goals

1. Production-level security (this is for internal testing only)
2. Complex user management features (password reset, email verification)
3. Multi-device synchronization
4. Performance optimization for large user bases

## Architecture

### Components

1. **JSON Server**
   - Runs on local network
   - Stores user data in JSON format
   - Provides REST API endpoints
   - Simulates backend behavior

2. **AuthService**
   - Flutter service class for authentication operations
   - Handles API communication with JSON Server
   - Manages local session storage
   - Provides authentication state to the app

3. **UserProfileService**
   - Manages user profile data
   - Handles gamification data updates
   - Provides profile information to UI components

4. **SecureStorage**
   - Stores authentication tokens and session data
   - Provides secure access to stored credentials
   - Manages auto-login functionality

### Data Models

#### User

```dart
class User {
  final String id;
  final String email;
  final String username;
  final DateTime createdAt;
  final DateTime lastLogin;
  
  // Constructor, serialization methods, etc.
}
```

#### UserProfile (extends User)

```dart
class UserProfile extends User {
  final int xp;
  final int level;
  final int tokens;
  final List<String> achievements;
  final String profilePictureUrl;
  final UserType userType; // Regular or Stylist
  
  // Constructor, serialization methods, etc.
}
```

#### AuthState

```dart
class AuthState {
  final bool isAuthenticated;
  final UserProfile? user;
  final String? error;
  
  // Constructor, etc.
}
```

### API Endpoints

#### JSON Server Routes

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/users` | Get all users (with query params for filtering) |
| GET | `/users/:id` | Get user by ID |
| POST | `/users` | Create new user |
| PATCH | `/users/:id` | Update user data |
| DELETE | `/users/:id` | Delete user (for testing) |

### Authentication Flow

#### Registration

1. User enters email, password, username
2. Client validates input (email format, password strength)
3. AuthService checks if email already exists
4. If email is unique, create new user record
5. Return new UserProfile and store authentication state
6. Navigate to home screen

#### Login

1. User enters email and password
2. AuthService sends credentials to JSON Server
3. Server returns matching user or error
4. If successful, update last login timestamp
5. Store authentication state locally
6. Navigate to home screen

#### Session Management

1. Store authentication token in secure storage
2. Check token validity on app startup
3. Auto-login if valid token exists
4. Clear token on logout
5. Provide authentication state to app via provider

## Implementation Details

### JSON Server Setup

```bash
# Install JSON Server
npm install -g json-server

# Create initial data file
echo '{
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
      "userType": "regular",
      "createdAt": "2023-06-15T10:30:00Z",
      "lastLogin": "2023-06-16T08:45:00Z"
    }
  ]
}' > db.json

# Run server on local network
json-server --host 192.168.1.X --watch db.json
```

### Flutter Implementation

#### Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.5
  flutter_secure_storage: ^8.0.0
  provider: ^6.0.5
```

#### AuthService Implementation

```dart
class AuthService {
  final String baseUrl = 'http://192.168.1.X:3000';
  final FlutterSecureStorage storage = FlutterSecureStorage();
  
  // Register new user
  Future<UserProfile> register(String email, String password, String username) async {
    // Implementation details...
  }
  
  // Login existing user
  Future<UserProfile> login(String email, String password) async {
    // Implementation details...
  }
  
  // Check current authentication state
  Future<UserProfile?> getCurrentUser() async {
    // Implementation details...
  }
  
  // Logout user
  Future<void> logout() async {
    // Implementation details...
  }
  
  // Save authentication state
  Future<void> _saveAuthState(String userId, UserProfile user) async {
    // Implementation details...
  }
}
```

#### AuthProvider Implementation

```dart
class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  bool _isLoading = false;
  UserProfile? _user;
  String? _error;
  
  bool get isLoading => _isLoading;
  UserProfile? get user => _user;
  bool get isAuthenticated => _user != null;
  String? get error => _error;
  
  // Initialize provider
  Future<void> initialize() async {
    // Implementation details...
  }
  
  // Register new user
  Future<bool> register(String email, String password, String username) async {
    // Implementation details...
  }
  
  // Login user
  Future<bool> login(String email, String password) async {
    // Implementation details...
  }
  
  // Logout user
  Future<void> logout() async {
    // Implementation details...
  }
  
  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
```

## UI Components

### LoginScreen

- Email and password input fields
- Login button
- Register navigation link
- Error message display
- Loading indicator

### RegisterScreen

- Email, password, and username input fields
- Register button
- Login navigation link
- Error message display
- Loading indicator

### AuthWrapper

- Checks authentication state
- Redirects to appropriate screen based on auth state
- Shows loading indicator during initialization

## Testing Strategy

### Unit Tests

- Test AuthService methods with mocked HTTP responses
- Test AuthProvider state management
- Test data model serialization/deserialization

### Widget Tests

- Test login form validation
- Test registration form validation
- Test error message display
- Test loading indicators

### Integration Tests

- Test full authentication flow
- Test persistence between app restarts
- Test error handling scenarios

## Migration Path to Cloud Services

When ready to migrate to Firebase or Supabase:

1. Create new implementation of AuthService that uses Firebase/Supabase
2. Keep the same interface and return types
3. Update dependency injection to provide the new implementation
4. Migrate user data from JSON Server to cloud service
5. Update environment configuration to point to cloud endpoints

## Implementation Timeline

### Week 1: Basic Implementation

- Set up JSON Server with initial data
- Implement AuthService with basic methods
- Create AuthProvider for state management
- Implement login and registration screens
- Add session persistence

### Week 2: Enhanced Features

- Add user profile management
- Implement gamification data storage
- Create admin tools for testing
- Add comprehensive error handling
- Implement auto-login functionality

## Conclusion

This local authentication system will provide a functional and realistic authentication experience for MVP testing without the complexity of cloud integration. The design allows for easy migration to Firebase or Supabase when the project is ready for production deployment.
