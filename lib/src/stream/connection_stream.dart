import 'dart:async';
import '../core/internet_checker.dart';
import '../config/internet_config.dart';
import '../models/connection_status.dart';

/// Provides a stream that continuously monitors internet connectivity.
///
/// The [InternetConnectionStream] periodically checks the internet
/// connection status using [InternetChecker.hasConnection] and emits
/// updates whenever the connection state changes.
///
/// This allows applications to react in real-time when the device
/// connects to or disconnects from the internet.
class InternetConnectionStream {
  /// Starts monitoring the internet connection.
  ///
  /// The method returns a [Stream] that emits [ConnectionStatus] values
  /// whenever the connectivity state changes.
  ///
  /// The check interval and hosts used for connectivity verification
  /// are controlled by the provided [config].
  ///
  /// Example:
  /// ```dart
  /// InternetConnectionStream.start().listen((status) {
  ///   if (status == ConnectionStatus.connected) {
  ///     print("Internet connected");
  ///   } else {
  ///     print("Internet disconnected");
  ///   }
  /// });
  /// ```
  ///
  /// A custom configuration can also be provided:
  ///
  /// ```dart
  /// final config = InternetConfig(
  ///   checkInterval: Duration(seconds: 3),
  /// );
  ///
  /// InternetConnectionStream.start(config: config)
  ///     .listen((status) {
  ///       print(status);
  ///     });
  /// ```
  static Stream<ConnectionStatus> start({
    InternetConfig config = const InternetConfig(),
  }) async* {
    ConnectionStatus last = ConnectionStatus.disconnected;

    while (true) {
      final connected = await InternetChecker.hasConnection(config: config);

      final status = connected
          ? ConnectionStatus.connected
          : ConnectionStatus.disconnected;

      if (status != last) {
        last = status;
        yield status;
      }

      await Future.delayed(config.checkInterval);
    }
  }
}
