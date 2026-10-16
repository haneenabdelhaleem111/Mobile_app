import '/components/checkout_step_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import '../../backend/woocommerce/cart_models.dart';
import '../../backend/woocommerce/checkout_models.dart';
import '../../backend/woocommerce/woocommerce_cart_controller.dart';
import 'checkout_delivery_model.dart';

export 'checkout_delivery_model.dart';

class CheckoutDeliveryWidget extends StatefulWidget {
  const CheckoutDeliveryWidget({super.key, this.cartController});

  /// Injectable for widget tests; normal navigation uses the shared cart.
  final WooCommerceCartController? cartController;

  static String routeName = 'checkout_delivery';
  static String routePath = '/checkoutDelivery';

  @override
  State<CheckoutDeliveryWidget> createState() => _CheckoutDeliveryWidgetState();
}

class _CheckoutDeliveryWidgetState extends State<CheckoutDeliveryWidget> {
  late CheckoutDeliveryModel _model;
  late WooCommerceCartController _cartController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _cartController =
        widget.cartController ?? WooCommerceCartController.instance;
    _model = createModel(context, () => CheckoutDeliveryModel());
    if (!_cartController.hasLoadedCart && !_cartController.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted &&
            !_cartController.hasLoadedCart &&
            !_cartController.isLoading) {
          _cartController.loadCart();
        }
      });
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryBackground,
        appBar: AppBar(
          backgroundColor: theme.secondaryBackground,
          foregroundColor: theme.primaryText,
          elevation: 0,
          leading: IconButton(
            tooltip: 'Back',
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => context.pop(),
          ),
          title: const Text('Checkout'),
        ),
        body: AnimatedBuilder(
          animation: _cartController,
          builder: (context, _) {
            final cart = _cartController.cart;
            return Column(
              children: [
                _buildSteps(),
                Expanded(
                  child: Form(
                    key: _model.formKey,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildAddressForm(),
                          const SizedBox(height: 20),
                          _buildDeliveryInfo(cart),
                          const SizedBox(height: 20),
                          _buildPaymentMethods(),
                          const SizedBox(height: 20),
                          _buildCartSummary(cart),
                        ],
                      ),
                    ),
                  ),
                ),
                _buildFooter(cart),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSteps() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            const Expanded(
              child: CheckoutStepWidget(
                done: false,
                title: 'Address',
                active: true,
              ),
            ),
            Expanded(
                child: Divider(color: FlutterFlowTheme.of(context).alternate)),
            const Expanded(
              child: CheckoutStepWidget(
                done: false,
                title: 'Payment',
                active: false,
              ),
            ),
            Expanded(
                child: Divider(color: FlutterFlowTheme.of(context).alternate)),
            const Expanded(
              child: CheckoutStepWidget(
                done: false,
                title: 'Review',
                active: false,
              ),
            ),
          ],
        ),
      );

  Widget _buildAddressForm() => _section(
        title: 'Billing information',
        child: Column(
          children: [
            _field(
              controller: _model.billingNameController,
              label: 'Full name',
              validator: _personName,
              textCapitalization: TextCapitalization.words,
            ),
            _field(
              controller: _model.billingEmailController,
              label: 'Billing email',
              validator: _email,
              keyboardType: TextInputType.emailAddress,
            ),
            _field(
              controller: _model.billingPhoneController,
              label: 'Billing phone',
              validator: _phone,
              keyboardType: TextInputType.phone,
            ),
            _field(
              controller: _model.billingAddressController,
              label: 'Billing street address',
              validator: _required,
              textCapitalization: TextCapitalization.sentences,
            ),
            _field(
              controller: _model.billingCityController,
              label: 'Billing city',
              validator: _required,
              textCapitalization: TextCapitalization.words,
            ),
            _field(
              controller: _model.billingCountryController,
              label: 'Billing country code (for example, EG)',
              validator: _countryCode,
              textCapitalization: TextCapitalization.characters,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Delivery address',
                style: FlutterFlowTheme.of(context).titleSmall,
              ),
            ),
            const SizedBox(height: 8),
            _field(
              controller: _model.shippingNameController,
              label: 'Recipient full name',
              validator: _personName,
              textCapitalization: TextCapitalization.words,
            ),
            _field(
              controller: _model.shippingAddressController,
              label: 'Street address',
              validator: _required,
              textCapitalization: TextCapitalization.sentences,
            ),
            _field(
              controller: _model.shippingCityController,
              label: 'City',
              validator: _required,
              textCapitalization: TextCapitalization.words,
            ),
            _field(
              controller: _model.shippingCountryController,
              label: 'Country code (for example, EG)',
              validator: _countryCode,
              textCapitalization: TextCapitalization.characters,
            ),
            _field(
              controller: _model.shippingPhoneController,
              label: 'Delivery phone',
              validator: _phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 8),
            Text(
              'Enter the customer details for this delivery. No account is assumed.',
              style: FlutterFlowTheme.of(context).bodySmall,
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              key: const Key('validate-checkout-details'),
              onPressed: _validateDetails,
              child: const Text('Check information'),
            ),
          ],
        ),
      );

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextFormField(
          key: Key('checkout-field-$label'),
          controller: controller,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          validator: validator,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
        ),
      );

  Widget _buildDeliveryInfo(WooCart? cart) => _section(
        title: 'Delivery method',
        child: Row(
          children: [
            Icon(Icons.local_shipping_rounded,
                color: FlutterFlowTheme.of(context).primary),
            const SizedBox(width: 12),
            const Expanded(child: Text('Shipping')),
            Text(_money(cart?.totals.totalShipping, cart?.totals)),
          ],
        ),
      );

  Widget _buildPaymentMethods() => _section(
        title: 'Payment method',
        child: Text(
          'Payment options are not provided by the current checkout response. No method has been selected.',
          key: const Key('checkout-payment-methods-unavailable'),
          style: FlutterFlowTheme.of(context).bodyMedium,
        ),
      );

  Widget _buildCartSummary(WooCart? cart) {
    if (_cartController.isLoading && cart == null) {
      return _section(
        title: 'Order summary',
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_cartController.errorMessage != null && cart == null) {
      return _section(
        title: 'Order summary',
        child: Text(
          'Could not load your cart: ${_cartController.errorMessage}',
          key: const Key('checkout-cart-error'),
          style: TextStyle(color: FlutterFlowTheme.of(context).error),
        ),
      );
    }
    if (cart == null || cart.items.isEmpty) {
      return _section(
        title: 'Order summary',
        child: const Text(
          'Your cart is empty.',
          key: Key('checkout-empty-cart'),
        ),
      );
    }
    final totals = cart.totals;
    return _section(
      title: 'Order summary',
      child: Column(
        children: [
          _summaryRow(
              'Items (${cart.itemsCount})', _money(totals.totalItems, totals)),
          _summaryRow('Shipping', _money(totals.totalShipping, totals)),
          _summaryRow(
            'Discount',
            totals.totalDiscount == null
                ? 'Unavailable'
                : '- ${_money(totals.totalDiscount!.abs(), totals)}',
          ),
          const Divider(height: 24),
          _summaryRow('Total amount', _money(totals.totalPrice, totals),
              bold: true),
        ],
      ),
    );
  }

  Widget _buildFooter(WooCart? cart) {
    final total =
        cart == null ? '—' : _money(cart.totals.totalPrice, cart.totals);
    return Material(
      color: FlutterFlowTheme.of(context).secondaryBackground,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Total amount: $total',
                key: const Key('checkout-footer-total')),
            const SizedBox(height: 8),
            FilledButton(
              key: const Key('place-order-disabled'),
              onPressed: null,
              child: const Text('Confirm & Place Order'),
            ),
            const SizedBox(height: 4),
            Text(
              'Order placement is disabled in this phase.',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _section({required String title, required Widget child}) => Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: FlutterFlowTheme.of(context).alternate),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: FlutterFlowTheme.of(context).titleMedium),
            const SizedBox(height: 14),
            child,
          ],
        ),
      );

  Widget _summaryRow(String label, String value, {bool bold = false}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: bold
                    ? FlutterFlowTheme.of(context).titleSmall
                    : FlutterFlowTheme.of(context).bodyMedium),
            Text(value,
                key: Key('checkout-total-$label'),
                style: bold
                    ? FlutterFlowTheme.of(context).titleSmall
                    : FlutterFlowTheme.of(context).bodyMedium),
          ],
        ),
      );

  void _validateDetails() {
    final valid = _model.formKey.currentState?.validate() ?? false;
    if (valid) {
      final billingName = _nameParts(_model.billingNameController.text);
      final shippingName = _nameParts(_model.shippingNameController.text);
      _model.billingAddress = WooCheckoutAddress(
        firstName: billingName.$1,
        lastName: billingName.$2,
        address1: _model.billingAddressController.text.trim(),
        city: _model.billingCityController.text.trim(),
        country: _model.billingCountryController.text.trim().toUpperCase(),
        email: _model.billingEmailController.text.trim(),
        phone: _model.billingPhoneController.text.trim(),
      );
      _model.shippingAddress = WooCheckoutAddress(
        firstName: shippingName.$1,
        lastName: shippingName.$2,
        address1: _model.shippingAddressController.text.trim(),
        city: _model.shippingCityController.text.trim(),
        country: _model.shippingCountryController.text.trim().toUpperCase(),
        phone: _model.shippingPhoneController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Information is complete. Order placement remains disabled.',
          ),
        ),
      );
    }
  }

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'Required' : null;

  String? _personName(String? value) {
    if (_required(value) != null) return 'Required';
    return _nameParts(value!).$2.isEmpty ? 'Enter first and last name' : null;
  }

  String? _phone(String? value) {
    if (_required(value) != null) return 'Required';
    final digits = value!.replaceAll(RegExp(r'\D'), '');
    return digits.length >= 7 ? null : 'Enter a valid phone number';
  }

  String? _countryCode(String? value) {
    if (_required(value) != null) return 'Required';
    return RegExp(r'^[A-Za-z]{2}$').hasMatch(value!.trim())
        ? null
        : 'Enter a 2-letter country code';
  }

  String? _email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value.trim())
        ? null
        : 'Enter a valid email';
  }

  (String, String) _nameParts(String value) {
    final parts = value.trim().split(RegExp(r'\s+'));
    if (parts.length < 2) return (parts.first, '');
    return (parts.first, parts.skip(1).join(' '));
  }

  String _money(num? amount, WooCartTotals? totals) {
    if (amount == null || totals == null) return 'Unavailable';
    final currency = totals.currencySymbol.isNotEmpty
        ? totals.currencySymbol
        : totals.currencyCode;
    if (currency.isEmpty) return 'Unavailable';
    final decimals = totals.currencyMinorUnit.clamp(0, 6).toInt();
    return '$currency ${amount.toStringAsFixed(decimals)}';
  }
}
