/// A lightweight, cross-platform Flutter package to check internet connectivity,
/// monitor connection changes, measure latency, and detect network quality.
library;

// Config
export 'src/config/internet_config.dart';

// Core APIs
export 'src/core/internet_checker.dart';
export 'src/core/latency_checker.dart';
export 'src/core/network_quality.dart';

// Stream
export 'src/stream/connection_stream.dart';

// Models
export 'src/models/connection_status.dart';

// Widgets
export 'src/widgets/no_internet_banner.dart';
export 'src/widgets/internet_status_builder.dart';
export 'src/widgets/internet_status_indicator.dart';
