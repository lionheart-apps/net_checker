import 'dart:async';
import 'dart:js_interop';
import 'package:web/web.dart' as web;
import '../config/internet_config.dart';

/// Web implementation of latency checking using fetch (no-cors)
///
/// ✔ Uses real network request (better than fake delay)
/// ✔ No CORS issues
/// ✔ Timeout handled
/// ✔ Works consistently with InternetChecker
///
/// ⚠️ NOTE:
/// - This is still an approximation (browser limitation)
/// - Status/response cannot be read in no-cors mode
class LatencyCheckerImpl {
  static const String _defaultUrl = "https://clients3.google.com/generate_204";

  static Future<int?> getLatency(InternetConfig config) async {
    /// Quick browser check
    if (!web.window.navigator.onLine) return null;

    final url = _defaultUrl;
    ; // config.hosts.isNotEmpty ? config.hosts.first : _defaultUrl;

    final stopwatch = Stopwatch()..start();

    try {
      final init = web.RequestInit()
        ..method = 'GET'
        ..mode = 'no-cors';

      /// Measure real request time
      await web.window.fetch(url.toJS, init).toDart.timeout(config.timeout);

      stopwatch.stop();
      return stopwatch.elapsedMilliseconds;
    } on TimeoutException {
      return null;
    } catch (_) {
      return null;
    }
  }
}
