import 'dart:async';
import '/components/button9_widget.dart';
import '/components/cart_item_widget.dart';
import '/components/summary_row_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/backend/woocommerce/cart_models.dart';
import '/backend/woocommerce/woocommerce_cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'shopping_cart_model.dart';
export 'shopping_cart_model.dart';

class ShoppingCartWidget extends StatefulWidget {
  const ShoppingCartWidget({super.key, this.cartController});

  final WooCommerceCartController? cartController;

  static String routeName = 'shopping_cart';
  static String routePath = '/shoppingCart';

  @override
  State<ShoppingCartWidget> createState() => _ShoppingCartWidgetState();
}

class _ShoppingCartWidgetState extends State<ShoppingCartWidget> {
  late ShoppingCartModel _model;
  late WooCommerceCartController _cartController;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShoppingCartModel());
    _cartController =
        widget.cartController ?? WooCommerceCartController.instance;
    _cartController.addListener(_onCartChanged);
    unawaited(_cartController.refreshCart());
  }

  void _onCartChanged() {
    if (mounted) safeSetState(() {});
  }

  @override
  void dispose() {
    _cartController.removeListener(_onCartChanged);
    _model.dispose();

    super.dispose();
  }

  Widget _buildCartItem(WooCartItem item) {
    final regularPrice = item.prices.regularPrice;
    final currentPrice = item.prices.price;
    return CartItemWidget(
      key: ValueKey(item.key),
      brand: item.sku.isEmpty ? 'Product' : item.sku,
      imageDesc: item.images.isEmpty ? '' : item.images.first,
      name: item.name,
      price: _formatPrice(
        currentPrice,
        item.prices.currencySymbol,
        item.prices.currencyCode,
        item.prices.currencyMinorUnit,
      ),
      qty: '${item.quantity}',
      hasDiscount: regularPrice != null &&
          currentPrice != null &&
          regularPrice > currentPrice,
      originalPrice: _formatPrice(
        regularPrice,
        item.prices.currencySymbol,
        item.prices.currencyCode,
        item.prices.currencyMinorUnit,
      ),
      isBusy: _cartController.isMutationInProgress,
      onDecrease: item.quantity > 1
          ? () => _cartController.updateItem(
                key: item.key,
                quantity: item.quantity - 1,
              )
          : null,
      onIncrease: () => _cartController.updateItem(
        key: item.key,
        quantity: item.quantity + 1,
      ),
      onRemove: () => _cartController.removeItem(key: item.key),
    );
  }

  Widget _cartMessage(String message, {Future<void> Function()? onRetry}) =>
      Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              message == 'Your cart is empty.'
                  ? Icons.shopping_cart_outlined
                  : Icons.cloud_off_outlined,
              size: 40,
              color: FlutterFlowTheme.of(context).secondaryText,
            ),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            if (onRetry != null)
              TextButton(
                onPressed: () => onRetry(),
                child: const Text('Refresh cart'),
              ),
          ],
        ),
      );

  Widget _cartErrorBanner() => Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
        child: Material(
          color: FlutterFlowTheme.of(context).error.withValues(alpha: .08),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(child: Text(_cartController.errorMessage!)),
                TextButton(
                  onPressed: _cartController.isLoading
                      ? null
                      : _cartController.refreshCart,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );

  String _formatCartAmount(num? amount, WooCartTotals? totals) => totals == null
      ? '—'
      : _formatPrice(
          amount,
          totals.currencySymbol,
          totals.currencyCode,
          totals.currencyMinorUnit,
        );

  String _formatPrice(
    num? amount,
    String currencySymbol,
    String currencyCode,
    int minorUnit,
  ) {
    if (amount == null) return '—';
    final currency = currencySymbol.isNotEmpty ? currencySymbol : currencyCode;
    final digits = minorUnit.clamp(0, 4).toInt();
    final value = amount.toStringAsFixed(digits);
    return currency.isEmpty ? value : '$currency $value';
  }

  @override
  Widget build(BuildContext context) {
    final cart = _cartController.cart;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        24.0, 24.0, 24.0, 16.0),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 40.0,
                                fillColor: Colors.transparent,
                                icon: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 20.0,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                              Text(
                                'Shopping Cart',
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .vibrantColor,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                      lineHeight: 1.3,
                                    ),
                              ),
                            ].divide(const SizedBox(width: 8.0)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 16.0, 0.0, 0.0),
                        child: Container(
                          decoration: const BoxDecoration(),
                          child: Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(16.0),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.local_offer_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .vibrantColor,
                                          size: 24.0,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Apply Promo Code',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                  lineHeight: 1.5,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          'Apply',
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .vibrantColor,
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontStyle,
                                                lineHeight: 1.3,
                                              ),
                                        ),
                                      ].divide(const SizedBox(width: 16.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (_cartController.isLoading && cart != null)
                                const LinearProgressIndicator(),
                              if (_cartController.isLoading && cart == null)
                                const Padding(
                                  padding: EdgeInsets.all(32),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                )
                              else if (cart == null)
                                _cartMessage(
                                  _cartController.errorMessage ??
                                      'Your cart is unavailable.',
                                  onRetry: _cartController.refreshCart,
                                )
                              else if (cart.items.isEmpty) ...[
                                if (_cartController.errorMessage != null)
                                  _cartErrorBanner(),
                                _cartMessage(
                                  'Your cart is empty.',
                                  onRetry: _cartController.isLoading
                                      ? null
                                      : _cartController.refreshCart,
                                ),
                              ] else ...[
                                if (_cartController.errorMessage != null)
                                  _cartErrorBanner(),
                                ...cart.items.map(_buildCartItem),
                              ],
                            ].divide(const SizedBox(height: 16.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: cart?.items.isNotEmpty == true,
              child: Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 12.0,
                        color: const Color(0x0F000000),
                        offset: const Offset(
                          0.0,
                          -4.0,
                        ),
                        spreadRadius: 0.0,
                      )
                    ],
                    borderRadius: const BorderRadius.only(
                      topLeft: const Radius.circular(24.0),
                      topRight: const Radius.circular(24.0),
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          wrapWithModel(
                            model: _model.summaryRowModel1,
                            updateCallback: () => safeSetState(() {}),
                            child: SummaryRowWidget(
                              label: 'Subtotal',
                              value: _formatCartAmount(
                                cart?.totals.totalItems,
                                cart?.totals,
                              ),
                              color: 'success',
                              isTotal: false,
                              bold: true,
                            ),
                          ),
                          wrapWithModel(
                            model: _model.summaryRowModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: SummaryRowWidget(
                              label: 'Delivery Fee',
                              value: _formatCartAmount(
                                cart?.totals.totalShipping,
                                cart?.totals,
                              ),
                              color: 'success',
                              isTotal: false,
                              bold: true,
                            ),
                          ),
                          Divider(
                            height: 16.0,
                            thickness: 1.0,
                            indent: 0.0,
                            endIndent: 0.0,
                            color: FlutterFlowTheme.of(context).alternate,
                          ),
                          wrapWithModel(
                            model: _model.summaryRowModel3,
                            updateCallback: () => safeSetState(() {}),
                            child: SummaryRowWidget(
                              label: 'Total Amount',
                              value: _formatCartAmount(
                                cart?.totals.totalPrice,
                                cart?.totals,
                              ),
                              color: 'success',
                              isTotal: true,
                              bold: true,
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (_cartController.isMutationInProgress ||
                                  cart == null ||
                                  cart.items.isEmpty) {
                                return;
                              }
                              context
                                  .pushNamed(CheckoutDeliveryWidget.routeName);
                            },
                            child: wrapWithModel(
                              model: _model.buttonModel,
                              updateCallback: () => safeSetState(() {}),
                              child: Button9Widget(
                                iconPresent: false,
                                iconEnd: Icon(
                                  Icons.arrow_forward_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .lightMutedColor,
                                  size: 24.0,
                                ),
                                iconEndPresent: true,
                                content: 'Proceed to Checkout',
                                variant: 'primary',
                                size: 'large',
                                fullWidth: true,
                                loading: false,
                                disabled: _cartController.isMutationInProgress,
                              ),
                            ),
                          ),
                        ].divide(const SizedBox(height: 16.0)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
