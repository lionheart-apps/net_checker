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
/// Uses DNS lookup to measure latency.
class LatencyCheckerImpl {
  /// Measures latency using DNS lookup.
  ///
  /// Returns:
  /// - latency in milliseconds
  /// - `null` if failed
  static Future<int?> getLatency(InternetConfig config) async {
    final uri = config.parsedLatencyHost;

    if (uri == null || uri.host.isEmpty) return null;

    final stopwatch = Stopwatch()..start();

    try {
      await InternetAddress.lookup(uri.host).timeout(config.timeout);

      stopwatch.stop();

      return stopwatch.elapsedMilliseconds;
    } catch (_) {
      return null;
    }
  }
}
