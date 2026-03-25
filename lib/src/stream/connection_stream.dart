import 'dart:async';
import '../core/internet_checker.dart';
import '../config/internet_config.dart';
import '../models/connection_status.dart';

/// Provides a stream that monitors internet connectivity.
///
/// Emits a new [ConnectionStatus] ONLY when the state changes.
///
/// ✔ Immediate first check (no delay on app start)
/// ✔ Periodic checks using [checkInterval]
/// ✔ Prevents duplicate emissions
/// ✔ Safe fallback to disconnected on errors
/// ✔ Automatically stops when no listeners
class InternetConnectionStream {
  /// Starts listening to connectivity changes.
  ///
  /// Example:
  /// ```dart
  /// InternetConnectionStream.start().listen((status) {
  ///   print(status);
  /// });
  /// ```
  static Stream<ConnectionStatus> start({
    InternetConfig config = const InternetConfig(),
  }) {
    late StreamController<ConnectionStatus> controller;
    Timer? timer;

    /// Holds last emitted state to avoid duplicate events
    ConnectionStatus last = ConnectionStatus.disconnected;

    /// 🔥 Core check logic (single source of truth)
    Future<void> check() async {
      try {
        /// Perform actual connectivity check
        final connected = await InternetChecker.hasConnection(config: config);

        /// Map boolean to enum
        final status = connected
            ? ConnectionStatus.connected
            : ConnectionStatus.disconnected;

        /// Emit ONLY if status changed
        if (status != last) {
          last = status;
          controller.add(status);
        }
      } catch (_) {
        /// If any error occurs, treat as disconnected
        if (last != ConnectionStatus.disconnected) {
          last = ConnectionStatus.disconnected;
          controller.add(ConnectionStatus.disconnected);
        }
      }
    }

    controller = StreamController<ConnectionStatus>(
      /// Called when first listener subscribes
      onListen: () {
        /// 🔥 1. Immediate check (fixes startup delay issue)
        check();

        /// 🔥 2. Periodic check (fallback polling)
        timer = Timer.periodic(config.checkInterval, (_) {
          check();
        });
      },

      /// Called when all listeners are removed
      onCancel: () {
        /// Clean up timer to prevent memory leaks
        timer?.cancel();
      },
    );

    return controller.stream;
  }
}
