# net_checker

[![pub version](https://img.shields.io/pub/v/net_checker.svg)](https://pub.dev/packages/net_checker)
[![likes](https://img.shields.io/pub/likes/net_checker)](https://pub.dev/packages/net_checker/score)
[![popularity](https://img.shields.io/pub/popularity/net_checker)](https://pub.dev/packages/net_checker/score)
[![license](https://img.shields.io/github/license/lionheart-apps/net_checker)](LICENSE)

A lightweight Flutter package to check internet connectivity, monitor connection changes, measure latency, and detect network quality.

Version: **0.0.1**

---

## Features

- Internet connectivity check
- Custom host configuration
- Real-time internet monitoring
- Network latency measurement
- Network quality detection
- Optional UI widgets
- No third-party dependencies

---

## Installation

Add this to your **pubspec.yaml**

```yaml
dependencies:
  net_checker: ^0.0.1
```

Then run

```bash
flutter pub get
```

---

## Import

```dart
import 'package:net_checker/net_checker.dart';
```

---

## Check Internet Connection

```dart
bool connected = await InternetChecker.hasConnection();
print("Connected: $connected");
```

---

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

---

## Listen to Internet Changes

```dart
InternetConnectionStream.start().listen((status) {
  print(status);
});
```

---

## Network Latency

```dart
int? latency = await LatencyChecker.getLatency();
print("Latency: $latency ms");
```

---

## Network Quality

```dart
String quality = await NetworkQuality.getQuality();
print("Connection quality: $quality");
```

---

## Widgets

### Internet Status Indicator

```dart
InternetStatusIndicator()
```

### Internet Status Builder

```dart
InternetStatusBuilder(
  builder: (context, status) {
    return Text(status.toString());
  },
)
```

### No Internet Banner

```dart
NoInternetBanner(
  visible: true,
)
```
