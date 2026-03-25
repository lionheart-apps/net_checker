/// A lightweight Flutter package for monitoring internet connectivity,
/// measuring network latency, and detecting connection quality.
///
/// ## Features
/// - Check whether the device is connected to the internet
/// - Monitor connection changes using a stream
/// - Measure network latency
/// - Determine network quality
/// - Ready-to-use Flutter widgets for UI integration
///
/// ## Supported Platforms
/// - Android
/// - iOS
/// - Windows
/// - macOS
/// - Linux
/// - Web
///
/// This package is designed to be simple, lightweight, and flexible.

/// Config
export 'src/config/internet_config.dart';

/// Core APIs
export 'src/core/internet_checker.dart';
export 'src/core/latency_checker.dart';
export 'src/core/network_quality.dart';

/// Stream
export 'src/stream/connection_stream.dart';

/// Models
export 'src/models/connection_status.dart';

/// Widgets
export 'src/widgets/no_internet_banner.dart';
export 'src/widgets/internet_status_builder.dart';
export 'src/widgets/internet_status_indicator.dart';
