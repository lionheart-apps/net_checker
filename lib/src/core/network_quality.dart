import 'package:flutter/material.dart';
import 'latency_checker.dart';
import '../config/internet_config.dart';

/// Strongly-typed network quality classification.
enum NetworkQualityLevel {
  /// Extremely low latency (< 100ms), optimal for streaming and real-time operations.
  excellent,

  /// Low latency (< 300ms), suitable for standard browsing and API requests.
  good,

  /// Moderate latency (< 600ms), slower loading times.
  slow,

  /// High latency (>= 600ms), noticeable lag and buffering.
  verySlow,

  /// Offline or unreachable.
  disconnected;

  /// User-friendly label for this quality level.
  String get label {
    switch (this) {
      case NetworkQualityLevel.excellent:
        return "Excellent";
      case NetworkQualityLevel.good:
        return "Good";
      case NetworkQualityLevel.slow:
        return "Slow";
      case NetworkQualityLevel.verySlow:
        return "Very Slow";
      case NetworkQualityLevel.disconnected:
        return "Disconnected";
    }
  }

  /// Representative theme color for this quality level.
  Color get color {
    switch (this) {
      case NetworkQualityLevel.excellent:
        return Colors.green;
      case NetworkQualityLevel.good:
        return Colors.lightGreen;
      case NetworkQualityLevel.slow:
        return Colors.orange;
      case NetworkQualityLevel.verySlow:
        return Colors.red;
      case NetworkQualityLevel.disconnected:
        return Colors.grey;
    }
  }
}

/// Provides utilities to determine the quality of the network connection.
///
/// Evaluates network quality based on measured latency:
/// - `< 100ms`: Excellent
/// - `< 300ms`: Good
/// - `< 600ms`: Slow
/// - `>= 600ms`: Very Slow
/// - `null`: Disconnected
class NetworkQuality {
  /// Quality labels (kept for backward compatibility)
  static const String excellent = "Excellent";
  static const String good = "Good";
  static const String slow = "Slow";
  static const String verySlow = "Very Slow";
  static const String disconnected = "Disconnected";

  /// Determines the network quality level enum based on measured latency.
  static Future<NetworkQualityLevel> getQualityLevel({
    InternetConfig config = const InternetConfig(),
  }) async {
    final latency = await LatencyChecker.getLatency(config: config);
    return getLevelFromLatency(latency);
  }

  /// Converts a numeric latency (in ms) to a [NetworkQualityLevel].
  static NetworkQualityLevel getLevelFromLatency(int? latency) {
    if (latency == null) return NetworkQualityLevel.disconnected;
    if (latency < 100) return NetworkQualityLevel.excellent;
    if (latency < 300) return NetworkQualityLevel.good;
    if (latency < 600) return NetworkQualityLevel.slow;
    return NetworkQualityLevel.verySlow;
  }

  /// Determines the network quality string label based on measured latency.
  ///
  /// Returns "Excellent", "Good", "Slow", "Very Slow", or "Disconnected".
  static Future<String> getQuality({
    InternetConfig config = const InternetConfig(),
  }) async {
    final level = await getQualityLevel(config: config);
    return level.label;
  }

  /// Returns a [Color] corresponding to a quality label string.
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

  /// Directly maps latency (in ms) to a corresponding [Color].
  static Color getColorFromLatency(int? latency) {
    return getLevelFromLatency(latency).color;
  }
}
