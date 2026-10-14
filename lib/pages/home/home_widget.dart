import '/components/brand_logo_card_widget.dart';
import '/components/button24_widget.dart';
import '/components/emshaty_category2_widget.dart';
import '/components/emshaty_product_card2_widget.dart';
import '/components/emshaty_promo_banner2_widget.dart';
import '/components/emshaty_search_bar2_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  static String routeName = 'Home';
  static String routePath = '/home';

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());
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
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 8.0),
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment:
                                (FFMainAxisAlignment.spaceAround).flutterValue,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 50.0,
                                height: 50.0,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  'assets/images/Health_Care.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        (FFCrossAxisAlignment.start)
                                            .flutterValue,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        'El-Emshaty Pharmacy',
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
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
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.location_on_rounded,
                                            color: Color(0xFF0F172A),
                                            size: 14.0,
                                          ),
                                          Text(
                                            'Delivering to New Cairo',
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmall
                                                          .fontStyle,
                                                  lineHeight: 1.2,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 4.0)),
                                      ),
                                    ].divide(SizedBox(height: 4.0)),
                                  ),
                                ].divide(SizedBox(width: 16.0)),
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 16.0,
                                buttonSize: 40.0,
                                fillColor: Color(0x1A0056B3),
                                icon: Icon(
                                  Icons.shopping_bag_outlined,
                                  color:
                                      FlutterFlowTheme.of(context).vibrantColor,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  context
                                      .pushNamed(ShoppingCartWidget.routeName);
                                },
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 16.0,
                                buttonSize: 40.0,
                                fillColor: Color(0x1A0056B3),
                                icon: Icon(
                                  Icons.favorite_border,
                                  color:
                                      FlutterFlowTheme.of(context).vibrantColor,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  context.pushNamed(WishlistWidget.routeName);
                                },
                              ),
                            ],
                          ),
                          wrapWithModel(
                            model: _model.emshatySearchBarModel,
                            updateCallback: () => safeSetState(() {}),
                            child: EmshatySearchBar2Widget(),
                          ),
                        ].divide(SizedBox(height: 16.0)),
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
                        padding: EdgeInsets.all(24.0),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              wrapWithModel(
                                model: _model.emshatyPromoBannerModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: EmshatyPromoBanner2Widget(
                                  btnLabel: 'Shop Now',
                                  subtitle:
                                      'Boost your immunity today with our premium selection',
                                  title: '25% Off Vitamins',
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Shop by Category',
                                        style: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .override(
                                              font: GoogleFonts.interTight(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .fontStyle,
                                              lineHeight: 1.3,
                                            ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                              CategoryBrowserWidget.routeName);
                                        },
                                        child: wrapWithModel(
                                          model: _model.buttonModel1,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: Button24Widget(
                                            iconPresent: false,
                                            iconEndPresent: false,
                                            content: 'View All',
                                            variant: 'ghost',
                                            size: 'small',
                                            fullWidth: false,
                                            loading: false,
                                            disabled: false,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        wrapWithModel(
                                          model: _model.emshatyCategoryModel1,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: EmshatyCategory2Widget(
                                            icon: Icon(
                                              Icons.medical_services_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 28.0,
                                            ),
                                            tint: FlutterFlowTheme.of(context)
                                                .primary,
                                            title: 'Medicines',
                                          ),
                                        ),
                                        wrapWithModel(
                                          model: _model.emshatyCategoryModel2,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: EmshatyCategory2Widget(
                                            icon: Icon(
                                              Icons.face_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 28.0,
                                            ),
                                            tint: FlutterFlowTheme.of(context)
                                                .tertiary,
                                            title: 'Skincare',
                                          ),
                                        ),
                                        wrapWithModel(
                                          model: _model.emshatyCategoryModel3,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: EmshatyCategory2Widget(
                                            icon: Icon(
                                              Icons.workspace_premium_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 28.0,
                                            ),
                                            tint: FlutterFlowTheme.of(context)
                                                .success,
                                            title: 'Vitamins',
                                          ),
                                        ),
                                        wrapWithModel(
                                          model: _model.emshatyCategoryModel4,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: EmshatyCategory2Widget(
                                            icon: Icon(
                                              Icons.child_care_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 28.0,
                                            ),
                                            tint: FlutterFlowTheme.of(context)
                                                .info,
                                            title: 'Baby Care',
                                          ),
                                        ),
                                        wrapWithModel(
                                          model: _model.emshatyCategoryModel5,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: EmshatyCategory2Widget(
                                            icon: Icon(
                                              Icons.help,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 28.0,
                                            ),
                                            tint: FlutterFlowTheme.of(context)
                                                .warning,
                                            title: 'Devices',
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 16.0)),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Top Brands',
                                        style: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .override(
                                              font: GoogleFonts.interTight(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .fontStyle,
                                              lineHeight: 1.3,
                                            ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                              BrandsWidget.routeName);
                                        },
                                        child: wrapWithModel(
                                          model: _model.buttonModel2,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: Button24Widget(
                                            iconPresent: false,
                                            iconEndPresent: false,
                                            content: 'View All',
                                            variant: 'ghost',
                                            size: 'small',
                                            fullWidth: false,
                                            loading: false,
                                            disabled: false,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        wrapWithModel(
                                          model: _model.brandLogoCardModel1,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: BrandLogoCardWidget(
                                            name: 'La Roche-Posay',
                                            slug:
                                                'https://cdn.simpleicons.org/larocheposay/0056b3.svg',
                                          ),
                                        ),
                                        wrapWithModel(
                                          model: _model.brandLogoCardModel2,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: BrandLogoCardWidget(
                                            name: 'Vichy',
                                            slug:
                                                'https://cdn.simpleicons.org/vichy/0056b3.svg',
                                          ),
                                        ),
                                        wrapWithModel(
                                          model: _model.brandLogoCardModel3,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: BrandLogoCardWidget(
                                            name: 'Bioderma',
                                            slug:
                                                'https://cdn.simpleicons.org/bioderma/0056b3.svg',
                                          ),
                                        ),
                                        wrapWithModel(
                                          model: _model.brandLogoCardModel4,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: BrandLogoCardWidget(
                                            name: 'Centrum',
                                            slug:
                                                'https://cdn.simpleicons.org/centrum/0056b3.svg',
                                          ),
                                        ),
                                        wrapWithModel(
                                          model: _model.brandLogoCardModel5,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: BrandLogoCardWidget(
                                            name: 'Panadol',
                                            slug:
                                                'https://cdn.simpleicons.org/panadol/0056b3.svg',
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 16.0)),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Flash Deals',
                                        style: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .override(
                                              font: GoogleFonts.interTight(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .fontStyle,
                                              lineHeight: 1.3,
                                            ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context
                                              .pushNamed(DealsWidget.routeName);
                                        },
                                        child: wrapWithModel(
                                          model: _model.buttonModel3,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: Button24Widget(
                                            iconPresent: false,
                                            iconEndPresent: false,
                                            content: 'View All',
                                            variant: 'ghost',
                                            size: 'small',
                                            fullWidth: false,
                                            loading: false,
                                            disabled: false,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        wrapWithModel(
                                          model:
                                              _model.emshatyProductCardModel1,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: EmshatyProductCard2Widget(
                                            imgDesc:
                                                'https://dimg.dreamflow.cloud/v1/image/box%20of%20panadol%20medicine',
                                            name: 'Panadol Advance 500mg',
                                            price: 'EGP 45.00',
                                            oldPrice: 'EGP 55.00',
                                          ),
                                        ),
                                        wrapWithModel(
                                          model:
                                              _model.emshatyProductCardModel2,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: EmshatyProductCard2Widget(
                                            imgDesc:
                                                'https://dimg.dreamflow.cloud/v1/image/blue%20skincare%20bottle',
                                            name: 'La Roche-Posay Effaclar',
                                            price: 'EGP 680.00',
                                            oldPrice: 'e_g_p_55_00',
                                          ),
                                        ),
                                        wrapWithModel(
                                          model:
                                              _model.emshatyProductCardModel3,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: EmshatyProductCard2Widget(
                                            imgDesc:
                                                'https://dimg.dreamflow.cloud/v1/image/vitamin%20bottle',
                                            name: 'Centrum Silver Lutein',
                                            price: 'EGP 420.00',
                                            oldPrice: 'EGP 500.00',
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 16.0)),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                              wrapWithModel(
                                model: _model.emshatyPromoBannerModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: EmshatyPromoBanner2Widget(
                                  btnLabel: 'Shop Now',
                                  subtitle:
                                      'Boost your immunity today with our premium selection',
                                  title: '25% Off Vitamins',
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Our Products',
                                        style: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .override(
                                              font: GoogleFonts.interTight(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .fontStyle,
                                              lineHeight: 1.3,
                                            ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                              ProductsSearchWidget.routeName);
                                        },
                                        child: wrapWithModel(
                                          model: _model.buttonModel4,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: Button24Widget(
                                            iconPresent: false,
                                            iconEndPresent: false,
                                            content: 'View All',
                                            variant: 'ghost',
                                            size: 'small',
                                            fullWidth: false,
                                            loading: false,
                                            disabled: false,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        wrapWithModel(
                                          model:
                                              _model.emshatyProductCardModel4,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: EmshatyProductCard2Widget(
                                            imgDesc:
                                                'https://dimg.dreamflow.cloud/v1/image/box%20of%20panadol%20medicine',
                                            name: 'Panadol Advance 500mg',
                                            price: 'EGP 45.00',
                                            oldPrice: 'EGP 55.00',
                                          ),
                                        ),
                                        wrapWithModel(
                                          model:
                                              _model.emshatyProductCardModel5,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: EmshatyProductCard2Widget(
                                            imgDesc:
                                                'https://dimg.dreamflow.cloud/v1/image/blue%20skincare%20bottle',
                                            name: 'La Roche-Posay Effaclar',
                                            price: 'EGP 680.00',
                                            oldPrice: 'e_g_p_55_00',
                                          ),
                                        ),
                                        wrapWithModel(
                                          model:
                                              _model.emshatyProductCardModel6,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: EmshatyProductCard2Widget(
                                            imgDesc:
                                                'https://dimg.dreamflow.cloud/v1/image/vitamin%20bottle',
                                            name: 'Centrum Silver Lutein',
                                            price: 'EGP 420.00',
                                            oldPrice: 'EGP 500.00',
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 16.0)),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                            ].divide(SizedBox(height: 24.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
          ],
        ),
      ),
    );
  }
}
