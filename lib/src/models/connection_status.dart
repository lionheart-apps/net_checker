/// Represents the current internet connection status.
///
/// This enum is used by the `net_checker` package to indicate whether
/// the device currently has an active internet connection.
///
/// It is commonly used with the connection monitoring stream
/// provided by `InternetConnectionStream`.
///
/// Example:
/// ```dart
/// InternetConnectionStream.start().listen((status) {
///   if (status == ConnectionStatus.connected) {
///     print("Connected to the internet");
///   } else {
///     print("No internet connection");
///   }
/// });
/// ```
enum ConnectionStatus {
  /// Indicates that the device is connected to the internet.
  connected,

  /// Indicates that the device is not connected to the internet.
  disconnected,
}
