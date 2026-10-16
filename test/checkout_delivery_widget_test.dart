import 'dart:async';

import 'package:elemshaty_pharmacy/backend/woocommerce/cart_models.dart';
import 'package:elemshaty_pharmacy/backend/woocommerce/woocommerce_cart_controller.dart';
import 'package:elemshaty_pharmacy/backend/woocommerce/woocommerce_cart_service.dart';
import 'package:elemshaty_pharmacy/shopping/checkout_delivery/checkout_delivery_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows cart loading then server-provided totals', (tester) async {
    final completer = Completer<WooCart>();
    final controller = _controller(() => completer.future);
    await tester.pumpWidget(MaterialApp(
      home: CheckoutDeliveryWidget(cartController: controller),
    ));
    await tester.pump();
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    completer.complete(_cart());
    await tester.pumpAndSettle();

    expect(find.text('Items (2)'), findsOneWidget);
    expect(find.text('EGP 100.00'), findsOneWidget);
    expect(find.text('EGP 12.00'), findsOneWidget);
    expect(find.text('- EGP 5.00'), findsOneWidget);
    expect(find.text('EGP 107.00'), findsNWidgets(2));
    expect(find.text('Subtotal (3 items)'), findsNothing);
  });

  testWidgets('shows cart API errors and empty cart state', (tester) async {
    final failed = _controller(() async {
      throw const WooCartException('Mock cart unavailable.');
    });
    await tester.pumpWidget(MaterialApp(
      home: CheckoutDeliveryWidget(cartController: failed),
    ));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('checkout-cart-error')), findsOneWidget);
    expect(find.textContaining('Mock cart unavailable.'), findsOneWidget);

    final empty = _controller(() async => _cart(items: const []));
    await tester.pumpWidget(MaterialApp(
      home: CheckoutDeliveryWidget(cartController: empty),
    ));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('checkout-empty-cart')), findsOneWidget);
  });

  testWidgets('validates customer-entered billing and shipping fields',
      (tester) async {
    final controller = _controller(() async => _cart());
    await tester.pumpWidget(MaterialApp(
      home: CheckoutDeliveryWidget(cartController: controller),
    ));
    await tester.pumpAndSettle();

    final checkButton = find.byKey(const Key('validate-checkout-details'));
    await tester.ensureVisible(checkButton);
    await tester.tap(checkButton);
    await tester.pumpAndSettle();
    expect(find.text('Required'), findsWidgets);
    expect(find.text('Enter a valid email'), findsNothing);

    const values = <String, String>{
      'Full name': 'Test Buyer',
      'Billing email': 'buyer@example.test',
      'Billing phone': '01012345678',
      'Billing street address': '1 Test Road',
      'Billing city': 'Cairo',
      'Billing country code (for example, EG)': 'EG',
      'Recipient full name': 'Test Buyer',
      'Street address': '2 Delivery Road',
      'City': 'Cairo',
      'Country code (for example, EG)': 'EG',
      'Delivery phone': '01012345678',
    };
    for (final entry in values.entries) {
      final field = find.byKey(Key('checkout-field-${entry.key}'));
      await tester.ensureVisible(field);
      await tester.enterText(field, entry.value);
    }
    await tester.ensureVisible(checkButton);
    await tester.tap(checkButton);
    await tester.pumpAndSettle();

    expect(
        find.text('Information is complete. Order placement remains disabled.'),
        findsOneWidget);
    expect(find.byKey(const Key('place-order-disabled')), findsOneWidget);
    final placeOrder = tester.widget<FilledButton>(
      find.byKey(const Key('place-order-disabled')),
    );
    expect(placeOrder.onPressed, isNull);
  });

  testWidgets('does not invent a payment method or submit an order',
      (tester) async {
    var cartReads = 0;
    final controller = _controller(() async {
      cartReads++;
      return _cart();
    });
    await tester.pumpWidget(MaterialApp(
      home: CheckoutDeliveryWidget(cartController: controller),
    ));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('checkout-payment-methods-unavailable')),
        findsOneWidget);
    expect(find.text('Cash on Delivery'), findsNothing);
    expect(cartReads, 1);
    expect(find.byKey(const Key('place-order-disabled')), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(find.byKey(const Key('place-order-disabled')))
          .onPressed,
      isNull,
    );
  });
}

WooCommerceCartController _controller(Future<WooCart> Function() getCart) =>
    WooCommerceCartController(service: _FakeCartService(getCart));

class _FakeCartService extends WooCommerceCartService {
  _FakeCartService(this._getCart) : super(baseUrl: 'https://checkout.test');

  final Future<WooCart> Function() _getCart;

  @override
  Future<WooCart> getCart() => _getCart();
}

WooCart _cart({List<WooCartItem> items = const []}) => WooCart(
      items: items,
      itemsCount: items.isEmpty ? 0 : 2,
      itemsWeight: 0,
      needsPayment: true,
      needsShipping: true,
      hasCalculatedShipping: true,
      totals: const WooCartTotals(
        totalItems: 100,
        totalItemsTax: 0,
        totalFees: 0,
        totalFeesTax: 0,
        totalDiscount: 5,
        totalDiscountTax: 0,
        totalShipping: 12,
        totalShippingTax: 0,
        totalPrice: 107,
        taxLines: [],
        currencyCode: 'EGP',
        currencySymbol: 'EGP',
        currencyMinorUnit: 2,
      ),
    );
