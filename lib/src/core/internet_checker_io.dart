import 'dart:io';
import '../config/internet_config.dart';

/// IO implementation of the internet connectivity checker.
///
/// Supported platforms:
/// - Android
/// - iOS
/// - Windows
/// - macOS
/// - Linux
///
/// Uses DNS lookup to verify internet access.
///
/// This implementation relies on [InternetConfig.parsedHosts]
/// so all hosts are already normalized and safe to use.
class InternetCheckerImpl {
  /// Checks whether the device has internet connectivity.
  ///
  /// Strategy:
  /// - Extract host from parsed Uri
  /// - Perform DNS lookup
  /// - Return true on first success
  ///
  /// Returns:
  /// - `true` if at least one host resolves
  /// - `false` otherwise
  static Future<bool> hasConnection(InternetConfig config) async {
    for (final uri in config.parsedHosts) {
      try {
        final host = uri.host;
        if (host.isEmpty) continue;

        // 1️⃣ DNS lookup
        final result = await InternetAddress.lookup(
          host,
        ).timeout(config.timeout);

        if (result.isEmpty) continue;

        // 2️⃣ HTTP check (important)
        final client = HttpClient()..connectionTimeout = config.timeout;

        final request = await client.getUrl(uri);
        final response = await request.close();

        if (response.statusCode >= 200 && response.statusCode < 400) {
          client.close();
          return true;
        }

        client.close();
      } catch (_) {
        // try next host
      }
    }

    return false;
  }

  static Future<String?> getWorkingHost(InternetConfig config) async {
    for (final uri in config.parsedHosts) {
      try {
        final host = uri.host;
        if (host.isEmpty) continue;

        final result = await InternetAddress.lookup(
          host,
        ).timeout(config.timeout);

        if (result.isNotEmpty) {
          return host; // ✅ return working host
        }
      } catch (_) {}
    }

    return null;
  }
}
