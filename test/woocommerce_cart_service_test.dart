import 'dart:convert';

import 'package:elemshaty_pharmacy/backend/woocommerce/woocommerce_cart_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('WooCommerceCartService', () {
    test('GET parses cart items, variation IDs, money, and totals', () async {
      final client = MockClient((request) async {
        expect(request.method, 'GET');
        expect(request.url.toString(),
            'https://store.example/wp-json/wc/store/v1/cart');
        expect(request.headers['accept'], 'application/json');
        expect(request.headers.containsKey('cart-token'), isFalse);
        return http.Response(
          jsonEncode(_cartJson()),
          200,
          headers: const {
            'content-type': 'application/json; charset=utf-8',
            'Cart-Token': 'opaque-test-token',
          },
        );
      });
      final service = WooCommerceCartService(
        client: client,
        baseUrl: 'https://store.example',
      );

      final cart = await service.getCart();

      expect(service.hasCartToken, isTrue);
      expect(cart.itemsCount, 2);
      expect(cart.items.single.key, 'line-key');
      expect(cart.items.single.productId, 42);
      expect(cart.items.single.variationId, 43);
      expect(cart.items.single.quantity, 2);
      expect(cart.items.single.prices.price, 12.5);
      expect(cart.items.single.totals.lineTotal, 25);
      expect(cart.totals.totalPrice, 31.25);
    });

    test('sends Cart-Token on subsequent cart requests', () async {
      final requests = <http.BaseRequest>[];
      final client = MockClient((request) async {
        requests.add(request);
        if (requests.length == 1) {
          return http.Response(
            jsonEncode(_cartJson()),
            200,
            headers: const {
              'content-type': 'application/json',
              'Cart-Token': 'do-not-log-this-token',
            },
          );
        }
        return http.Response(
          jsonEncode(_cartJson()),
          200,
          headers: const {'content-type': 'application/json'},
        );
      });
      final service = WooCommerceCartService(
        client: client,
        baseUrl: 'https://store.example',
      );

      await service.getCart();
      await service.addItem(productId: 42, quantity: 3);

      final mutation = requests.last as http.Request;
      expect(mutation.method, 'POST');
      expect(mutation.url.path, '/wp-json/wc/store/v1/cart/add-item');
      expect(mutation.headers['accept'], 'application/json');
      expect(mutation.headers['content-type'], startsWith('application/json'));
      expect(mutation.headers['cart-token'], 'do-not-log-this-token');
      expect(jsonDecode(mutation.body), {'id': 42, 'quantity': 3});
      expect(mutation.url.query, isEmpty);
    });

    test('uses correct update and remove routes and request fields', () async {
      final requests = <http.Request>[];
      final client = MockClient((request) async {
        requests.add(request);
        return http.Response(
          jsonEncode(_cartJson()),
          200,
          headers: const {'content-type': 'application/json'},
        );
      });
      final service = WooCommerceCartService(
        client: client,
        baseUrl: 'https://store.example',
      );

      await service.updateItem(key: 'cart-line-key', quantity: 4);
      await service.removeItem(key: 'cart-line-key');

      expect(requests.map((request) => request.method), ['POST', 'POST']);
      expect(requests[0].url.path, '/wp-json/wc/store/v1/cart/update-item');
      expect(jsonDecode(requests[0].body),
          {'key': 'cart-line-key', 'quantity': 4});
      expect(requests[1].url.path, '/wp-json/wc/store/v1/cart/remove-item');
      expect(jsonDecode(requests[1].body), {'key': 'cart-line-key'});
    });

    test('does not replace an existing token when response omits it', () async {
      var requestCount = 0;
      final client = MockClient((request) async {
        requestCount++;
        if (requestCount == 1) {
          return http.Response(
            jsonEncode(_cartJson()),
            200,
            headers: const {
              'content-type': 'application/json',
              'Cart-Token': 'retained-token',
            },
          );
        }
        expect(request.headers['cart-token'], 'retained-token');
        return http.Response(jsonEncode(_cartJson()), 200,
            headers: const {'content-type': 'application/json'});
      });
      final service = WooCommerceCartService(
        client: client,
        baseUrl: 'https://store.example',
      );

      await service.getCart();
      await service.getCart();

      expect(service.hasCartToken, isTrue);
    });

    test('surfaces API error status and safe API code, not response body',
        () async {
      final service = WooCommerceCartService(
        client: MockClient((_) async => http.Response(
              jsonEncode({
                'code': 'woocommerce_rest_cart_item_error',
                'message': 'private details should not be exposed',
              }),
              409,
              headers: const {'content-type': 'application/json'},
            )),
        baseUrl: 'https://store.example',
      );

      await expectLater(
        service.addItem(productId: 42),
        throwsA(isA<WooCartException>()
            .having(
              (error) => error.statusCode,
              'statusCode',
              409,
            )
            .having((error) => error.apiCode, 'apiCode',
                'woocommerce_rest_cart_item_error')
            .having(
              (error) => error.toString(),
              'message',
              isNot(contains('private details')),
            )),
      );
    });

    test('rejects malformed JSON and non-object success responses', () async {
      final malformedService = WooCommerceCartService(
        client: MockClient((_) async => http.Response(
              '{invalid',
              200,
              headers: const {'content-type': 'application/json'},
            )),
        baseUrl: 'https://store.example',
      );
      final wrongShapeService = WooCommerceCartService(
        client: MockClient((_) async => http.Response(
              '[]',
              200,
              headers: const {'content-type': 'application/json'},
            )),
        baseUrl: 'https://store.example',
      );

      await expectLater(
          malformedService.getCart(), throwsA(isA<WooCartException>()));
      await expectLater(
          wrongShapeService.getCart(), throwsA(isA<WooCartException>()));
    });

    test('validates inputs before sending mutations', () async {
      var requestCount = 0;
      final service = WooCommerceCartService(
        client: MockClient((_) async {
          requestCount++;
          return http.Response(
            jsonEncode(_cartJson()),
            200,
            headers: const {'content-type': 'application/json'},
          );
        }),
        baseUrl: 'https://store.example',
      );

      expect(() => service.addItem(productId: 0),
          throwsA(isA<WooCartException>()));
      expect(() => service.addItem(productId: 42, quantity: 0),
          throwsA(isA<WooCartException>()));
      expect(() => service.updateItem(key: ' ', quantity: 1),
          throwsA(isA<WooCartException>()));
      expect(
          () => service.removeItem(key: ''), throwsA(isA<WooCartException>()));
      expect(requestCount, 0);
    });

    test('rejects unauthorized URL schemes, credentials, and base paths', () {
      for (final url in [
        'http://store.example',
        'https://user:password@store.example',
        'https://store.example/path',
        'https://store.example?host=elsewhere',
      ]) {
        expect(
          () => WooCommerceCartService(
            client: MockClient((_) async => throw StateError('must not call')),
            baseUrl: url,
          ),
          throwsArgumentError,
          reason: 'Rejected URL: $url',
        );
      }
    });

    test('clearSession discards the in-memory token without a request',
        () async {
      final client = MockClient((_) async => http.Response(
            jsonEncode(_cartJson()),
            200,
            headers: const {
              'content-type': 'application/json',
              'Cart-Token': 'temporary-token',
            },
          ));
      final service = WooCommerceCartService(
        client: client,
        baseUrl: 'https://store.example',
      );

      await service.getCart();
      expect(service.hasCartToken, isTrue);
      service.clearSession();
      expect(service.hasCartToken, isFalse);
    });
  });
}

