import 'dart:convert';

import 'package:elemshaty_pharmacy/backend/woocommerce/catalog_models.dart';
import 'package:elemshaty_pharmacy/backend/woocommerce/catalog_widgets.dart';
import 'package:elemshaty_pharmacy/backend/woocommerce/woocommerce_cart_controller.dart';
import 'package:elemshaty_pharmacy/backend/woocommerce/woocommerce_cart_service.dart';
import 'package:elemshaty_pharmacy/shopping/shopping_cart/shopping_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  testWidgets('simple product details can add through the shared controller',
      (tester) async {
    final requests = <http.Request>[];
    final controller = _controller(MockClient((request) async {
      requests.add(request);
      return _cartResponse(items: [_cartItem(quantity: 1)]);
    }));
    final product = _product(type: 'simple');

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: WooCatalogProductDetailsWidget(
          productId: product.id,
          cartController: controller,
          loadProduct: (_) async => product,
        ),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Add to Cart'), findsOneWidget);
    await tester.tap(find.text('Add to Cart'));
    await tester.pumpAndSettle();

    expect(requests, hasLength(1));
    expect(requests.single.method, 'POST');
    expect(requests.single.url.path, '/wp-json/wc/store/v1/cart/add-item');
    expect(jsonDecode(requests.single.body), {'id': product.id, 'quantity': 1});
    expect(find.text('Added to cart.'), findsOneWidget);
  });

  testWidgets('variable products are not addable without variation selection',
      (tester) async {
    var requestCount = 0;
    final controller = _controller(MockClient((_) async {
      requestCount++;
      throw StateError('Unexpected cart request');
    }));
    final product = _product(type: 'variable');

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: WooCatalogProductDetailsWidget(
          productId: product.id,
          cartController: controller,
          loadProduct: (_) async => product,
        ),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Product options required'), findsOneWidget);
    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNull);
    expect(requestCount, 0);
  });

  testWidgets('cart page renders server cart, updates quantity, and removes',
      (tester) async {
    final requests = <http.Request>[];
    var quantity = 2;
    var itemPresent = true;
    final controller = _controller(MockClient((request) async {
      requests.add(request);
      if (request.method == 'GET') {
        return _cartResponse(
            items: itemPresent ? [_cartItem(quantity: quantity)] : []);
      }
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      if (request.url.path.endsWith('/update-item')) {
        quantity = body['quantity'] as int;
      } else if (request.url.path.endsWith('/remove-item')) {
        itemPresent = false;
      }
      return _cartResponse(
          items: itemPresent ? [_cartItem(quantity: quantity)] : []);
    }));

    await tester.pumpWidget(MaterialApp(
      home: ShoppingCartWidget(cartController: controller),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Live cart item'), findsOneWidget);
    expect(find.text('EGP 10.00'), findsOneWidget);
    expect(find.text('EGP 25.00'), findsOneWidget);
    expect(find.text('EGP 45.00'), findsOneWidget);
    expect(find.text('Panadol Advance 500mg'), findsNothing);

    await tester.tap(find.byIcon(Icons.add_rounded));
    await tester.pumpAndSettle();
    expect(
        requests.any((request) =>
            request.url.path.endsWith('/update-item') &&
            jsonDecode(request.body)['quantity'] == 3),
        isTrue);

    await tester.tap(find.byTooltip('Remove Live cart item'));
    await tester.pumpAndSettle();
    expect(requests.any((request) => request.url.path.endsWith('/remove-item')),
        isTrue);
    expect(find.text('Your cart is empty.'), findsOneWidget);
  });
}

WooCommerceCartController _controller(http.Client client) =>
    WooCommerceCartController(
      service: WooCommerceCartService(
        client: client,
        baseUrl: 'https://cart-ui.test',
      ),
    );

WooProduct _product({required String type}) => WooProduct.fromJson({
      'id': 84,
      'name': 'Test $type product',
      'type': type,
      'is_in_stock': true,
      'prices': {
        'price': '1000',
        'regular_price': '1200',
        'currency_code': 'EGP',
        'currency_symbol': 'EGP',
        'currency_minor_unit': 2,
      },
    });

Map<String, dynamic> _cartItem({required int quantity}) => {
      'key': 'test-line-key',
      'id': 84,
      'product_id': 84,
      'quantity': quantity,
      'name': 'Live cart item',
      'sku': 'SKU-84',
      'images': [
        {'src': ''}
      ],
      'prices': {
        'price': '1000',
        'regular_price': '1200',
        'currency_code': 'EGP',
        'currency_symbol': 'EGP',
        'currency_minor_unit': 2,
      },
      'totals': {
        'line_total': '${1000 * quantity}',
        'currency_minor_unit': 2,
      },
    };

http.Response _cartResponse({required List<Map<String, dynamic>> items}) =>
    http.Response(
      jsonEncode({
        'items': items,
        'items_count': items.fold<int>(
          0,
          (count, item) => count + (item['quantity'] as int? ?? 0),
        ),
        'totals': {
          'total_items': '2000',
          'total_shipping': '2500',
          'total_price': '4500',
          'currency_code': 'EGP',
          'currency_symbol': 'EGP',
          'currency_minor_unit': 2,
          'tax_lines': [],
        },
      }),
      200,
      headers: const {'content-type': 'application/json'},
    );
