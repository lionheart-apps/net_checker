import '../config/internet_config.dart';

import 'latency_checker_io.dart'
    if (dart.library.html) 'latency_checker_web.dart';

/// Provides utilities for measuring network latency.
///
/// This class automatically selects the correct implementation
/// depending on the platform (IO or Web).
class LatencyChecker {
  /// Measures latency to the configured host.
  ///
  /// Returns latency in milliseconds or null if measurement fails.
  static Future<int?> getLatency({
    InternetConfig config = const InternetConfig(),
  }) async {
    return LatencyCheckerImpl.getLatency(config);
  }
}
