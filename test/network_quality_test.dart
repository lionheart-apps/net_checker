import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:net_checker/net_checker.dart';

void main() {
  group('NetworkQuality Tests', () {
    test('getLevelFromLatency correctly maps thresholds', () {
      expect(NetworkQuality.getLevelFromLatency(null),
          equals(NetworkQualityLevel.disconnected));
      expect(NetworkQuality.getLevelFromLatency(50),
          equals(NetworkQualityLevel.excellent));
      expect(NetworkQuality.getLevelFromLatency(99),
          equals(NetworkQualityLevel.excellent));
      expect(
          NetworkQuality.getLevelFromLatency(100), equals(NetworkQualityLevel.good));
      expect(
          NetworkQuality.getLevelFromLatency(299), equals(NetworkQualityLevel.good));
      expect(
          NetworkQuality.getLevelFromLatency(300), equals(NetworkQualityLevel.slow));
      expect(
          NetworkQuality.getLevelFromLatency(599), equals(NetworkQualityLevel.slow));
      expect(NetworkQuality.getLevelFromLatency(600),
          equals(NetworkQualityLevel.verySlow));
      expect(NetworkQuality.getLevelFromLatency(1200),
          equals(NetworkQualityLevel.verySlow));
    });

    test('NetworkQualityLevel properties return consistent values', () {
      expect(NetworkQualityLevel.excellent.label, equals("Excellent"));
      expect(NetworkQualityLevel.good.label, equals("Good"));
      expect(NetworkQualityLevel.slow.label, equals("Slow"));
      expect(NetworkQualityLevel.verySlow.label, equals("Very Slow"));
      expect(NetworkQualityLevel.disconnected.label, equals("Disconnected"));

      expect(NetworkQualityLevel.excellent.color, equals(Colors.green));
      expect(NetworkQualityLevel.good.color, equals(Colors.lightGreen));
      expect(NetworkQualityLevel.slow.color, equals(Colors.orange));
      expect(NetworkQualityLevel.verySlow.color, equals(Colors.red));
      expect(NetworkQualityLevel.disconnected.color, equals(Colors.grey));
    });

    test('getColor legacy helper maps strings correctly', () {
      expect(NetworkQuality.getColor(NetworkQuality.excellent), equals(Colors.green));
      expect(NetworkQuality.getColor(NetworkQuality.good), equals(Colors.lightGreen));
      expect(NetworkQuality.getColor(NetworkQuality.slow), equals(Colors.orange));
      expect(NetworkQuality.getColor(NetworkQuality.verySlow), equals(Colors.red));
      expect(NetworkQuality.getColor(NetworkQuality.disconnected), equals(Colors.grey));
      expect(NetworkQuality.getColor("unknown"), equals(Colors.grey));
    });

    test('getColorFromLatency maps correctly', () {
      expect(NetworkQuality.getColorFromLatency(40), equals(Colors.green));
      expect(NetworkQuality.getColorFromLatency(200), equals(Colors.lightGreen));
      expect(NetworkQuality.getColorFromLatency(400), equals(Colors.orange));
      expect(NetworkQuality.getColorFromLatency(800), equals(Colors.red));
      expect(NetworkQuality.getColorFromLatency(null), equals(Colors.grey));
    });
  });
}

