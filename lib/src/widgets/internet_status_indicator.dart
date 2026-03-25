import 'package:flutter/material.dart';
import '../models/connection_status.dart';
import '../stream/connection_stream.dart';
import '../config/internet_config.dart';

/// A widget that displays a visual indicator of the current internet status.
///
/// [InternetStatusIndicator] listens to the connectivity stream provided by
/// [InternetConnectionStream.start] and displays an icon representing the
/// current connection state.
///
/// When the device is connected to the internet, a **green WiFi icon**
/// is displayed. When the device is offline, a **red WiFi-off icon**
/// is shown.
class InternetStatusIndicator extends StatelessWidget {
  /// Optional configuration for connectivity checks.
  final InternetConfig config;

  /// Icon when connected
  final IconData connectedIcon;

  /// Icon when disconnected
  final IconData disconnectedIcon;

  /// Color when connected
  final Color connectedColor;

  /// Color when disconnected
  final Color disconnectedColor;

  /// Icon size
  final double size;

  /// Creates an [InternetStatusIndicator] widget.
  const InternetStatusIndicator({
    super.key,
    this.config = const InternetConfig(),
    this.connectedIcon = Icons.wifi,
    this.disconnectedIcon = Icons.wifi_off,
    this.connectedColor = Colors.green,
    this.disconnectedColor = Colors.red,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectionStatus>(
      stream: InternetConnectionStream.start(config: config),
      builder: (context, snapshot) {
        final status = snapshot.data ?? ConnectionStatus.disconnected;

        final isConnected = status == ConnectionStatus.connected;

        return Icon(
          isConnected ? connectedIcon : disconnectedIcon,
          color: isConnected ? connectedColor : disconnectedColor,
          size: size,
        );
      },
    );
  }
}
