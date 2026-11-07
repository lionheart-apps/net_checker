import 'dart:io';
import '../config/internet_config.dart';

/// IO implementation of latency checking.
///
/// Supported platforms:
/// - Android
/// - iOS
/// - Windows
/// - macOS
/// - Linux
///
/// Measures network round-trip time (RTT) using a quick TCP handshake,
/// with automatic fallback to DNS lookup resolution latency.
class LatencyCheckerImpl {
  /// Measures latency to the configured host.
  ///
  /// Returns:
  /// - latency in milliseconds
  /// - `null` if the check failed or timed out
  static Future<int?> getLatency(InternetConfig config) async {
    final uri = config.parsedLatencyHost;
    if (uri == null || uri.host.isEmpty) return null;

    final port = uri.port != 0 ? uri.port : 443;
    final stopwatch = Stopwatch()..start();

    try {
      // 1. Direct TCP handshake to measure true RTT
      final socket = await Socket.connect(
        uri.host,
        port,
        timeout: config.timeout,
      );
      stopwatch.stop();
      socket.destroy();
      return stopwatch.elapsedMilliseconds;
    } catch (_) {
      // 2. Fallback to DNS resolution latency
      try {
        stopwatch.reset();
        stopwatch.start();
        final addresses = await InternetAddress.lookup(
          uri.host,
        ).timeout(config.timeout);
        stopwatch.stop();
        if (addresses.isNotEmpty) {
          return stopwatch.elapsedMilliseconds;
        }
      } catch (_) {}
      return null;
    }
  }
}
