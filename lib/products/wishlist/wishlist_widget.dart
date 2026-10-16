import '/components/product_card11_widget.dart';
import '/components/text_field7_widget.dart';
import '/components/wishlist_product_card2_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'wishlist_model.dart';
export 'wishlist_model.dart';

class WishlistWidget extends StatefulWidget {
  const WishlistWidget({super.key});

  static String routeName = 'wishlist';
  static String routePath = '/wishlist';

  @override
  State<WishlistWidget> createState() => _WishlistWidgetState();
}

class _WishlistWidgetState extends State<WishlistWidget> {
  late WishlistModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WishlistModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        16.0, 24.0, 16.0, 24.0),
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
                                'My Wishlist',
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                      lineHeight: 1.3,
                                    ),
                              ),
                            ].divide(const SizedBox(width: 16.0)),
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
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              wrapWithModel(
                                model: _model.textFieldModel,
                                updateCallback: () => safeSetState(() {}),
                                child: TextField7Widget(
                                  label: '',
                                  labelPresent: false,
                                  helper: '',
                                  helperPresent: false,
                                  leadingIcon: Icon(
                                    Icons.search_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  leadingIconPresent: true,
                                  trailingIconPresent: false,
                                  hint: 'Search saved items',
                                  value: '',
                                  onChange: '',
                                  onSubmit: '',
                                  variant: 'filled',
                                  error: false,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.wishlistProductCardModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: const WishlistProductCard2Widget(
                                  imageDesc:
                                      'https://dimg.dreamflow.cloud/v1/image/panadol%20medicine%20box',
                                  name: 'Panadol Advance 500mg - 24 Tablets',
                                  price: 'EGP 40.00',
                                  inStock: true,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.wishlistProductCardModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: const WishlistProductCard2Widget(
                                  imageDesc:
                                      'https://dimg.dreamflow.cloud/v1/image/white%20skincare%20tube',
                                  name: 'La Roche-Posay Effaclar Duo+ 40ml',
                                  price: 'EGP 650.00',
                                  inStock: true,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.wishlistProductCardModel3,
                                updateCallback: () => safeSetState(() {}),
                                child: const WishlistProductCard2Widget(
                                  imageDesc:
                                      'https://dimg.dreamflow.cloud/v1/image/blue%20glass%20serum%20bottle',
                                  name: 'Vichy Mineral 89 Booster Serum',
                                  price: 'EGP 890.00',
                                  inStock: false,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.wishlistProductCardModel4,
                                updateCallback: () => safeSetState(() {}),
                                child: const WishlistProductCard2Widget(
                                  imageDesc: '',
                                  name: 'Oral-B Pro-Expert Toothpaste',
                                  price: 'EGP 120.00',
                                  inStock: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                child: Container(
                                  child: Container(
                                    child: Text(
                                      'Suggested for you',
                                      style: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            font: GoogleFonts.interTight(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                            lineHeight: 1.4,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: wrapWithModel(
                                      model: _model.productCardModel1,
                                      updateCallback: () => safeSetState(() {}),
                                      child: const ProductCard11Widget(
                                        imageDesc:
                                            'https://dimg.dreamflow.cloud/v1/image/vitamin%20bottle',
                                        name: 'Vitamin C 1000mg',
                                        originalPrice: 'e_g_p_720_00',
                                        price: 'EGP 150.00',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: wrapWithModel(
                                      model: _model.productCardModel2,
                                      updateCallback: () => safeSetState(() {}),
                                      child: const ProductCard11Widget(
                                        imageDesc:
                                            'https://dimg.dreamflow.cloud/v1/image/small%20gel%20bottle',
                                        name: 'Hand Sanitizer',
                                        originalPrice: 'e_g_p_720_00',
                                        price: 'EGP 45.00',
                                      ),
                                    ),
                                  ),
                                ].divide(const SizedBox(width: 16.0)),
                              ),
                            ].divide(const SizedBox(height: 16.0)),
                          ),
                        ),
                      ),
                    ],
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
