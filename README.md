# internet_checker_plus

A lightweight Flutter package to check internet connectivity, monitor connection changes, measure latency, and detect network quality.

Version: 0.0.1

## Features

- Check internet connectivity
- Custom host configuration
- Real-time internet monitoring
- Network latency measurement
- Network quality detection
- Optional UI widgets
- No third-party dependencies

## Installation

Add this to your pubspec.yaml

```yaml
dependencies:
  internet_checker_plus: ^0.0.1
```

Then run

```bash
flutter pub get
```

## Import

```dart
import 'package:net_checker/net_checker.dart';
```

## Check Internet Connection

```dart
bool connected = await InternetChecker.hasConnection();
print("Connected: $connected");
```

## Custom Configuration

```dart
final config = InternetConfig(
  hosts: ["example.com", "cloudflare.com", "8.8.8.8"],
  timeout: Duration(seconds: 3),
  checkInterval: Duration(seconds: 5),
);
```

Use it like this

```dart
bool connected = await InternetChecker.hasConnection(config: config);
```

## Listen to Internet Changes

```dart
InternetConnectionStream.start().listen((status) {
  print(status);
});
```

## Network Latency

```dart
int? latency = await LatencyChecker.getLatency();
print("Latency: $latency ms");
```

## Network Quality

```dart
String quality = await NetworkQuality.getQuality();
print("Connection quality: $quality");
```

## Widgets

Internet status indicator

```dart
InternetStatusIndicator()
```

Internet status builder

```dart
InternetStatusBuilder(
  builder: (context, status) {
    return Text(status.toString());
  },
)
```

No internet banner

```dart
NoInternetBanner(
  visible: true,
)
```
