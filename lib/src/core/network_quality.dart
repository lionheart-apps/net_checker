import 'package:flutter/material.dart';
import 'latency_checker.dart';
import '../config/internet_config.dart';

/// Provides utilities to determine the quality of the network connection.
///
/// The [NetworkQuality] class evaluates network quality based on the
/// latency measured by [LatencyChecker].
///
/// The result is categorized into:
/// - Excellent
/// - Good
/// - Slow
/// - Very Slow
///
/// If latency cannot be measured, the connection is considered "Disconnected".
class NetworkQuality {
  /// Quality labels
  static const String excellent = "Excellent";
  static const String good = "Good";
  static const String slow = "Slow";
  static const String verySlow = "Very Slow";
  static const String disconnected = "Disconnected";

  /// Determines the network quality based on measured latency.
  ///
  /// Returns:
  /// - "Excellent", "Good", "Slow", "Very Slow"
  /// - "Disconnected" if latency fails
  static Future<String> getQuality({
    InternetConfig config = const InternetConfig(),
  }) async {
    final latency = await LatencyChecker.getLatency(config: config);

    if (latency == null) return disconnected;

    if (latency < 100) return excellent;
    if (latency < 300) return good;
    if (latency < 600) return slow;

    return verySlow;
  }

  /// ✅ NEW: Returns a color based on quality label
  ///
  /// This helps UI directly map quality → color.
  ///
  /// Example:
  /// ```dart
  /// final quality = await NetworkQuality.getQuality();
  /// final color = NetworkQuality.getColor(quality);
  /// ```
  static Color getColor(String quality) {
    switch (quality) {
      case excellent:
        return Colors.green;

      case good:
        return Colors.lightGreen;

      case slow:
        return Colors.orange;

      case verySlow:
        return Colors.red;

      case disconnected:
      default:
        return Colors.grey;
    }
  }

  /// ✅ OPTIONAL: Direct latency → color (without calling getQuality)
  ///
  /// Useful if you already have latency value.
  static Color getColorFromLatency(int? latency) {
    if (latency == null) return Colors.grey;

    if (latency < 100) return Colors.green;
    if (latency < 300) return Colors.orange;
    if (latency < 600) return Colors.deepOrange;

    return Colors.red;
  }
}
