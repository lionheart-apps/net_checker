import 'dart:async';
import 'dart:js_interop';
import 'package:web/web.dart' as web;
import '../config/internet_config.dart';

/// Web internet checker (Lightweight mode)
///
/// ✔ No CORS issues (uses no-cors)
/// ✔ No backend required
/// ✔ Very fast
/// ✔ Works for basic online/offline detection
///
/// ⚠️ LIMITATIONS:
/// - Uses navigator.onLine + fetch attempt
/// - Does NOT verify real internet access
/// - May return TRUE in:
///   - captive portals
///   - restricted networks
///   - partial connectivity
///
/// 💡 This is a "best-effort" check for Web platform
class InternetCheckerImpl {
  /// Default reliable endpoint
  static const String _defaultUrl = "https://clients3.google.com/generate_204";

  static Future<bool> hasConnection(InternetConfig config) async {
    if (!web.window.navigator.onLine) return false;

    final hosts = [
      _defaultUrl,
    ]; // config.hosts.isNotEmpty ? config.hosts : [_defaultUrl];

    for (final host in hosts) {
      try {
        final init = web.RequestInit()
          ..method = 'GET'
          ..cache = 'no-store'
          ..mode = 'no-cors';

        await web.window.fetch(host.toJS, init).toDart.timeout(config.timeout);

        return true; // first success wins
      } catch (_) {
        // try next host
      }
    }

    return false;
  }

  static Future<String?> getWorkingHost(InternetConfig config) async {
    final ok = await hasConnection(config);

    if (!ok) return null;

    return _defaultUrl; // config.hosts.isNotEmpty ? config.hosts.first : "web";
  }
}
