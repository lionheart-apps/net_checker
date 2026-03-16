import 'latency_checker.dart';
import '../config/internet_config.dart';

/// Provides utilities to determine the quality of the network connection.
///
/// The [NetworkQuality] class evaluates network quality based on the
/// latency measured by [LatencyChecker]. The result is categorized into
/// human-readable levels such as **Excellent**, **Good**, **Slow**, or
/// **Very Slow**.
///
/// If latency cannot be measured, the connection is considered
/// **Disconnected**.
class NetworkQuality {
  /// Determines the network quality based on measured latency.
  ///
  /// The method measures latency using [LatencyChecker.getLatency]
  /// and maps the latency value to a quality category:
  ///
  /// | Latency (ms) | Quality |
  /// |---------------|--------|
  /// | < 100         | Excellent |
  /// | < 300         | Good |
  /// | < 600         | Slow |
  /// | >= 600        | Very Slow |
  ///
  /// Returns a string representing the network quality.
  ///
  /// Returns `"Disconnected"` if latency cannot be determined.
  ///
  /// Example:
  /// ```dart
  /// String quality = await NetworkQuality.getQuality();
  /// print("Network quality: $quality");
  /// ```
  ///
  /// A custom configuration can also be provided:
  ///
  /// ```dart
  /// final config = InternetConfig(
  ///   latencyHost: "example.com",
  /// );
  ///
  /// String quality = await NetworkQuality.getQuality(config: config);
  /// ```
  static Future<String> getQuality({
    InternetConfig config = const InternetConfig(),
  }) async {
    final latency = await LatencyChecker.getLatency(config: config);

    if (latency == null) return "Disconnected";

    if (latency < 100) return "Excellent";

    if (latency < 300) return "Good";

    if (latency < 600) return "Slow";

    return "Very Slow";
  }
}
