import 'dart:io';
import '../config/internet_config.dart';

class LatencyChecker {
  static Future<int?> getLatency({
    InternetConfig config = const InternetConfig(),
  }) async {
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
