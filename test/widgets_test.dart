import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:net_checker/net_checker.dart';

void main() {
  group('Widget Tests', () {
    testWidgets('NoInternetBanner renders when visible is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NoInternetBanner(
              visible: true,
              message: "Custom Offline Message",
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text("Custom Offline Message"), findsOneWidget);
      expect(find.byIcon(Icons.wifi_off), findsOneWidget);
    });

    testWidgets('NoInternetBanner hides when visible is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NoInternetBanner(
              visible: false,
              message: "Custom Offline Message",
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text("Custom Offline Message"), findsNothing);
    });

    testWidgets('InternetStatusBuilder renders with custom stream and updates',
        (WidgetTester tester) async {
      final controller = StreamController<ConnectionStatus>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InternetStatusBuilder(
              stream: controller.stream,
              initialStatus: ConnectionStatus.disconnected,
              builder: (context, status) {
                return Text('Status: ${status.label}');
              },
            ),
          ),
        ),
      );

      expect(find.text('Status: Disconnected'), findsOneWidget);

      // Emit connected event
      controller.add(ConnectionStatus.connected);
      await tester.pump();
      expect(find.text('Status: Connected'), findsOneWidget);

      await controller.close();
    });

    testWidgets('InternetStatusIndicator renders connected & disconnected icons',
        (WidgetTester tester) async {
      final controller = StreamController<ConnectionStatus>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InternetStatusIndicator(
              stream: controller.stream,
              initialStatus: ConnectionStatus.connected,
              connectedIcon: Icons.wifi,
              disconnectedIcon: Icons.wifi_off,
            ),
          ),
        ),
      );

      await tester.pump();
      expect(find.byIcon(Icons.wifi), findsOneWidget);

      // Emit disconnected
      controller.add(ConnectionStatus.disconnected);
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.wifi_off), findsOneWidget);

      await controller.close();
    });
  });
}
