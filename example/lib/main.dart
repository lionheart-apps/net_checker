import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:net_checker/net_checker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Net Checker',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConnectionStatus status = ConnectionStatus.disconnected;

  int? latency;
  String quality = NetworkQuality.disconnected;
  String? workingHost;

  final config = const InternetConfig(
    checkInterval: Duration(seconds: 2),
  );

  StreamSubscription? sub;

  bool get isConnected => status == ConnectionStatus.connected;

  Color get statusColor => isConnected ? Colors.green : Colors.red;

  Color get latencyColor => NetworkQuality.getColorFromLatency(latency);

  Color get qualityColor => NetworkQuality.getColor(quality);

  String get deviceType {
    if (kIsWeb) return "Web";
    if (Platform.isAndroid) return "Android";
    if (Platform.isIOS) return "iOS";
    if (Platform.isWindows) return "Windows";
    if (Platform.isMacOS) return "macOS";
    if (Platform.isLinux) return "Linux";
    return "Device";
  }

  /// 🔥 REAL CHECK (ONLY SOURCE)
  Future<void> _checkNow() async {
    bool connected = false;

    try {
      connected = await InternetChecker.hasConnection(config: config)
          .timeout(const Duration(seconds: 3));
    } catch (_) {
      connected = false;
    }

    if (!mounted) return;

    /// 🔥 Prevent unnecessary rebuilds
    if (connected && status == ConnectionStatus.connected) return;
    if (!connected && status == ConnectionStatus.disconnected) return;

    if (connected) {
      final l = await LatencyChecker.getLatency(config: config);
      final q = await NetworkQuality.getQuality(config: config);
      final host = await InternetChecker.getWorkingHost(config: config);

      setState(() {
        status = ConnectionStatus.connected;
        latency = l;
        quality = q;
        workingHost = host;
      });
    } else {
      setState(() {
        status = ConnectionStatus.disconnected;
        latency = null;
        quality = NetworkQuality.disconnected;
        workingHost = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    /// 🔥 STEP 1: Force initial state (important for Web)
    status = ConnectionStatus.disconnected;
    quality = NetworkQuality.disconnected;

    /// 🔥 STEP 2: Delay first check (Web fix)
    Future.delayed(const Duration(milliseconds: 300), () {
      _checkNow();
    });

    /// 🔥 STEP 3: Stream trigger
    sub = InternetConnectionStream.start(config: config).listen((_) {
      _checkNow();
    });
  }

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Net Checker Demo")),
      body: Column(
        children: [
          if (!isConnected)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              color: Colors.red,
              child: const Text(
                "You're offline",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),

          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isConnected ? Icons.wifi : Icons.wifi_off,
                      size: 80,
                      color: statusColor,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      isConnected ? "Connected" : "Disconnected",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          _row(
                            "Latency",
                            latency != null ? "$latency ms" : "--",
                            latencyColor,
                          ),
                          const SizedBox(height: 10),
                          _row("Quality", quality, qualityColor),
                          const SizedBox(height: 10),
                          _row("Host", workingHost ?? "--", Colors.blue),
                          const SizedBox(height: 10),
                          _row("Device", deviceType, Colors.purple),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      onPressed: _checkNow,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Check Now"),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// FOOTER
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: const [
                Text(
                  "net_checker • Flutter Package",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    text: "Powered by ",
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: "Lionheartapps",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "www.lionheartapps.com",
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String t, String v, Color c) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(t),
        Text(
          v,
          style: TextStyle(fontWeight: FontWeight.bold, color: c),
        ),
      ],
    );
  }
}
