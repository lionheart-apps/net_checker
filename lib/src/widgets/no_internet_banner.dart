import 'package:flutter/material.dart';

/// A banner widget that displays a message when there is no internet connection.
///
/// [NoInternetBanner] can be placed at the top of your UI to notify users
/// that the device is currently offline.
///
/// The banner becomes visible only when the [visible] property is set to `true`.
/// When `false`, the widget renders an empty space.
class NoInternetBanner extends StatelessWidget {
  /// Controls whether the banner is visible.
  final bool visible;

  /// The message displayed inside the banner.
  final String message;

  /// Background color of the banner
  final Color backgroundColor;

  /// Text style of the message
  final TextStyle textStyle;

  /// Padding inside the banner
  final EdgeInsets padding;

  /// Creates a [NoInternetBanner] widget.
  const NoInternetBanner({
    super.key,
    required this.visible,
    this.message = "No Internet Connection",
    this.backgroundColor = Colors.red,
    this.textStyle = const TextStyle(color: Colors.white),
    this.padding = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: padding,
      child: Text(message, textAlign: TextAlign.center, style: textStyle),
    );
  }
}
