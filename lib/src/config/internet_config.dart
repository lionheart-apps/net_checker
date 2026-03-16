/// Configuration settings used by the internet checking utilities.
///
/// This class allows developers to customize how connectivity checks
/// are performed by the `net_checker` package.
///
/// It controls:
/// - Which hosts are used to verify connectivity
/// - Timeout duration for connection checks
/// - Interval for periodic connectivity monitoring
/// - Host used to measure latency
class InternetConfig {
  /// List of hosts used to verify internet connectivity.
  ///
  /// The checker will attempt to resolve these hosts to determine
  /// if the device has an active internet connection.
  final List<String> hosts;

  /// Maximum duration allowed for a connectivity check before timing out.
  final Duration timeout;

  /// Interval used for repeated connectivity checks when using streams.
  final Duration checkInterval;

  /// Host used specifically for measuring network latency.
  final String latencyHost;

  /// Creates a configuration for internet connectivity checks.
  ///
  /// Default hosts include common DNS servers to improve reliability.
  const InternetConfig({
    this.hosts = const ["1.1.1.1", "8.8.8.8", "google.com"],
    this.timeout = const Duration(seconds: 3),
    this.checkInterval = const Duration(seconds: 5),
    this.latencyHost = "google.com",
  });
}
