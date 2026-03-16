import 'dart:io';
import '../config/internet_config.dart';

/// IO implementation of the internet connectivity checker.
///
/// This version is used on:
/// - Android
/// - iOS
/// - Windows
/// - macOS
/// - Linux
///
/// It performs a DNS lookup using `InternetAddress.lookup`
/// to verify internet connectivity.
class InternetCheckerImpl {
  /// Checks whether the device has internet connectivity.
  ///
  /// The method attempts to resolve each host defined in
  /// [InternetConfig.hosts]. If at least one host resolves,
  /// the connection is considered available.
  static Future<bool> hasConnection(InternetConfig config) async {
    for (final host in config.hosts) {
      try {
        final result = await InternetAddress.lookup(
          host,
        ).timeout(config.timeout);

        if (result.isNotEmpty) {
          return true;
        }
      } catch (_) {}
    }

    return false;
  }
}
