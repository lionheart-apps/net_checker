import 'dart:async';
import 'dart:js_interop';
import 'package:web/web.dart' as web;
import '../config/internet_config.dart';

/// Web internet checker.
///
/// Uses `navigator.onLine` and lightweight `fetch` probes with `no-cors` mode
/// to verify connectivity without running into cross-origin restrictions.
class InternetCheckerImpl {
  static const String _defaultUrl = "https://clients3.google.com/generate_204";

  /// Checks whether the browser currently has internet connectivity.
  static Future<bool> hasConnection(InternetConfig config) async {
    if (!web.window.navigator.onLine) return false;

    final hosts = config.parsedHosts.isNotEmpty
        ? config.parsedHosts.map((u) => u.toString()).toList()
        : const [_defaultUrl];

    for (final host in hosts) {
      if (await _probe(host, config.timeout)) {
        return true;
      }
    }

    return false;
  }

  /// Returns the first working host, or `null` if offline.
  static Future<String?> getWorkingHost(InternetConfig config) async {
    if (!web.window.navigator.onLine) return null;

    final hosts = config.parsedHosts.isNotEmpty
        ? config.parsedHosts.map((u) => u.toString()).toList()
        : const [_defaultUrl];

    for (final host in hosts) {
      if (await _probe(host, config.timeout)) {
        return Uri.tryParse(host)?.host ?? host;
      }
    }

    return null;
  }

  static Future<bool> _probe(String url, Duration timeout) async {
    try {
      final init = web.RequestInit()
        ..method = 'GET'
        ..cache = 'no-store'
        ..mode = 'no-cors';

      await web.window.fetch(url.toJS, init).toDart.timeout(timeout);
      return true;
    } catch (_) {
      return false;
    }
  }
}
