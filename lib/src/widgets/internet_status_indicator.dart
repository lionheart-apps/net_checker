import 'package:flutter/material.dart';
import '../config/internet_config.dart';
import '../models/connection_status.dart';
import 'internet_status_builder.dart';

/// A widget that displays an icon indicating the current internet connection status.
///
/// Shows a connected icon (default: [Icons.wifi], green) when online, and a
/// disconnected icon (default: [Icons.wifi_off], red) when offline.
///
/// Example:
/// ```dart
/// const InternetStatusIndicator(size: 28);
/// ```
class InternetStatusIndicator extends StatelessWidget {
  /// Optional configuration for connectivity checks.
  final InternetConfig config;

  /// Icon to display when connected.
  final IconData connectedIcon;

  /// Icon to display when disconnected.
  final IconData disconnectedIcon;

  /// Icon color when connected.
  final Color connectedColor;

  /// Icon color when disconnected.
  final Color disconnectedColor;

  /// The size of the icon in logical pixels.
  final double size;

  /// Optional custom stream to listen to.
  final Stream<ConnectionStatus>? stream;

  /// Fallback status before the first connection check resolves.
  final ConnectionStatus? initialStatus;

  /// Creates an [InternetStatusIndicator].
  const InternetStatusIndicator({
    super.key,
    this.config = const InternetConfig(),
    this.connectedIcon = Icons.wifi,
    this.disconnectedIcon = Icons.wifi_off,
    this.connectedColor = Colors.green,
    this.disconnectedColor = Colors.red,
    this.size = 24,
    this.stream,
    this.initialStatus,
  });

  @override
  Widget build(BuildContext context) {
    return InternetStatusBuilder(
      config: config,
      stream: stream,
      initialStatus: initialStatus,
      builder: (context, status) {
        final isConnected = status.isConnected;
        return Icon(
          isConnected ? connectedIcon : disconnectedIcon,
          color: isConnected ? connectedColor : disconnectedColor,
          size: size,
        );
      },
    );
  }
}
