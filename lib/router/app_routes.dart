/// Defines named routes for cleaner navigation.
abstract class AppRoutes {
  // Main app routes
  static const String home = '/';
  static const String profile = '/profile';
  static const String profileEdit = '/profile/edit';
  static const String feed = '/feed';
  static const String createPost = '/feed/create';
  static const String postDetail = '/feed/post/:id';
  static const String stylistList = '/stylists';
  static const String stylistDetail = '/stylists/:id';
  static const String booking = '/booking';
  static const String bookingConfirmation = '/booking/confirmation';
  static const String bookingHistory = '/booking/history';
  static const String messages = '/messages';
  static const String messageDetail = '/messages/:id';

  // Rewards routes
  static const String rewardsHub = '/rewards';
  static const String dailyRewards = '/rewards/daily';
  static const String challenges = '/rewards/challenges';
  static const String tokenShop = '/rewards/shop';

  // Auth routes
  static const String forgotPassword = '/forgot-password';

  // Development routes
  static const String showcase = '/showcase'; // Component showcase
  static const String riverpodTest = '/riverpod-test'; // Riverpod test screen
}
