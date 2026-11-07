import 'package:flutter_test/flutter_test.dart';
import 'package:net_checker/net_checker.dart';

void main() {
  group('ConnectionStatus Tests', () {
    test('Labels return expected strings', () {
      expect(ConnectionStatus.connected.label, equals("Connected"));
      expect(ConnectionStatus.disconnected.label, equals("Disconnected"));
    });

    test('Convenience getters return expected booleans', () {
      expect(ConnectionStatus.connected.isConnected, isTrue);
      expect(ConnectionStatus.connected.isDisconnected, isFalse);

      expect(ConnectionStatus.disconnected.isConnected, isFalse);
      expect(ConnectionStatus.disconnected.isDisconnected, isTrue);
    });
  });
}

