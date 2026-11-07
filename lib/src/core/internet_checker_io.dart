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
/// Uses DNS resolution and lightweight HTTP probing to verify real internet access.
class InternetCheckerImpl {
  /// Checks whether the device has internet connectivity.
  ///
  /// Strategy:
  /// - Extract host from parsed [Uri]
  /// - Perform DNS lookup
  /// - Probe endpoint via HTTP GET/HEAD
  /// - Return `true` on first confirmed reachability
  static Future<bool> hasConnection(InternetConfig config) async {
    for (final uri in config.parsedHosts) {
      if (await _testHost(uri, config.timeout)) {
        return true;
      }
    }
    return false;
  }

  /// Returns the first working host string, or `null` if no connection is available.
  static Future<String?> getWorkingHost(InternetConfig config) async {
    for (final uri in config.parsedHosts) {
      if (await _testHost(uri, config.timeout)) {
        return uri.host;
      }
    }
    return null;
  }

  static Future<bool> _testHost(Uri uri, Duration timeout) async {
    final host = uri.host;
    if (host.isEmpty) return false;

    HttpClient? client;
    try {
      // 1. DNS resolution
      final addresses = await InternetAddress.lookup(host).timeout(timeout);
      if (addresses.isEmpty) return false;

      // 2. HTTP probe to verify real transit / bypass captive portals
      client = HttpClient()..connectionTimeout = timeout;
      final request = await client.getUrl(uri).timeout(timeout);
      final response = await request.close().timeout(timeout);

      // Drain response body to release resources immediately
      await response.drain<void>().timeout(
            timeout,
            onTimeout: () => null,
          );

      return response.statusCode >= 200 && response.statusCode < 400;
    } catch (_) {
      return false;
    } finally {
      client?.close(force: true);
    }
  }
}
