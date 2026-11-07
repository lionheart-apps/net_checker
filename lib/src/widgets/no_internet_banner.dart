import 'package:flutter/material.dart';

/// A banner widget that notifies users when there is no internet connection.
///
/// Smoothly transitions in and out based on the [visible] property.
///
/// Example:
/// ```dart
/// NoInternetBanner(visible: !isConnected)
/// ```
class NoInternetBanner extends StatelessWidget {
  /// Controls whether the banner is visible.
  final bool visible;

  /// The message text displayed inside the banner.
  final String message;

  /// Background color of the banner.
  final Color backgroundColor;

  /// Text style of the message.
  final TextStyle textStyle;

  /// Padding inside the banner.
  final EdgeInsets padding;

  /// Optional leading icon.
  final IconData? icon;

  /// Color of the leading icon (defaults to text color or white).
  final Color? iconColor;

  /// Whether to smoothly animate visibility changes.
  final bool animated;

  /// Duration of the visibility animation.
  final Duration animationDuration;

  /// Creates a [NoInternetBanner] widget.
  const NoInternetBanner({
    super.key,
    required this.visible,
    this.message = "No Internet Connection",
    this.backgroundColor = Colors.red,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    this.icon = Icons.wifi_off,
    this.iconColor,
    this.animated = true,
    this.animationDuration = const Duration(milliseconds: 250),
  });

  @override
  Widget build(BuildContext context) {
    final bannerContent = Container(
      key: const ValueKey("no_internet_banner_content"),
      width: double.infinity,
      color: backgroundColor,
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 18,
              color: iconColor ?? textStyle.color ?? Colors.white,
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          ),
        ],
      ),
    );

    if (!animated) {
      return visible ? bannerContent : const SizedBox.shrink();
    }

    return AnimatedSwitcher(
      duration: animationDuration,
      transitionBuilder: (child, animation) {
        return SizeTransition(
          sizeFactor: animation,
          // ignore: deprecated_member_use
          axisAlignment: -1.0,
          child: child,
        );
      },
      child: visible ? bannerContent : const SizedBox.shrink(key: ValueKey("hidden")),
    );
  }
}
