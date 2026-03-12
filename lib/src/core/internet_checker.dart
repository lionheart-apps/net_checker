import 'dart:io';
import '../config/internet_config.dart';

class InternetChecker {
  static Future<bool> hasConnection({
    InternetConfig config = const InternetConfig(),
  }) async {
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
