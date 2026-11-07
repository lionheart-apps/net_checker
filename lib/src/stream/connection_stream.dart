import 'dart:async';
import '../core/internet_checker.dart';
import '../config/internet_config.dart';
import '../models/connection_status.dart';

/// Provides a reactive stream that monitors internet connectivity.
///
/// Features:
/// ✔ Immediate first check (emits initial status on subscription)
/// ✔ Emits a new [ConnectionStatus] only when state changes
/// ✔ Broadcast stream — allows multiple widgets and listeners without errors
/// ✔ Automatic timer cleanup when all listeners unsubscribe
/// ✔ Safe error handling with fallback to disconnected state
class InternetConnectionStream {
  /// Last known connection status across checks.
  static ConnectionStatus? _lastKnownStatus;

  /// Returns the most recently checked [ConnectionStatus], or `null` if no check has run yet.
  static ConnectionStatus? get currentStatus => _lastKnownStatus;

  /// Starts listening to connectivity changes using the provided [config].
  ///
  /// Returns a broadcast [Stream<ConnectionStatus>].
  ///
  /// Example:
  /// ```dart
  /// final subscription = InternetConnectionStream.start().listen((status) {
  ///   print("Internet status: ${status.label}");
  /// });
  /// ```
  static Stream<ConnectionStatus> start({
    InternetConfig config = const InternetConfig(),
  }) {
    late StreamController<ConnectionStatus> controller;
    Timer? timer;
    ConnectionStatus? last = _lastKnownStatus;
    bool isChecking = false;

    Future<void> check() async {
      if (isChecking) return;
      isChecking = true;

      try {
        final connected = await InternetChecker.hasConnection(config: config);
        final status = connected
            ? ConnectionStatus.connected
            : ConnectionStatus.disconnected;

        _lastKnownStatus = status;

        if (status != last) {
          last = status;
          if (!controller.isClosed) {
            controller.add(status);
          }
        }
      } catch (_) {
        _lastKnownStatus = ConnectionStatus.disconnected;
        if (last != ConnectionStatus.disconnected) {
          last = ConnectionStatus.disconnected;
          if (!controller.isClosed) {
            controller.add(ConnectionStatus.disconnected);
          }
        }
      } finally {
        isChecking = false;
      }
    }

    controller = StreamController<ConnectionStatus>.broadcast(
      onListen: () {
        // If we already have a known status, emit it immediately to this listener
        if (last != null && !controller.isClosed) {
          controller.add(last!);
        }

        // Perform an initial check
        check();

        // Start periodic monitoring
        timer = Timer.periodic(config.checkInterval, (_) {
          check();
        });
      },
      onCancel: () {
        timer?.cancel();
        timer = null;
      },
    );

    return controller.stream;
  }
}
