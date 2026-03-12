import 'package:flutter/material.dart';
import '../stream/connection_stream.dart';
import '../models/connection_status.dart';

class InternetStatusBuilder extends StatelessWidget {
  final Widget Function(BuildContext, ConnectionStatus) builder;

  const InternetStatusBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: InternetConnectionStream.start(),
      builder: (context, snapshot) {
        final status = snapshot.data ?? ConnectionStatus.disconnected;

        return builder(context, status);
      },
    );
  }
}
