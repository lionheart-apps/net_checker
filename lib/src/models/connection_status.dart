/// Represents the current internet connection status.
///
/// This enum is used by `net_checker` to indicate whether
/// the device currently has an active internet connection.
///
/// Example:
/// ```dart
/// InternetConnectionStream.start().listen((status) {
///   if (status.isConnected) {
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
  disconnected;

  /// Returns a user-friendly readable string value.
  String get label {
    switch (this) {
      case ConnectionStatus.connected:
        return "Connected";
      case ConnectionStatus.disconnected:
        return "Disconnected";
    }
  }

  /// Whether the status is [ConnectionStatus.connected].
  bool get isConnected => this == ConnectionStatus.connected;

  /// Whether the status is [ConnectionStatus.disconnected].
  bool get isDisconnected => this == ConnectionStatus.disconnected;
}
