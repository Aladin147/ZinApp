import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/features/profile/providers/riverpod/user_profile_provider.dart';
import 'package:zinapp_v2/models/user.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/zin_avatar.dart';

class RiverpodProfileEditScreen extends ConsumerStatefulWidget {
  const RiverpodProfileEditScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RiverpodProfileEditScreen> createState() => _RiverpodProfileEditScreenState();
}

class _RiverpodProfileEditScreenState extends ConsumerState<RiverpodProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _bioController;
  late TextEditingController _locationController;
  List<String> _selectedStyles = [];
  final List<String> _availableStyles = [
    'Fade', 'Taper', 'Undercut', 'Pompadour', 'Crew Cut', 'Buzz Cut',
    'Comb Over', 'Quiff', 'Slick Back', 'Mohawk', 'Braids', 'Dreadlocks',
    'Afro', 'Curly', 'Wavy', 'Straight', 'Pixie Cut', 'Bob', 'Layered',
    'Bangs', 'Updo', 'Highlights', 'Balayage', 'Ombre', 'Pastel',
  ];

  @override
  void initState() {
    super.initState();
    final user = ref.read(authProvider).user;
    
    _usernameController = TextEditingController(text: user?.username ?? '');
    _bioController = TextEditingController(text: user?.bio ?? '');
    _locationController = TextEditingController(text: user?.location ?? '');
    
    if (user?.favoriteStyles != null) {
      _selectedStyles = List.from(user!.favoriteStyles!);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      final updates = {
        'username': _usernameController.text.trim(),
        'bio': _bioController.text.trim(),
        'location': _locationController.text.trim(),
        'favoriteStyles': _selectedStyles,
      };

      final success = await ref.read(userProfileProvider.notifier).updateProfile(updates);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else if (mounted) {
        final error = ref.read(userProfileProvider).error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error ?? 'Failed to update profile'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _toggleStyle(String style) {
    setState(() {
      if (_selectedStyles.contains(style)) {
        _selectedStyles.remove(style);
      } else {
        _selectedStyles.add(style);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final profileState = ref.watch(userProfileProvider);
    final user = authState.user;
    final theme = Theme.of(context);

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('User not found'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: profileState.isLoading ? null : _saveProfile,
            child: Text(
              'Save',
              style: TextStyle(
                color: profileState.isLoading
                    ? theme.colorScheme.onSurface.withOpacity(0.5)
                    : theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: profileState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Profile Picture
                  Center(
                    child: Stack(
                      children: [
                        ZinAvatar(
                          size: ZinAvatarSize.extraLarge,
                          imageUrl: user.profilePictureUrl,
                          initials: user.username.isNotEmpty ? user.username[0] : '?',
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: theme.colorScheme.primary,
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt, size: 18),
                              color: Colors.white,
                              onPressed: () {
                                // TODO: Implement image picker
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Image upload not implemented yet'),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Username
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      if (value.length < 3) {
                        return 'Username must be at least 3 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Bio
                  TextFormField(
                    controller: _bioController,
                    decoration: const InputDecoration(
                      labelText: 'Bio',
                      prefixIcon: Icon(Icons.info_outline),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 3,
                    maxLength: 150,
                  ),
                  const SizedBox(height: 16),

                  // Location
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Favorite Styles
                  Text(
                    'Favorite Styles',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Select the styles you like',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _availableStyles.map((style) {
                      final isSelected = _selectedStyles.contains(style);
                      return FilterChip(
                        label: Text(style),
                        selected: isSelected,
                        onSelected: (_) => _toggleStyle(style),
                        backgroundColor: theme.colorScheme.surface,
                        selectedColor: AppColors.primaryHighlight.withOpacity(0.2),
                        checkmarkColor: AppColors.primaryHighlight,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? AppColors.primaryHighlight
                              : theme.colorScheme.onSurface,
                        ),
                      );
                    }).toList(),
                  ),

                  // Stylist-specific fields (if applicable)
                  if (user.userType == UserType.stylist) ...[
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),
                    Text(
                      'Stylist Information',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'These fields are only visible to stylists',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // TODO: Add stylist-specific fields
                    // This would include fields like specialization, services, business info, etc.
                    // For now, we'll just show a placeholder
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: theme.dividerColor),
                      ),
                      child: const Text(
                        'Stylist profile editing will be available in a future update.',
                      ),
                    ),
                  ],

                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }
}
