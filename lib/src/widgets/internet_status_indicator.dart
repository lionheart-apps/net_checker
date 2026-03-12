import 'package:flutter/material.dart';
import '../models/connection_status.dart';
import '../stream/connection_stream.dart';

class InternetStatusIndicator extends StatelessWidget {
  const InternetStatusIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: InternetConnectionStream.start(),
      builder: (context, snapshot) {
        final status = snapshot.data ?? ConnectionStatus.disconnected;

        return Icon(
          status == ConnectionStatus.connected ? Icons.wifi : Icons.wifi_off,
          color: status == ConnectionStatus.connected
              ? Colors.green
              : Colors.red,
        );
      },
    );
  }
}
