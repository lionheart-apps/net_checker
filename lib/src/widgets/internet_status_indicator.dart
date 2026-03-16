import 'package:flutter/material.dart';
import '../models/connection_status.dart';
import '../stream/connection_stream.dart';

/// A widget that displays a visual indicator of the current internet status.
///
/// [InternetStatusIndicator] listens to the connectivity stream provided by
/// [InternetConnectionStream.start] and displays an icon representing the
/// current connection state.
///
/// When the device is connected to the internet, a **green WiFi icon**
/// is displayed. When the device is offline, a **red WiFi-off icon**
/// is shown.
///
/// This widget is useful for quickly showing connectivity status
/// in the UI without manually handling streams.
///
/// Example:
/// ```dart
/// InternetStatusIndicator()
/// ```
class InternetStatusIndicator extends StatelessWidget {
  /// Creates an [InternetStatusIndicator] widget.
  const InternetStatusIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: InternetConnectionStream.start(),
      builder: (context, snapshot) {
        final status = snapshot.data ?? ConnectionStatus.disconnected;

        return Icon(
          status == ConnectionStatus.connected ? Icons.wifi : Icons.wifi_off,
          color: status == ConnectionStatus.connected
              ? Colors.green
              : Colors.red,
        );
      },
    );
  }
}