Map<String, dynamic> _cartJson() => {
      'items': [
        {
          'key': 'line-key',
          'id': 42,
          'product_id': 42,
          'variation_id': 43,
          'quantity': 2,
          'name': 'Test product',
          'sku': 'SKU-42',
          'permalink': 'https://store.example/product/test',
          'images': [
            {'src': 'https://store.example/image.jpg'}
          ],
          'variation': [
            {'attribute': 'pa_size', 'value': 'small'}
          ],
          'prices': {
            'price': '1250',
            'regular_price': '1500',
            'sale_price': '1250',
            'currency_code': 'EGP',
            'currency_symbol': 'EGP',
            'currency_minor_unit': 2,
          },
          'totals': {
            'line_subtotal': '2500',
            'line_subtotal_tax': '0',
            'line_total': '2500',
            'line_total_tax': '0',
            'currency_minor_unit': 2,
          },
        }
      ],
      'items_count': 2,
      'items_weight': 10,
      'needs_payment': true,
      'needs_shipping': true,
      'has_calculated_shipping': false,
      'totals': {
        'total_items': '2500',
        'total_items_tax': '0',
        'total_fees': '0',
        'total_fees_tax': '0',
        'total_discount': '0',
        'total_discount_tax': '0',
        'total_shipping': '625',
        'total_shipping_tax': '0',
        'total_price': '3125',
        'tax_lines': [],
        'currency_code': 'EGP',
        'currency_symbol': 'EGP',
        'currency_minor_unit': 2,
      },
    };
