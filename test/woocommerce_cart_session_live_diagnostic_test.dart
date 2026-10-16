import 'package:elemshaty_pharmacy/backend/woocommerce/woocommerce_cart_session_diagnostic.dart';
import 'package:flutter_test/flutter_test.dart';

const _runLiveCartDiagnostic = bool.fromEnvironment(
  'RUN_WOOCOMMERCE_CART_SESSION_DIAGNOSTIC',
  defaultValue: false,
);

void main() {
  test(
    'optional native GET reports the public cart session diagnostics',
    () async {
      final diagnostic = WooCommerceCartSessionDiagnostic();
      final result = await diagnostic.run();
      // The summary contains only status, parse outcome, response keys,
      // Cart-Token presence, and a sanitized category.
      // ignore: avoid_print
      print(result.diagnosticLine);
      expect(result.statusCode, isNotNull);
    },
    skip: !_runLiveCartDiagnostic,
  );
}
