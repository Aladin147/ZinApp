# Provider Usage Inventory

This document tracks all instances of Provider usage in the codebase that need to be migrated to Riverpod.

## Files Importing Provider Package

- [x] lib/providers.dart
- [x] lib/app/providers/providers.dart
- [x] lib/features/home/screens/enhanced_home_screen.dart
- [x] lib/app/router.dart
- [x] lib/router.dart
- [x] lib/features/auth/widgets/auth_wrapper.dart
- [x] lib/features/auth/screens/login_screen.dart
- [x] lib/features/auth/screens/register_screen.dart
- [x] lib/features/home/screens/home_screen.dart
- [ ] lib/app/features/auth/screens/login_screen.dart
- [ ] lib/app/features/auth/screens/register_screen.dart

## Provider.of<...> Usage

- [x] lib/providers.dart - Provider.of<AuthProvider>
- [x] lib/features/home/screens/enhanced_home_screen.dart - Multiple Provider.of calls
- [x] lib/router.dart - Provider.of<AuthProvider>
- [x] lib/app/router.dart - Provider.of<AuthProvider>
- [x] lib/features/auth/widgets/auth_wrapper.dart - Provider.of<AuthProvider>
- [x] lib/features/auth/screens/login_screen.dart - Provider.of<AuthProvider>
- [x] lib/features/auth/screens/register_screen.dart - Provider.of<AuthProvider>
- [x] lib/features/home/screens/home_screen.dart - Multiple Provider.of calls
- [ ] lib/app/features/auth/screens/login_screen.dart - Provider.of<AuthProvider>
- [ ] lib/app/features/auth/screens/register_screen.dart - Provider.of<AuthProvider>

## MultiProvider Usage

- [x] lib/providers.dart - MultiProvider setup
- [x] lib/app/providers/providers.dart - MultiProvider setup

## ChangeNotifierProvider Usage

- [x] lib/providers.dart - Multiple ChangeNotifierProvider instances
- [x] lib/app/providers/providers.dart - Multiple ChangeNotifierProvider instances

## Provider Classes to Migrate

- [x] lib/features/auth/providers/auth_provider.dart -> Migrated to lib/features/auth/providers/riverpod/auth_provider.dart
- [x] lib/features/profile/providers/user_profile_provider.dart -> Migrated to lib/features/profile/providers/riverpod/user_profile_provider.dart
- [x] lib/features/feed/providers/feed_provider.dart -> Migrated to lib/features/feed/providers/riverpod/feed_provider.dart
- [x] lib/features/stylist/providers/stylist_provider.dart -> Migrated to lib/features/stylist/providers/riverpod/stylist_provider.dart

## Screens to Migrate

- [x] lib/features/auth/screens/auth_screen.dart -> Migrated to lib/features/auth/screens/riverpod/auth_screen.dart
- [x] lib/features/auth/screens/login_screen.dart -> Migrated to lib/features/auth/screens/riverpod/login_screen.dart
- [x] lib/features/auth/screens/register_screen.dart -> Migrated to lib/features/auth/screens/riverpod/register_screen.dart
- [x] lib/features/profile/screens/profile_screen.dart -> Migrated to lib/features/profile/screens/riverpod/profile_screen.dart
- [x] lib/features/profile/screens/profile_edit_screen.dart -> Migrated to lib/features/profile/screens/riverpod/profile_edit_screen.dart
- [x] lib/features/feed/screens/feed_screen.dart -> Migrated to lib/features/feed/screens/riverpod/feed_screen.dart
- [x] lib/features/home/screens/enhanced_home_screen.dart -> Migrated to lib/features/home/screens/riverpod/enhanced_home_screen.dart
- [x] lib/features/stylist/screens/riverpod/stylist_discovery_screen.dart -> Created
- [x] lib/features/stylist/screens/riverpod/stylist_profile_screen.dart -> Created

## Widgets to Migrate

- [x] lib/features/auth/widgets/auth_wrapper.dart -> Migrated to lib/features/auth/widgets/riverpod/auth_wrapper.dart
- [x] lib/features/stylist/widgets/stylist_card.dart -> Migrated to lib/features/stylist/widgets/riverpod/stylist_card.dart
- [x] lib/features/stylist/widgets/stylist_carousel.dart -> Migrated to lib/features/stylist/widgets/riverpod/stylist_carousel.dart

## Dependencies Between Providers

- AuthProvider -> No dependencies
- UserProfileProvider -> Depends on AuthProvider
- FeedProvider -> No dependencies
- StylistProvider -> No dependencies

## Migration Progress

- [x] Auth Feature - 100% migrated
- [x] Profile Feature - 100% migrated
- [x] Feed Feature - 100% migrated
- [x] Home Feature - 100% migrated
- [x] Stylist Feature - 100% migrated
