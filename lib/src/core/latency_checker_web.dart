import 'dart:async';
import 'dart:js_interop';
import 'package:web/web.dart' as web;
import '../config/internet_config.dart';

/// Web implementation of latency checking using fetch (`no-cors`).
class LatencyCheckerImpl {
  static const String _defaultUrl = "https://clients3.google.com/generate_204";

  /// Measures round-trip fetch latency in the browser.
  static Future<int?> getLatency(InternetConfig config) async {
    if (!web.window.navigator.onLine) return null;

    final targetUrl = config.parsedLatencyHost?.toString() ?? _defaultUrl;
    final stopwatch = Stopwatch()..start();

    try {
      final init = web.RequestInit()
        ..method = 'GET'
        ..cache = 'no-store'
        ..mode = 'no-cors';

      await web.window.fetch(targetUrl.toJS, init).toDart.timeout(config.timeout);
      stopwatch.stop();
      return stopwatch.elapsedMilliseconds;
    } on TimeoutException {
      return null;
    } catch (_) {
      return null;
    }
  }
}
