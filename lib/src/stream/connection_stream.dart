import 'dart:async';
import '../core/internet_checker.dart';
import '../config/internet_config.dart';
import '../models/connection_status.dart';

class InternetConnectionStream {
  static Stream<ConnectionStatus> start({
    InternetConfig config = const InternetConfig(),
  }) async* {
    ConnectionStatus last = ConnectionStatus.disconnected;

    while (true) {
      final connected = await InternetChecker.hasConnection(config: config);

      final status = connected
          ? ConnectionStatus.connected
          : ConnectionStatus.disconnected;

      if (status != last) {
        last = status;
        yield status;
      }

      await Future.delayed(config.checkInterval);
    }
  }
}
