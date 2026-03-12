class InternetConfig {

  final List<String> hosts;
  final Duration timeout;
  final Duration checkInterval;
  final String latencyHost;

  const InternetConfig({
    this.hosts = const [
      "1.1.1.1",
      "8.8.8.8",
      "google.com"
    ],
    this.timeout = const Duration(seconds: 3),
    this.checkInterval = const Duration(seconds: 5),
    this.latencyHost = "google.com",
  });

}