import '../config/internet_config.dart';

import 'internet_checker_io.dart'
    if (dart.library.html) 'internet_checker_web.dart';

/// Provides utilities to check internet connectivity.
///
/// This class delegates the actual connectivity check to the
/// platform-specific implementation.
///
/// Supported platforms:
/// - Android
/// - iOS
/// - Windows
/// - macOS
/// - Linux
/// - Web
class InternetChecker {
  /// Checks whether the device currently has an internet connection.
  ///
  /// The connectivity check behavior is controlled by [InternetConfig].
  ///
  /// Example:
  /// ```dart
  /// bool connected = await InternetChecker.hasConnection();
  /// ```
  static Future<bool> hasConnection({
    InternetConfig config = const InternetConfig(),
  }) async {
    return InternetCheckerImpl.hasConnection(config);
  }

  /// ✅ NEW: Returns the first working host
  ///
  /// Useful for debugging / testing
  ///
  /// Returns:
  /// - host string if success
  /// - null if no connection
  static Future<String?> getWorkingHost({
    InternetConfig config = const InternetConfig(),
  }) {
    return InternetCheckerImpl.getWorkingHost(config);
  }
}
