import 'dart:async';
import 'package:flutter/material.dart';
import '../stream/connection_stream.dart';
import '../models/connection_status.dart';
import '../config/internet_config.dart';

/// A widget that rebuilds its child whenever internet connectivity changes.
///
/// Efficiently manages its subscription lifecycle so that parent rebuilds do not
/// inadvertently spawn new connection streams or timers.
///
/// Example:
/// ```dart
/// InternetStatusBuilder(
///   builder: (context, status) {
///     return Text(status.label);
///   },
/// )
/// ```
class InternetStatusBuilder extends StatefulWidget {
  /// Callback used to build the UI based on the current [ConnectionStatus].
  final Widget Function(BuildContext context, ConnectionStatus status) builder;

  /// Optional configuration for connectivity checks.
  final InternetConfig config;

  /// Fallback status before the first connection check resolves.
  ///
  /// Defaults to [InternetConnectionStream.currentStatus] or [ConnectionStatus.disconnected].
  final ConnectionStatus? initialStatus;

  /// Optional custom stream to listen to (e.g. for testing or custom controllers).
  ///
  /// If omitted, defaults to [InternetConnectionStream.start].
  final Stream<ConnectionStatus>? stream;

  /// Creates an [InternetStatusBuilder].
  const InternetStatusBuilder({
    super.key,
    required this.builder,
    this.config = const InternetConfig(),
    this.initialStatus,
    this.stream,
  });

  @override
  State<InternetStatusBuilder> createState() => _InternetStatusBuilderState();
}

class _InternetStatusBuilderState extends State<InternetStatusBuilder> {
  late ConnectionStatus _status;
  StreamSubscription<ConnectionStatus>? _subscription;

  @override
  void initState() {
    super.initState();
    _status = widget.initialStatus ??
        InternetConnectionStream.currentStatus ??
        ConnectionStatus.disconnected;
    _subscribe();
  }

  @override
  void didUpdateWidget(covariant InternetStatusBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.stream != oldWidget.stream || widget.config != oldWidget.config) {
      _subscription?.cancel();
      _subscribe();
    }
  }

  void _subscribe() {
    final stream = widget.stream ??
        InternetConnectionStream.start(config: widget.config);

    _subscription = stream.listen((status) {
      if (mounted && _status != status) {
        setState(() {
          _status = status;
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _status);
  }
}
