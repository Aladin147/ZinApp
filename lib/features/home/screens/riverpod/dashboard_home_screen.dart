import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/features/home/widgets/home_dashboard.dart';
import 'package:zinapp_v2/models/booking.dart';
import 'package:zinapp_v2/features/home/models/dashboard_post.dart';
import 'package:zinapp_v2/models/style.dart';
import 'package:zinapp_v2/models/stylist.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/backgrounds/organic_background.dart';

/// A dashboard-style home screen
class DashboardHomeScreen extends ConsumerStatefulWidget {
  /// Creates a dashboard home screen
  const DashboardHomeScreen({super.key});

  @override
  ConsumerState<DashboardHomeScreen> createState() => _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends ConsumerState<DashboardHomeScreen> {
  final _scrollController = ScrollController();

  // Sample data for testing
  final List<Booking> _upcomingBookings = [
    Booking(
      id: '1',
      userId: 'user1',
      stylistId: 'stylist1',
      stylistName: 'Sarah Johnson',
      serviceName: 'Haircut & Style',
      services: ['Haircut', 'Blowout'],
      status: BookingStatus.confirmed,
      appointmentTime: DateTime.now().add(const Duration(days: 2)),
      duration: 60,
      price: 85.0,
      location: 'Downtown Salon',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Booking(
      id: '2',
      userId: 'user1',
      stylistId: 'stylist2',
      stylistName: 'Michael Chen',
      serviceName: 'Color Treatment',
      services: ['Full Color', 'Toner'],
      status: BookingStatus.confirmed,
      appointmentTime: DateTime.now().add(const Duration(days: 7)),
      duration: 120,
      price: 150.0,
      location: 'Luxe Hair Studio',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];

  final List<Style> _trendingStyles = [
    Style(
      id: '1',
      name: 'Modern Shag',
      description: 'A modern take on the classic shag haircut with lots of layers and texture.',
      imageUrl: 'https://i.imgur.com/JQcYqLX.jpg',
      category: 'Medium',
      tags: ['Trendy', 'Layered', 'Textured'],
      likes: 1250,
      saves: 430,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    Style(
      id: '2',
      name: 'Curtain Bangs',
      description: 'Face-framing curtain bangs that blend seamlessly into the rest of the hair.',
      imageUrl: 'https://i.imgur.com/8sKhj9P.jpg',
      category: 'Bangs',
      tags: ['Trendy', 'Face-framing', 'Low-maintenance'],
      likes: 980,
      saves: 320,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    Style(
      id: '3',
      name: 'Wolf Cut',
      description: 'A hybrid between a shag and a mullet, with lots of volume and texture.',
      imageUrl: 'https://i.imgur.com/pK9Qj6R.jpg',
      category: 'Medium',
      tags: ['Edgy', 'Voluminous', 'Textured'],
      likes: 1500,
      saves: 550,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];

  final List<Stylist> _recommendedStylists = [
    Stylist(
      id: 'stylist1',
      username: 'Sarah J.',
      profilePictureUrl: 'https://i.imgur.com/JR7aLOk.jpg',
      level: 5,
      rank: 'Master Stylist',
      badges: ['master_stylist', 'color_expert', '300_bookings'],
      bio: 'Specializing in color transformations and precision cuts.',
      stylistProfile: StylistProfile(
        specialization: 'Color Specialist',
        services: ['Haircut', 'Color', 'Styling'],
        rating: 4.9,
        reviewCount: 215,
        isAvailable: true,
        completedBookings: 320,
        clientCount: 350,
      ),
    ),
    Stylist(
      id: 'stylist2',
      username: 'Michael C.',
      profilePictureUrl: 'https://i.imgur.com/K9mX4Lx.jpg',
      level: 4,
      rank: 'Senior Stylist',
      badges: ['senior_stylist', 'texture_expert', '200_bookings'],
      bio: 'Creating modern, low-maintenance styles for busy professionals.',
      stylistProfile: StylistProfile(
        specialization: 'Precision Cuts',
        services: ['Haircut', 'Styling', 'Beard Trim'],
        rating: 4.8,
        reviewCount: 180,
        isAvailable: true,
        completedBookings: 240,
        clientCount: 280,
      ),
    ),
    Stylist(
      id: 'stylist3',
      username: 'Emma L.',
      profilePictureUrl: 'https://i.imgur.com/Lz9g9aM.jpg',
      level: 3,
      rank: 'Stylist',
      badges: ['rising_star', 'style_expert', '100_bookings'],
      bio: 'Passionate about creating unique styles that express individuality.',
      stylistProfile: StylistProfile(
        specialization: 'Creative Styling',
        services: ['Styling', 'Color', 'Extensions'],
        rating: 4.7,
        reviewCount: 120,
        isAvailable: false,
        completedBookings: 180,
        clientCount: 200,
      ),
    ),
  ];

  final List<DashboardPost> _recentPosts = [
    DashboardPost(
      id: 'post1',
      userId: 'stylist1',
      authorName: 'Sarah J.',
      authorProfilePictureUrl: 'https://i.imgur.com/JR7aLOk.jpg',
      text: 'Just finished this amazing color transformation! Swipe to see the before.',
      imageUrl: 'https://i.imgur.com/pK9Qj6R.jpg',
      tags: ['colortransformation', 'balayage', 'blonde'],
      location: 'Downtown Salon',
      likes: 125,
      comments: 18,
      shares: 5,
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      type: 'before_after',
    ),
    DashboardPost(
      id: 'post2',
      userId: 'stylist2',
      authorName: 'Michael C.',
      authorProfilePictureUrl: 'https://i.imgur.com/K9mX4Lx.jpg',
      text: 'Modern shag with curtain bangs - perfect for summer!',
      imageUrl: 'https://i.imgur.com/JQcYqLX.jpg',
      tags: ['modernshag', 'curtainbangs', 'summerstyle'],
      likes: 98,
      comments: 12,
      shares: 3,
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
      type: 'style',
    ),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('User not found'),
        ),
      );
    }

    return Scaffold(
      body: OrganicBackground(
        backgroundColor: AppColors.baseDarkDeeper,
        shapeColor: AppColors.baseDarkAccent,
        numberOfShapes: 3,
        shapeOpacity: 0.05,
        animate: true,
        child: SafeArea(
          child: HomeDashboard(
            user: user,
            upcomingBookings: _upcomingBookings,
            trendingStyles: _trendingStyles,
            recommendedStylists: _recommendedStylists,
            recentPosts: _recentPosts,
            scrollController: _scrollController,
          ),
        ),
      ),
    );
  }
}
