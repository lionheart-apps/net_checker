import 'package:flutter/material.dart';
import '../stream/connection_stream.dart';
import '../models/connection_status.dart';
import '../config/internet_config.dart';

/// A widget that rebuilds its UI based on internet connectivity changes.
///
/// [InternetStatusBuilder] listens to the connectivity stream provided by
/// [InternetConnectionStream.start] and rebuilds its child whenever the
/// connection status changes.
///
/// It works similarly to [StreamBuilder], but provides a simplified API
/// specifically for internet connectivity.
///
/// The [builder] callback receives the current [ConnectionStatus] and
/// returns the widget that should be displayed.
class InternetStatusBuilder extends StatelessWidget {
  /// Callback used to build the UI based on the current [ConnectionStatus].
  final Widget Function(BuildContext, ConnectionStatus) builder;

  /// Optional configuration for connectivity checks.
  final InternetConfig config;

  /// Creates an [InternetStatusBuilder].
  ///
  /// The [builder] parameter must not be null.
  const InternetStatusBuilder({
    super.key,
    required this.builder,
    this.config = const InternetConfig(),
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectionStatus>(
      stream: InternetConnectionStream.start(config: config),
      builder: (context, snapshot) {
        final status = snapshot.data ?? ConnectionStatus.disconnected;
        return builder(context, status);
      },
    );
  }
}
