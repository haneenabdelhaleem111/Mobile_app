import 'dart:convert';

import 'package:elemshaty_pharmacy/backend/woocommerce/checkout_models.dart';
import 'package:elemshaty_pharmacy/backend/woocommerce/woocommerce_cart_service.dart';
import 'package:elemshaty_pharmacy/backend/woocommerce/woocommerce_checkout_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('WooCommerceCheckoutService', () {
    test('GET shares the cart token and parses checkout response', () async {
      final requests = <http.BaseRequest>[];
      final client = MockClient((request) async {
        requests.add(request);
        if (requests.length == 1) {
          return http.Response(
            jsonEncode(_cartJson),
            200,
            headers: const {
              'content-type': 'application/json',
              'Cart-Token': 'private-test-token',
            },
          );
        }
        return http.Response(
          jsonEncode(_checkoutJson),
          200,
          headers: const {'content-type': 'application/json'},
        );
      });
      final cart = WooCommerceCartService(
        client: client,
        baseUrl: 'https://store.example',
      );
      final service = WooCommerceCheckoutService(cartService: cart);
      await cart.getCart();

      final checkout = await service.getCheckout();

      final request = requests.last;
      expect(request.method, 'GET');
      expect(request.url.toString(),
          'https://store.example/wp-json/wc/store/v1/checkout');
      expect(request.headers['cart-token'], 'private-test-token');
      expect(request.headers.containsKey('nonce'), isFalse);
      expect(checkout.orderId, 12);
      expect(checkout.orderNumber, '12');
      expect(checkout.billingAddress.email, 'buyer@example.test');
      expect(checkout.paymentMethod, 'cod');
      expect(checkout.paymentResult, isNull);
    });

    test('captures rotating Nonce and uses it when no Cart-Token exists',
        () async {
      final requests = <http.BaseRequest>[];
      final client = MockClient((request) async {
        requests.add(request);
        if (requests.length == 1) {
          return http.Response(
            jsonEncode(_cartJson),
            200,
            headers: const {
              'content-type': 'application/json',
              'Nonce': 'rotating-test-nonce',
            },
          );
        }
        return http.Response(
          jsonEncode(_checkoutJson),
          200,
          headers: const {
            'content-type': 'application/json',
            'Nonce': 'next-test-nonce',
          },
        );
      });
      final cart = WooCommerceCartService(
        client: client,
        baseUrl: 'https://store.example',
      );
      final service = WooCommerceCheckoutService(cartService: cart);
      await cart.getCart();
      await service.getCheckout();
      await service.updateCheckout(const WooCheckoutUpdate(
        paymentMethod: 'cod',
        orderNotes: 'Leave at reception',
        recalculateTotals: true,
      ));

      final update = requests.last as http.Request;
      expect(update.method, 'PUT');
      expect(
          update.url.queryParameters, {'__experimental_calc_totals': 'true'});
      expect(update.headers['nonce'], 'next-test-nonce');
      expect(update.headers.containsKey('cart-token'), isFalse);
      expect(jsonDecode(update.body), {
        'payment_method': 'cod',
        'order_notes': 'Leave at reception',
      });
    });

    test('POST submission serializes typed order data using mock only',
        () async {
      http.Request? captured;
      final client = MockClient((request) async {
        if (request.url.path.endsWith('/cart')) {
          return http.Response(
            jsonEncode(_cartJson),
            200,
            headers: const {
              'content-type': 'application/json',
              'Cart-Token': 'private-test-token',
            },
          );
        }
        captured = request;
        return http.Response(
          jsonEncode({
            ..._checkoutJson,
            'status': 'on-hold',
            'payment_result': {
              'payment_status': 'success',
              'redirect_url': 'https://store.example/order-received/12',
            },
          }),
          200,
          headers: const {'content-type': 'application/json'},
        );
      });
      final cart = WooCommerceCartService(
        client: client,
        baseUrl: 'https://store.example',
      );
      final service = WooCommerceCheckoutService(cartService: cart);
      await cart.getCart();
      final order = await service.submitOrder(const WooCheckoutOrderRequest(
        billingAddress: WooCheckoutAddress(
          firstName: 'Test',
          lastName: 'Buyer',
          address1: 'Test Road',
          city: 'Cairo',
          country: 'EG',
          email: 'buyer@example.test',
          phone: '01000000000',
        ),
        shippingAddress: WooCheckoutAddress(
          firstName: 'Test',
          lastName: 'Buyer',
          address1: 'Test Road',
          city: 'Cairo',
          country: 'EG',
        ),
        paymentMethod: 'cod',
        expectedTotal: '12345',
      ));

      expect(captured?.method, 'POST');
      expect(captured?.url.path, '/wp-json/wc/store/v1/checkout');
      expect(captured?.headers['cart-token'], 'private-test-token');
      expect(
          jsonDecode(captured!.body), containsPair('expected_total', '12345'));
      expect(order.status, 'on-hold');
      expect(order.paymentResult?.paymentStatus, 'success');
    });

    test('surfaces API status/code without exposing response body', () async {
      final service = WooCommerceCheckoutService(
        cartService: WooCommerceCartService(
          client: MockClient((_) async => http.Response(
                '{"code":"checkout_failed","message":"private detail"}',
                409,
                headers: const {'content-type': 'application/json'},
              )),
          baseUrl: 'https://store.example',
        ),
      );

      await expectLater(
        service.getCheckout(),
        throwsA(isA<WooCartException>()
            .having((error) => error.statusCode, 'status', 409)
            .having((error) => error.apiCode, 'api code', 'checkout_failed')),
      );
    });

    test('rejects malformed JSON and invalid checkout URLs safely', () async {
      final malformed = WooCommerceCheckoutService(
        cartService: WooCommerceCartService(
          client: MockClient((_) async => http.Response(
                'not json',
                200,
                headers: const {'content-type': 'application/json'},
              )),
          baseUrl: 'https://store.example',
        ),
      );
      await expectLater(
          malformed.getCheckout(), throwsA(isA<WooCartException>()));

      expect(
        () => WooCommerceCartService(
          client: MockClient((_) async => fail('must not send')),
          baseUrl: 'http://example.invalid',
        ),
        throwsArgumentError,
      );
    });

    test('parses missing and null optional fields safely', () {
      final session = WooCheckoutSession.fromJson(const {});
      expect(session.orderId, isNull);
      expect(session.billingAddress.firstName, isEmpty);
      expect(session.paymentResult, isNull);
    });
  });
}

const Map<String, dynamic> _cartJson = {
  'items': [],
  'items_count': 0,
  'items_weight': 0,
  'needs_payment': false,
  'needs_shipping': false,
  'has_calculated_shipping': true,
  'totals': {},
};

const Map<String, dynamic> _checkoutJson = {
  'order_id': 12,
  'order_number': '12',
  'status': 'checkout-draft',
  'customer_id': 0,
  'customer_note': '',
  'billing_address': {'email': 'buyer@example.test'},
  'shipping_address': {'city': 'Cairo'},
  'payment_method': 'cod',
  'payment_result': null,
};
