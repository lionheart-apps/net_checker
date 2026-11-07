# net_checker_example

A demonstrative example application for the [`net_checker`](https://pub.dev/packages/net_checker) Flutter package.

## Features Demonstrated

- Real-time connection status monitoring using `InternetConnectionStream`
- Measuring network latency (in milliseconds) with `LatencyChecker`
- Strongly-typed `NetworkQualityLevel` detection (`excellent`, `good`, `slow`, `verySlow`, `disconnected`)
- Active host verification with `InternetChecker.getWorkingHost()`
- Dynamic UI updates with offline banner and theme-coded status indicators

## Getting Started

Run the example on any supported platform:

```bash
# Android / iOS
flutter run

# Web
flutter run -d chrome

# Desktop (Windows / macOS / Linux)
flutter run -d windows
```
