import 'checkout_models.dart';
import 'woocommerce_cart_service.dart';

/// Checkout API facade sharing the singleton cart service's transport and
/// session headers. It does not manage a separate cart session.
class WooCommerceCheckoutService {
  WooCommerceCheckoutService({WooCommerceCartService? cartService})
      : _cartService = cartService ?? WooCommerceCartService.instance;

  static final WooCommerceCheckoutService instance =
      WooCommerceCheckoutService(cartService: WooCommerceCartService.instance);

  final WooCommerceCartService _cartService;

  Future<WooCheckoutSession> getCheckout() async => WooCheckoutSession.fromJson(
        await _cartService.requestCheckout(method: 'GET'),
      );

  Future<WooCheckoutSession> updateCheckout(
    WooCheckoutUpdate update,
  ) async =>
      WooCheckoutSession.fromJson(
        await _cartService.requestCheckout(
          method: 'PUT',
          query: {
            '__experimental_calc_totals':
                update.recalculateTotals ? 'true' : 'false',
          },
          body: update.toJson(),
        ),
      );

  /// Performs the final Store API checkout POST. This operation may create an
  /// order and trigger payment; callers must invoke it only after explicit
  /// confirmation. No live invocation is made by this phase.
  Future<WooCheckoutSession> submitOrder(
    WooCheckoutOrderRequest order,
  ) async =>
      WooCheckoutSession.fromJson(
        await _cartService.requestCheckout(
          method: 'POST',
          body: order.toJson(),
        ),
      );
}
