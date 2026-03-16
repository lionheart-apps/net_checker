import 'package:http/http.dart' as http;
import '../config/internet_config.dart';

/// Web implementation of the internet connectivity checker.
///
/// Browsers do not support `dart:io`, so DNS lookups are not possible.
/// Instead, we perform a simple HTTP request to verify internet access.
class InternetCheckerImpl {
  /// Attempts to reach a host using an HTTP request.
  ///
  /// Returns `true` if the request succeeds, otherwise `false`.
  static Future<bool> hasConnection(InternetConfig config) async {
    try {
      final response = await http
          .get(Uri.parse("https://${config.hosts.first}"))
          .timeout(config.timeout);

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
