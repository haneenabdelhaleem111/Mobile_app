import 'package:elemshaty_pharmacy/backend/woocommerce/catalog_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WooProduct.fromJson', () {
    test('parses Store API prices, images, categories, and stock', () {
      final product = WooProduct.fromJson({
        'id': 42,
        'name': 'Vitamin C',
        'slug': 'vitamin-c',
        'permalink': 'https://example.test/product/vitamin-c',
        'description': '<p>Daily supplement</p>',
        'short_description': '<p>Vitamin C tablets</p>',
        'on_sale': true,
        'is_in_stock': false,
        'stock_status': 'outofstock',
        'prices': {
          'price': '9000',
          'regular_price': '12000',
          'sale_price': '9000',
          'currency_code': 'EGP',
          'currency_symbol': 'EGP',
          'currency_minor_unit': 2,
        },
        'images': [
          {'src': 'https://example.test/vitamin-c.jpg', 'name': 'Vitamin C'}
        ],
        'categories': [
          {'name': 'Supplements'}
        ],
      });

      expect(product.id, 42);
      expect(product.price, 90);
      expect(product.regularPrice, 120);
      expect(product.salePrice, 90);
      expect(product.isOnSale, isTrue);
      expect(product.isInStock, isFalse);
      expect(product.imageUrl, 'https://example.test/vitamin-c.jpg');
      expect(product.categories, ['Supplements']);
      expect(product.formatPrice(product.price), 'EGP 90.00');
    });

    test('handles missing optional fields without failing', () {
      final product = WooProduct.fromJson({'id': '7', 'name': 'Basic item'});

      expect(product.id, 7);
      expect(product.name, 'Basic item');
      expect(product.imageUrl, isEmpty);
      expect(product.price, isNull);
      expect(product.isInStock, isTrue);
      expect(product.categories, isEmpty);
    });
  });

  test('WooProductCategory parses category totals and optional image', () {
    final category = WooProductCategory.fromJson({
      'id': 3,
      'name': 'Skin Care',
      'slug': 'skin-care',
      'parent': 0,
      'count': 18,
      'image': {'src': 'https://example.test/skin.jpg'},
    });

    expect(category.id, 3);
    expect(category.count, 18);
    expect(category.imageUrl, 'https://example.test/skin.jpg');
  });
}
