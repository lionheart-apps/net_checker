import 'package:flutter_test/flutter_test.dart';
import 'package:net_checker/net_checker.dart';

void main() {
  group('InternetConfig Tests', () {
    test('Default values are valid and populated', () {
      const config = InternetConfig();
      expect(config.hosts.isNotEmpty, isTrue);
      expect(config.timeout, equals(const Duration(seconds: 3)));
      expect(config.checkInterval, equals(const Duration(seconds: 5)));
      expect(config.latencyHost, equals("google.com"));

      final parsed = config.parsedHosts;
      expect(parsed.isNotEmpty, isTrue);
      for (final uri in parsed) {
        expect(uri.scheme.isNotEmpty, isTrue);
        expect(uri.host.isNotEmpty, isTrue);
      }
    });

    test('Parses hosts with and without schemes properly', () {
      const config = InternetConfig(
        hosts: [
          'example.com',
          'http://example.org/',
          'https://api.test.com/v1',
          '   ',
        ],
      );

      final parsed = config.parsedHosts;
      expect(parsed.length, equals(3));
      expect(parsed[0].scheme, equals('https'));
      expect(parsed[0].host, equals('example.com'));

      expect(parsed[1].scheme, equals('http'));
      expect(parsed[1].host, equals('example.org'));

      expect(parsed[2].scheme, equals('https'));
      expect(parsed[2].host, equals('api.test.com'));
      expect(parsed[2].path, equals('/v1'));
    });

    test('parsedLatencyHost parses correctly', () {
      const config = InternetConfig(latencyHost: 'cloudflare.com/');
      expect(config.parsedLatencyHost?.host, equals('cloudflare.com'));
      expect(config.parsedLatencyHost?.scheme, equals('https'));

      const emptyConfig = InternetConfig(latencyHost: '   ');
      expect(emptyConfig.parsedLatencyHost, isNull);
    });

    test('copyWith modifies selected properties correctly', () {
      const config = InternetConfig();
      final updated = config.copyWith(
        timeout: const Duration(seconds: 10),
        latencyHost: 'custom.com',
      );

      expect(updated.timeout, equals(const Duration(seconds: 10)));
      expect(updated.latencyHost, equals('custom.com'));
      expect(updated.checkInterval, equals(config.checkInterval));
      expect(updated.hosts, equals(config.hosts));
    });

    test('Equality and hashCode work as expected', () {
      const c1 = InternetConfig(hosts: ['google.com'], latencyHost: 'google.com');
      const c2 = InternetConfig(hosts: ['google.com'], latencyHost: 'google.com');
      const c3 = InternetConfig(hosts: ['other.com'], latencyHost: 'google.com');

      expect(c1, equals(c2));
      expect(c1.hashCode, equals(c2.hashCode));
      expect(c1, isNot(equals(c3)));
    });
  });
}

