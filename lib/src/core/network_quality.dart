import 'latency_checker.dart';
import '../config/internet_config.dart';

class NetworkQuality {
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
