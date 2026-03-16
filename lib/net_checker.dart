// A lightweight Flutter package for monitoring internet connectivity,
// measuring network latency, and detecting connection quality.
//
// The net_checker package provides utilities to:
//
// - Check whether the device is connected to the internet
// - Monitor connection changes using a stream
// - Measure network latency
// - Determine network quality
// - Display connectivity status using ready-to-use Flutter widgets
//
// This package is designed to be simple and lightweight.

export 'src/config/internet_config.dart';

export 'src/core/internet_checker.dart';
export 'src/core/latency_checker.dart';
export 'src/core/network_quality.dart';

export 'src/stream/connection_stream.dart';

export 'src/models/connection_status.dart';

export 'src/widgets/no_internet_banner.dart';
export 'src/widgets/internet_status_builder.dart';
export 'src/widgets/internet_status_indicator.dart';
