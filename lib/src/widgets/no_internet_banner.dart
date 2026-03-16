import 'package:flutter/material.dart';

/// A banner widget that displays a message when there is no internet connection.
///
/// [NoInternetBanner] can be placed at the top of your UI to notify users
/// that the device is currently offline.
///
/// The banner becomes visible only when the [visible] property is set to `true`.
/// When `false`, the widget renders an empty space.
///
/// Example:
/// ```dart
/// NoInternetBanner(
///   visible: true,
/// )
/// ```
///
/// Custom message example:
/// ```dart
/// NoInternetBanner(
///   visible: true,
///   message: "You're currently offline",
/// )
/// ```
class NoInternetBanner extends StatelessWidget {
  /// Controls whether the banner is visible.
  ///
  /// If `true`, the banner will be displayed.
  /// If `false`, an empty widget will be rendered.
  final bool visible;

  /// The message displayed inside the banner.
  ///
  /// Defaults to `"No Internet Connection"`.
  final String message;

  /// Creates a [NoInternetBanner] widget.
  ///
  /// The [visible] parameter determines whether the banner
  /// should be shown.
  const NoInternetBanner({
    super.key,
    required this.visible,
    this.message = "No Internet Connection",
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox();

    return Container(
      width: double.infinity,
      color: Colors.red,
      padding: const EdgeInsets.all(8),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
