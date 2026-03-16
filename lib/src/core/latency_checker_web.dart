import 'package:http/http.dart' as http;
import '../config/internet_config.dart';

/// Web implementation of latency checking.
///
/// Browsers do not support `dart:io`, so we measure latency
/// using an HTTP request instead.
class LatencyCheckerImpl {
  /// Measures latency by performing a simple HTTP request.
  static Future<int?> getLatency(InternetConfig config) async {
    final stopwatch = Stopwatch()..start();

    try {
      await http
          .get(Uri.parse("https://${config.latencyHost}"))
          .timeout(config.timeout);

      stopwatch.stop();

      return stopwatch.elapsedMilliseconds;
    } catch (_) {
      return null;
    }
  }
}
