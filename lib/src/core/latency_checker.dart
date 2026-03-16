import 'dart:io';
import '../config/internet_config.dart';

/// Provides utilities for measuring network latency.
///
/// The [LatencyChecker] measures the time taken to resolve a host
/// defined in [InternetConfig.latencyHost]. This duration represents
/// an approximate network latency between the device and the host.
///
/// If the host cannot be resolved, the method returns `null`.
class LatencyChecker {
  /// Measures network latency to the configured host.
  ///
  /// The latency is calculated by resolving the host defined in
  /// [InternetConfig.latencyHost] and measuring the elapsed time.
  ///
  /// Returns the latency in **milliseconds**, or `null` if the host
  /// cannot be resolved.
  ///
  /// Example:
  /// ```dart
  /// int? latency = await LatencyChecker.getLatency();
  ///
  /// if (latency != null) {
  ///   print("Latency: ${latency} ms");
  /// } else {
  ///   print("Unable to measure latency");
  /// }
  /// ```
  ///
  /// A custom configuration can also be provided:
  ///
  /// ```dart
  /// final config = InternetConfig(
  ///   latencyHost: "example.com",
  /// );
  ///
  /// int? latency = await LatencyChecker.getLatency(config: config);
  /// ```
  static Future<int?> getLatency({
    InternetConfig config = const InternetConfig(),
  }) async {
    final stopwatch = Stopwatch()..start();

    try {
      await InternetAddress.lookup(config.latencyHost);

      stopwatch.stop();

      return stopwatch.elapsedMilliseconds;
    } catch (_) {
      return null;
    }
  }
}
