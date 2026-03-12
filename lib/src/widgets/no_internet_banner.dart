import 'package:flutter/material.dart';

class NoInternetBanner extends StatelessWidget {
  final bool visible;
  final String message;

  const NoInternetBanner({
    super.key,
    required this.visible,
    this.message = "No Internet Connection",
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox();

    return Container(
      width: double.infinity,
      color: Colors.red,
      padding: const EdgeInsets.all(8),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
