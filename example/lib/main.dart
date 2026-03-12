import 'package:flutter/material.dart';
import 'package:net_checker/net_checker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String status = "Checking...";

  @override
  void initState() {
    super.initState();

    InternetConnectionStream.start().listen((s) {
      setState(() {
        status = s.name;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Internet Checker Example")),
      body: Center(child: Text(status, style: const TextStyle(fontSize: 20))),
    );
  }
}
