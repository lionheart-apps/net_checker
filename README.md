# net_checker

[![pub version](https://img.shields.io/pub/v/net_checker.svg)](https://pub.dev/packages/net_checker)
[![likes](https://img.shields.io/pub/likes/net_checker)](https://pub.dev/packages/net_checker/score)
[![popularity](https://img.shields.io/pub/popularity/net_checker)](https://pub.dev/packages/net_checker/score)
[![license](https://img.shields.io/github/license/lionheart-apps/net_checker)](LICENSE)

A lightweight and cross-platform Flutter package to check internet connectivity, monitor connection changes, measure latency, detect network quality, and identify working hosts.

---

## ✨ Features

| Feature                            | Supported |
| ---------------------------------- | --------- |
| Internet connectivity check        | ✓         |
| Real-time connection monitoring    | ✓         |
| Network latency measurement        | ✓         |
| Network quality detection          | ✓         |
| Working host detection             | ✓         |
| Custom host configuration          | ✓         |
| UI widgets for connectivity status | ✓         |
| Cross-platform support             | ✓         |

---

## 📱 Platform Support

| Platform | Supported | Notes |
| -------- | --------- | ----- |
| Android  | ✓         | Requires INTERNET permission |
| iOS      | ✓         | No extra permission required |
| Web      | ✓         | Limited by browser security (CORS) |
| Windows  | ✓         | No extra setup |
| macOS    | ✓         | No extra setup |
| Linux    | ✓         | No extra setup |

---

## 🚀 Installation

```yaml
dependencies:
  net_checker: ^latest
```

```bash
flutter pub get
```

---

## 📦 Import

```dart
import 'package:net_checker/net_checker.dart';
```

---

## 🔌 Check Internet Connection

```dart
bool connected = await InternetChecker.hasConnection();
```

---

## 🌐 Get Working Host

```dart
String? host = await InternetChecker.getWorkingHost();
```

---

## ⚡ Network Latency

```dart
int? latency = await LatencyChecker.getLatency();
```

---

## 📊 Network Quality

```dart
String quality = await NetworkQuality.getQuality();
```

---

## 🔄 Listen to Connection Changes

```dart
InternetConnectionStream.start().listen((status) {
  print(status);
});
```

---

## ⚙️ Custom Configuration

```dart
final config = InternetConfig(
  hosts: ["google.com", "cloudflare.com", "1.1.1.1"],
  timeout: Duration(seconds: 3),
  checkInterval: Duration(seconds: 5),
);
```

### Usage with config

```dart
await InternetChecker.hasConnection(config: config);
await LatencyChecker.getLatency(config: config);
await NetworkQuality.getQuality(config: config);
await InternetChecker.getWorkingHost(config: config);
```

---

## 🧩 Widgets

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
NoInternetBanner(visible: true)
```

---

## ⚠️ Platform Configuration

### Android

Add permission in `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

---

### iOS

No additional permission required.

If using network calls extensively, ensure App Transport Security allows your endpoints if needed:

```xml
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```

---

### Web

- Uses browser-based network detection
- Subject to CORS and browser security restrictions
- Connectivity checks may not fully match mobile/desktop behavior
- Host verification and latency may be limited

---

### Desktop (Windows / macOS / Linux)

No additional configuration required.

---

## 💡 Best Practices

- Use default configuration unless needed
- Avoid very low `checkInterval` (e.g. < 2 seconds) as it may increase network usage
- Use multiple hosts for reliability


---

## Support the Project

If you find **net_checker** useful, you can support its development.

<a href="https://buymeacoffee.com/krunalsinhrana" target="_blank">
  <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" height="45" width="162" alt="Buy Me A Coffee" />
</a>

---

## 📄 License

MIT License
