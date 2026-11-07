/// Configuration settings used by the internet checking utilities.
///
/// This class ensures all hosts are converted into a **valid usable format**
/// so other classes can directly use them without extra checks.
///
/// Supports inputs like:
/// - `google.com`
/// - `http://google.com`
/// - `https://google.com`
/// - `https://clients3.google.com/generate_204`
/// - `1.1.1.1`
///
/// Output will ALWAYS be:
/// - Proper [Uri] (with scheme)
class InternetConfig {
  /// Raw hosts provided by the user.
  final List<String> hosts;

  /// Timeout for individual lookup/request attempts.
  final Duration timeout;

  /// Interval between checks when monitoring via connection stream.
  final Duration checkInterval;

  /// Host used for measuring latency.
  final String latencyHost;

  const InternetConfig({
    this.hosts = const [
      "https://clients3.google.com/generate_204",
      "https://one.one.one.one",
      "https://google.com",
      "https://cloudflare.com",
    ],
    this.timeout = const Duration(seconds: 3),
    this.checkInterval = const Duration(seconds: 5),
    this.latencyHost = "google.com",
  });

  /// Returns sanitized [Uri] instances for all configured hosts.
  ///
  /// Rules:
  /// - If scheme exists → keep it
  /// - If missing → default to https (fallback to http)
  /// - Remove trailing slash (unless path is present)
  /// - Skip invalid or empty values
  List<Uri> get parsedHosts {
    return hosts
        .map(_parseHost)
        .whereType<Uri>()
        .toList();
  }

  /// Parsed latency host [Uri].
  Uri? get parsedLatencyHost => _parseHost(latencyHost);

  static Uri? _parseHost(String host) {
    var h = host.trim();
    if (h.isEmpty) return null;

    if (h.endsWith('/')) {
      h = h.substring(0, h.length - 1);
    }

    Uri? uri = Uri.tryParse(h);

    if (uri == null || uri.scheme.isEmpty) {
      uri = Uri.tryParse("https://$h") ?? Uri.tryParse("http://$h");
    }

    return uri;
  }

  /// Creates a copy of this [InternetConfig] with the given fields replaced.
  InternetConfig copyWith({
    List<String>? hosts,
    Duration? timeout,
    Duration? checkInterval,
    String? latencyHost,
  }) {
    return InternetConfig(
      hosts: hosts ?? this.hosts,
      timeout: timeout ?? this.timeout,
      checkInterval: checkInterval ?? this.checkInterval,
      latencyHost: latencyHost ?? this.latencyHost,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! InternetConfig) return false;

    if (hosts.length != other.hosts.length) return false;
    for (var i = 0; i < hosts.length; i++) {
      if (hosts[i] != other.hosts[i]) return false;
    }

    return timeout == other.timeout &&
        checkInterval == other.checkInterval &&
        latencyHost == other.latencyHost;
  }

  @override
  int get hashCode => Object.hash(
        Object.hashAll(hosts),
        timeout,
        checkInterval,
        latencyHost,
      );

  @override
  String toString() {
    return 'InternetConfig(hosts: $hosts, timeout: $timeout, checkInterval: $checkInterval, latencyHost: $latencyHost)';
  }
}
