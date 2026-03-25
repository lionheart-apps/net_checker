## 0.0.5

Refinement release with improved Web behavior and example app updates.

### Added

- Device/platform information in example app

### Improved

- Improved example app to handle connection state more reliably
- Better handling of loading, retry, and disconnected states in UI

### Fixed

- Fixed Web connectivity inconsistencies in example usage
- Fixed cases where connection state could appear incorrect on initial load

### Notes

- Web platform behavior depends on browser limitations (CORS, network state)
- No major changes to core package APIs

## 0.0.4

### Improved

- Minor documentation updates
- Internal improvements and cleanup

## 0.0.3

Improved release of **net_checker** with cross-platform support and documentation improvements.

### Added

- Web platform support
- Conditional platform implementation for IO and Web
- HTTP-based connectivity check for Web
- Platform support declaration in pubspec.yaml

### Improved

- Added DartDoc documentation for public APIs
- Improved README documentation and usage examples
- Improved package structure for better platform compatibility

### Fixed

- Resolved pub.dev documentation coverage warning
- Improved package metadata and platform detection

## 0.0.2

Initial stable release of **net_checker**.

### Added

- Internet connectivity check
- Custom host configuration support
- Real-time connection monitoring stream
- Network latency measurement
- Network quality detection
- Configurable timeout and check interval
- Internet status indicator widget
- Internet status builder widget
- No internet banner widget
- Example application
