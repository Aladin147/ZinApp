import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// Utility class for image loading and caching
class ImageUtils {
  /// Loads a network image with caching
  ///
  /// This method uses [CachedNetworkImage] to load and cache network images.
  /// It provides proper error handling and placeholders.
  ///
  /// Parameters:
  /// - [imageUrl]: The URL of the image to load
  /// - [width]: Optional width constraint for the image
  /// - [height]: Optional height constraint for the image
  /// - [fit]: How the image should be inscribed into the space (default: [BoxFit.cover])
  /// - [placeholder]: Optional custom placeholder widget
  /// - [errorWidget]: Optional custom error widget
  /// - [borderRadius]: Optional border radius for the image
  ///
  /// Returns a widget that displays the image with caching, placeholders, and error handling.
  static Widget loadNetworkImage({
    required String? imageUrl,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
    BorderRadius? borderRadius,
  }) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return _buildPlaceholderOrError(
        width: width,
        height: height,
        isError: false,
        customWidget: placeholder,
        borderRadius: borderRadius,
      );
    }

    final imageWidget = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => placeholder ??
          _buildPlaceholderOrError(
            width: width,
            height: height,
            isError: false,
            borderRadius: borderRadius,
          ),
      errorWidget: (context, url, error) => errorWidget ??
          _buildPlaceholderOrError(
            width: width,
            height: height,
            isError: true,
            borderRadius: borderRadius,
          ),
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  /// Builds a placeholder or error widget
  ///
  /// This method builds a placeholder or error widget based on the [isError] flag.
  ///
  /// Parameters:
  /// - [width]: Optional width constraint for the widget
  /// - [height]: Optional height constraint for the widget
  /// - [isError]: Whether to show an error widget or a placeholder
  /// - [customWidget]: Optional custom widget to use instead of the default
  /// - [borderRadius]: Optional border radius for the widget
  ///
  /// Returns a widget that can be used as a placeholder or error widget.
  static Widget _buildPlaceholderOrError({
    double? width,
    double? height,
    required bool isError,
    Widget? customWidget,
    BorderRadius? borderRadius,
  }) {
    final widget = customWidget ??
        Container(
          width: width,
          height: height,
          color: AppColors.baseDarkAlt,
          child: Center(
            child: isError
                ? const Icon(
                    Icons.broken_image,
                    color: AppColors.primaryHighlight,
                  )
                : const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryHighlight,
                    ),
                  ),
          ),
        );

    if (borderRadius != null && customWidget == null) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: widget,
      );
    }

    return widget;
  }

  /// Loads a profile image with caching
  ///
  /// This method is specifically designed for profile images, which are typically
  /// displayed as circles.
  ///
  /// Parameters:
  /// - [imageUrl]: The URL of the image to load
  /// - [radius]: The radius of the circle (default: 24.0)
  /// - [placeholder]: Optional custom placeholder widget
  /// - [errorWidget]: Optional custom error widget
  ///
  /// Returns a widget that displays the profile image with caching, placeholders, and error handling.
  static Widget loadProfileImage({
    required String? imageUrl,
    double radius = 24.0,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return _buildProfilePlaceholderOrError(
        radius: radius,
        isError: false,
        customWidget: placeholder,
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: radius,
        backgroundImage: imageProvider,
      ),
      placeholder: (context, url) => placeholder ??
          _buildProfilePlaceholderOrError(
            radius: radius,
            isError: false,
          ),
      errorWidget: (context, url, error) => errorWidget ??
          _buildProfilePlaceholderOrError(
            radius: radius,
            isError: true,
          ),
    );
  }

  /// Builds a profile placeholder or error widget
  ///
  /// This method builds a placeholder or error widget for profile images.
  ///
  /// Parameters:
  /// - [radius]: The radius of the circle
  /// - [isError]: Whether to show an error widget or a placeholder
  /// - [customWidget]: Optional custom widget to use instead of the default
  ///
  /// Returns a widget that can be used as a placeholder or error widget for profile images.
  static Widget _buildProfilePlaceholderOrError({
    required double radius,
    required bool isError,
    Widget? customWidget,
  }) {
    return customWidget ??
        CircleAvatar(
          radius: radius,
          backgroundColor: AppColors.baseDarkAlt,
          child: isError
              ? Icon(
                  Icons.person,
                  size: radius * 0.8,
                  color: AppColors.primaryHighlight,
                )
              : SizedBox(
                  width: radius * 0.8,
                  height: radius * 0.8,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryHighlight,
                    ),
                    strokeWidth: 2.0,
                  ),
                ),
        );
  }
}
