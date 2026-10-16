import 'dart:convert';

import 'package:elemshaty_pharmacy/backend/woocommerce/woocommerce_catalog_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  test('does not accept the HTTP dev proxy in native or VM execution', () {
    expect(
      () => WooCommerceCatalogService(baseUrl: 'http://127.0.0.1:8787'),
      throwsArgumentError,
    );
  });

  test('requests products and sale products from the Store API paths',
      () async {
    final requests = <Uri>[];
    final client = MockClient((request) async {
      requests.add(request.url);
      return http.Response(
        jsonEncode([
          {
            'id': 7,
            'name': 'Catalog test product',
            'prices': {
              'price': '12500',
              'regular_price': '15000',
              'sale_price': '12500',
              'currency_code': 'EGP',
              'currency_symbol': 'EGP',
              'currency_minor_unit': 2,
            },
            'on_sale': true,
            'is_in_stock': true,
          }
        ]),
        200,
        headers: const {
          'content-type': 'application/json; charset=utf-8',
          'x-wp-totalpages': '1',
        },
      );
    });
    final service = WooCommerceCatalogService(
      client: client,
      baseUrl: 'https://catalog.example',
    );

    final products = await service.getProducts(perPage: 2);
    final deals = await service.getProducts(perPage: 2, onSale: true);

    expect(requests, hasLength(2));
    expect(requests[0].path, '/wp-json/wc/store/v1/products');
    expect(requests[0].queryParameters['per_page'], '2');
    expect(requests[0].queryParameters.containsKey('on_sale'), isFalse);
    expect(requests[1].path, '/wp-json/wc/store/v1/products');
    expect(requests[1].queryParameters['on_sale'], 'true');
    expect(products.items.single.id, 7);
    expect(deals.items.single.price, 125);
    expect(deals.items.single.isOnSale, isTrue);
  });
}
