import 'dart:async';
import 'dart:convert';

import 'package:elemshaty_pharmacy/backend/woocommerce/woocommerce_cart_controller.dart';
import 'package:elemshaty_pharmacy/backend/woocommerce/woocommerce_cart_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('WooCommerceCartController', () {
    test('exposes loading state and stores a successful refresh', () async {
      final responseCompleter = Completer<http.Response>();
      final controller = _controller(
        MockClient((_) => responseCompleter.future),
      );

      final load = controller.loadCart();
      await Future<void>.delayed(Duration.zero);
      expect(controller.isLoading, isTrue);
      expect(controller.hasLoadedCart, isFalse);

      responseCompleter.complete(_cartResponse(items: [_item('saved-line')]));
      await load;

      expect(controller.isLoading, isFalse);
      expect(controller.hasLoadedCart, isTrue);
      expect(controller.cart!.items.single.key, 'saved-line');
      expect(controller.errorMessage, isNull);
    });

    test('applies successful mutation response as authoritative state',
        () async {
      final requests = <http.BaseRequest>[];
      final controller = _controller(MockClient((request) async {
        requests.add(request);
        if (request.method == 'GET') {
          return _cartResponse(items: []);
        }
        return _cartResponse(items: [_item('server-line', quantity: 2)]);
      }));

      await controller.loadCart();
      final add = controller.addItem(productId: 52, quantity: 2);
      expect(controller.isMutationInProgress, isTrue);
      await add;

      expect(requests.map((request) => request.method), ['GET', 'POST']);
      expect(controller.cart!.items.single.key, 'server-line');
      expect(controller.cart!.items.single.quantity, 2);
      expect(controller.isMutationInProgress, isFalse);
      expect(controller.requiresRefresh, isFalse);
      expect(controller.errorMessage, isNull);
    });

    test('refreshes after a failed add without retrying the mutation',
        () async {
      final requests = <http.BaseRequest>[];
      final controller = _controller(MockClient((request) async {
        requests.add(request);
        if (request.method == 'POST') {
          throw http.ClientException('connection ended after request');
        }
        // Simulate a mutation whose server outcome was uncertain but whose
        // result is visible in the authoritative cart read.
        return _cartResponse(items: [_item('reconciled-line')]);
      }));

      await controller.addItem(productId: 52);

      expect(requests.map((request) => request.method), ['POST', 'GET']);
      expect(controller.cart!.items.single.key, 'reconciled-line');
      expect(controller.requiresRefresh, isFalse);
      expect(controller.errorMessage, contains('Could not reach'));
    });

    test('blocks another mutation if failure recovery refresh also fails',
        () async {
      var requestCount = 0;
      final controller = _controller(MockClient((request) async {
        requestCount++;
        if (request.method == 'POST' && requestCount == 1) {
          throw http.ClientException('unknown outcome');
        }
        if (requestCount == 2) {
          throw http.ClientException('refresh unavailable');
        }
        return _cartResponse(items: []);
      }));

      await controller.addItem(productId: 52);
      expect(controller.requiresRefresh, isTrue);
      expect(controller.errorMessage, contains('refresh before trying again'));

      await controller.addItem(productId: 53);
      expect(requestCount, 2, reason: 'stale cart must block mutations');

      await controller.refreshCart();
      expect(controller.requiresRefresh, isFalse);
      expect(controller.errorMessage, isNull);
      await controller.addItem(productId: 53);
      expect(requestCount, 4);
    });

    test('coalesces duplicate add taps and serializes different operations',
        () async {
      final addCompleter = Completer<http.Response>();
      final requests = <http.BaseRequest>[];
      final controller = _controller(MockClient((request) async {
        requests.add(request);
        if (request.url.path.endsWith('/add-item')) {
          return addCompleter.future;
        }
        return _cartResponse(items: [_item('updated-line', quantity: 3)]);
      }));

      final firstAdd = controller.addItem(productId: 52);
      final duplicateAdd = controller.addItem(productId: 52);
      final update = controller.updateItem(key: 'line-key', quantity: 3);
      expect(identical(firstAdd, duplicateAdd), isTrue);
      await Future<void>.delayed(Duration.zero);
      expect(requests, hasLength(1));
      expect(controller.isMutationInProgress, isTrue);

      addCompleter.complete(_cartResponse(items: [_item('added-line')]));
      await Future.wait([firstAdd, update]);

      expect(requests.map((request) => request.url.path), [
        '/wp-json/wc/store/v1/cart/add-item',
        '/wp-json/wc/store/v1/cart/update-item',
      ]);
      expect(controller.cart!.items.single.key, 'updated-line');
      expect(controller.isMutationInProgress, isFalse);
    });

    test('serializes remove and refresh behind an in-flight mutation',
        () async {
      final mutationCompleter = Completer<http.Response>();
      final requests = <http.BaseRequest>[];
      final controller = _controller(MockClient((request) async {
        requests.add(request);
        if (request.url.path.endsWith('/remove-item')) {
          return mutationCompleter.future;
        }
        return _cartResponse(items: []);
      }));

      final remove = controller.removeItem(key: 'line-key');
      await Future<void>.delayed(Duration.zero);
      final refresh = controller.refreshCart();
      expect(requests.map((request) => request.method), ['POST']);

      mutationCompleter.complete(_cartResponse(items: []));
      await Future.wait([remove, refresh]);

      expect(requests.map((request) => request.method), ['POST', 'GET']);
      expect(controller.hasLoadedCart, isTrue);
      expect(controller.isLoading, isFalse);
    });

    test('reports refresh errors without discarding the last good cart',
        () async {
      var shouldFail = false;
      final controller = _controller(MockClient((_) async {
        if (shouldFail) throw http.ClientException('offline');
        return _cartResponse(items: [_item('last-good-line')]);
      }));
      await controller.loadCart();
      shouldFail = true;

      await controller.refreshCart();

      expect(controller.cart!.items.single.key, 'last-good-line');
      expect(controller.errorMessage, isNotNull);
      expect(controller.isLoading, isFalse);
    });
  });
}

WooCommerceCartController _controller(http.Client client) =>
    WooCommerceCartController(
      service: WooCommerceCartService(
        client: client,
        baseUrl: 'https://cart-controller.test',
      ),
    );

http.Response _cartResponse({required List<Map<String, dynamic>> items}) =>
    http.Response(
      jsonEncode({
        'items': items,
        'items_count': items.fold<int>(
          0,
          (count, item) => count + (item['quantity'] as int? ?? 0),
        ),
        'totals': {
          'total_price': '0',
          'currency_code': 'EGP',
          'currency_symbol': 'EGP',
          'currency_minor_unit': 2,
          'tax_lines': [],
        },
      }),
      200,
      headers: const {'content-type': 'application/json'},
    );

Map<String, dynamic> _item(String key, {int quantity = 1}) => {
      'key': key,
      'id': 52,
      'product_id': 52,
      'quantity': quantity,
      'name': 'Test item',
      'prices': {'price': '1000', 'currency_minor_unit': 2},
      'totals': {
        'line_total': '${1000 * quantity}',
        'currency_minor_unit': 2,
      },
    };
