/// Configuration settings used by the internet checking utilities.
///
/// This class ensures all hosts are converted into a **valid usable format**
/// so other classes can directly use them without extra checks.
///
/// Supports inputs like:
/// - google.com
/// - http://google.com
/// - https://google.com
/// - 1.1.1.1
///
/// Output will ALWAYS be:
/// - Proper Uri (with scheme)
class InternetConfig {
  /// Raw hosts provided by user
  final List<String> hosts;

  /// Timeout for requests
  final Duration timeout;

  /// Interval for stream checks
  final Duration checkInterval;

  /// Host used for latency
  final String latencyHost;

  const InternetConfig({
    this.hosts = const [
      "google.com",
      "lionheartapps.com",
      "1.1.1.1",
      "8.8.8.8",
    ],
    this.timeout = const Duration(seconds: 3),
    this.checkInterval = const Duration(seconds: 5),
    this.latencyHost = "google.com",
  });

  /// ✅ FINAL: Always return valid URIs
  ///
  /// Rules:
  /// - If scheme exists → keep it
  /// - If missing → default to http
  /// - Remove trailing slash
  /// - Skip invalid values
  List<Uri> get parsedHosts {
    return hosts
        .map((host) {
          var h = host.trim();

          if (h.isEmpty) return null;

          // remove trailing slash
          if (h.endsWith('/')) {
            h = h.substring(0, h.length - 1);
          }

          Uri? uri = Uri.tryParse(h);

          // If no scheme → add http
          if (uri == null || uri.scheme.isEmpty) {
            uri = Uri.tryParse("http://$h");
          }

          return uri;
        })
        .whereType<Uri>()
        .toList();
  }

  /// ✅ Parsed latency host
  Uri? get parsedLatencyHost {
    var h = latencyHost.trim();

    if (h.isEmpty) return null;

    if (h.endsWith('/')) {
      h = h.substring(0, h.length - 1);
    }

    Uri? uri = Uri.tryParse(h);

    if (uri == null || uri.scheme.isEmpty) {
      uri = Uri.tryParse("http://$h");
    }

    return uri;
  }
}
