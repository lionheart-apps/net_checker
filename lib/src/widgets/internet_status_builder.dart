import 'package:flutter/material.dart';
import '../stream/connection_stream.dart';
import '../models/connection_status.dart';

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
///
/// Example:
/// ```dart
/// InternetStatusBuilder(
///   builder: (context, status) {
///     if (status == ConnectionStatus.connected) {
///       return Text("Connected");
///     } else {
///       return Text("No Internet");
///     }
///   },
/// )
/// ```
class InternetStatusBuilder extends StatelessWidget {
  /// Callback used to build the UI based on the current [ConnectionStatus].
  ///
  /// The builder receives the current connectivity status and should return
  /// a widget that represents that state in the UI.
  final Widget Function(BuildContext, ConnectionStatus) builder;

  /// Creates an [InternetStatusBuilder].
  ///
  /// The [builder] parameter must not be null.
  const InternetStatusBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: InternetConnectionStream.start(),
      builder: (context, snapshot) {
        final status = snapshot.data ?? ConnectionStatus.disconnected;

        return builder(context, status);
      },
    );
  }
}
