import 'dart:convert';

import 'package:elemshaty_pharmacy/backend/woocommerce/woocommerce_cart_session_diagnostic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  test('reports safe status, keys, and Cart-Token presence for JSON',
      () async {
    late http.Request capturedRequest;
    final client = MockClient((request) async {
      capturedRequest = request;
      return http.Response(
        jsonEncode({
          'items': [],
          'billing_address': {'email': 'private@example.test'},
        }),
        200,
        headers: const {
          'content-type': 'application/json',
          'Cart-Token': 'must-not-be-reported-or-stored',
        },
      );
    });
    final diagnostic = WooCommerceCartSessionDiagnostic(
      client: client,
      baseUrl: 'https://store.example',
    );

    final result = await diagnostic.run();

    expect(capturedRequest.method, 'GET');
    expect(capturedRequest.url.toString(),
        'https://store.example/wp-json/wc/store/v1/cart');
    expect(capturedRequest.headers, const {'Accept': 'application/json'});
    expect(result.statusCode, 200);
    expect(result.isValidJson, isTrue);
    expect(result.topLevelKeys, ['items', 'billing_address']);
    expect(result.hasCartToken, isTrue);
    expect(result.errorCategory, 'none');
    expect(result.diagnosticLine, isNot(contains('private@example.test')));
    expect(result.diagnosticLine,
        isNot(contains('must-not-be-reported-or-stored')));
  });

  test('reports non-JSON HTTP errors without exposing their body', () async {
    final diagnostic = WooCommerceCartSessionDiagnostic(
      client: MockClient((_) async => http.Response(
        '<html>private response content</html>',
        403,
        headers: const {'content-type': 'text/html'},
      )),
      baseUrl: 'https://store.example',
    );

    final result = await diagnostic.run();

    expect(result.statusCode, 403);
    expect(result.isValidJson, isFalse);
    expect(result.topLevelKeys, isEmpty);
    expect(result.hasCartToken, isFalse);
    expect(result.errorCategory, 'http_error');
    expect(result.diagnosticLine, isNot(contains('private response content')));
  });

  test('reports a successful JSON response without Cart-Token', () async {
    final diagnostic = WooCommerceCartSessionDiagnostic(
      client: MockClient((_) async => http.Response(
        '{"items":[],"totals":{}}',
        200,
        headers: const {'content-type': 'application/json'},
      )),
      baseUrl: 'https://store.example',
    );

    final result = await diagnostic.run();

    expect(result.statusCode, 200);
    expect(result.isValidJson, isTrue);
    expect(result.topLevelKeys, ['items', 'totals']);
    expect(result.hasCartToken, isFalse);
    expect(result.errorCategory, 'missing_cart_token');
  });

  test('reports request failure using only a sanitized category', () async {
    final diagnostic = WooCommerceCartSessionDiagnostic(
      client: MockClient((_) async {
        throw http.ClientException('Failed host lookup: private.example');
      }),
      baseUrl: 'https://store.example',
    );

    final result = await diagnostic.run();

    expect(result.statusCode, isNull);
    expect(result.isValidJson, isFalse);
    expect(result.topLevelKeys, isEmpty);
    expect(result.hasCartToken, isFalse);
    expect(result.errorCategory, 'network_error');
    expect(result.diagnosticLine, isNot(contains('private.example')));
  });
}
