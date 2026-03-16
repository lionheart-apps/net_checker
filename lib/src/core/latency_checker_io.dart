import 'dart:io';
import '../config/internet_config.dart';

/// IO implementation of latency checking.
///
/// This runs on:
/// Android, iOS, Windows, macOS, Linux
class LatencyCheckerImpl {
  /// Measures latency using DNS lookup.
  static Future<int?> getLatency(InternetConfig config) async {
    final stopwatch = Stopwatch()..start();

    try {
      await InternetAddress.lookup(config.latencyHost);

      stopwatch.stop();

      return stopwatch.elapsedMilliseconds;
    } catch (_) {
      return null;
    }
  }
}
