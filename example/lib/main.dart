import 'dart:async';
import 'package:flutter/material.dart';
import 'package:net_checker/net_checker.dart';

/// Entry point of the example application.
void main() {
  runApp(const MyApp());
}

/// Root widget of the demo app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

/// Example screen demonstrating how to use the `net_checker` package
/// to monitor internet connectivity in real-time.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Holds the current connection status displayed in the UI.
  String status = "Checking...";

  /// Subscription to the connectivity stream.
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();

    /// Listen to connectivity changes using the stream provided
    /// by the `InternetConnectionStream` class.
    subscription = InternetConnectionStream.start().listen((connection) {
      setState(() {
        /// Convert enum value to readable string.
        status = connection.toString().split('.').last;
      });
    });
  }

  @override
  void dispose() {
    /// Cancel the stream subscription to avoid memory leaks.
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Net Checker Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Simple connectivity icon
            const Icon(
              Icons.wifi,
              size: 60,
            ),

            const SizedBox(height: 20),

            Text(
              "Connection Status",
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 10),

            /// Display current connectivity state
            Text(
              status,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
