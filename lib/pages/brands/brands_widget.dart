import '/components/brand_logo_card2_widget.dart';
import '/components/button26_widget.dart';
import '/components/emshaty_search_bar3_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'brands_model.dart';
export 'brands_model.dart';

class BrandsWidget extends StatefulWidget {
  const BrandsWidget({super.key});

  static String routeName = 'brands';
  static String routePath = '/brands';

  @override
  State<BrandsWidget> createState() => _BrandsWidgetState();
}

class _BrandsWidgetState extends State<BrandsWidget> {
  late BrandsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BrandsModel());
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
                        16.0, 24.0, 16.0, 8.0),
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
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
                                      Icons.arrow_back_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
                                      context.safePop();
                                    },
                                  ),
                                  Text(
                                    'Our Brands',
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
                                          color: FlutterFlowTheme.of(context)
                                              .vibrantColor,
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
                                ].divide(const SizedBox(width: 16.0)),
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 16.0,
                                buttonSize: 40.0,
                                fillColor: const Color(0x1A0056B3),
                                icon: Icon(
                                  Icons.shopping_basket_rounded,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 24.0,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                            ],
                          ),
                          wrapWithModel(
                            model: _model.emshatySearchBarModel,
                            updateCallback: () => safeSetState(() {}),
                            child: const EmshatySearchBar3Widget(),
                          ),
                        ].divide(const SizedBox(height: 16.0)),
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
                        padding: const EdgeInsets.all(24.0),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(24.0),
                                child: Container(
                                  height: 180.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primary,
                                    borderRadius: BorderRadius.circular(24.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Stack(
                                    alignment:
                                        const AlignmentDirectional(-1.0, -1.0),
                                    children: [
                                      Opacity(
                                        opacity: 0.4,
                                        child: CachedNetworkImage(
                                          fadeInDuration:
                                              const Duration(milliseconds: 0),
                                          fadeOutDuration:
                                              const Duration(milliseconds: 0),
                                          imageUrl:
                                              'https://dimg.dreamflow.cloud/v1/image/luxury%20skincare%20brand%20aesthetic%20background',
                                          fit: BoxFit.cover,
                                          alignment: const Alignment(0.0, 0.0),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              Colors.transparent
                                            ],
                                            stops: const [0.0, 1.0],
                                            begin: const AlignmentDirectional(
                                                -1.0, 0.0),
                                            end: const AlignmentDirectional(
                                                1.0, 0),
                                          ),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(24.0),
                                          child: Container(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            8.0, 4.0, 8.0, 4.0),
                                                    child: Container(
                                                      child: Text(
                                                        'BRAND OF THE MONTH',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .labelSmall
                                                            .override(
                                                              font: GoogleFonts
                                                                  .inter(
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontStyle,
                                                              ),
                                                              color:
                                                                  Colors.white,
                                                              letterSpacing:
                                                                  0.0,
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
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'La Roche-Posay',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .headlineMedium
                                                      .override(
                                                        font: GoogleFonts
                                                            .interTight(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMedium
                                                                .fontStyle,
                                                        lineHeight: 1.25,
                                                      ),
                                                ),
                                                Text(
                                                  'Expert skincare for sensitive skin.\nRecommended by dermatologists.',
                                                  maxLines: 2,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodySmall
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmall
                                                                  .fontStyle,
                                                        ),
                                                        color: const Color(
                                                            0xE6FFFFFF),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .fontStyle,
                                                        lineHeight: 1.4,
                                                      ),
                                                ),
                                                wrapWithModel(
                                                  model: _model.buttonModel,
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child: const Button26Widget(
                                                    iconPresent: false,
                                                    iconEndPresent: false,
                                                    content:
                                                        'Explore Collection',
                                                    variant: 'secondary',
                                                    size: 'small',
                                                    fullWidth: false,
                                                    loading: false,
                                                    disabled: false,
                                                  ),
                                                ),
                                              ].divide(
                                                  const SizedBox(height: 8.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                        'All Partners',
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
                                      Text(
                                        '24 Brands',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLarge
                                                      .fontStyle,
                                              lineHeight: 1.3,
                                            ),
                                      ),
                                    ],
                                  ),
                                  GridView(
                                    padding: EdgeInsets.zero,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 16.0,
                                      mainAxisSpacing: 0.0,
                                      childAspectRatio: 1.0,
                                    ),
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    children: [
                                      wrapWithModel(
                                        model: _model.brandLogoCardModel1,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: const BrandLogoCard2Widget(
                                          name: 'La Roche-Posay',
                                          slug:
                                              'https://cdn.simpleicons.org/vichy/0056b3.svg',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.brandLogoCardModel2,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: const BrandLogoCard2Widget(
                                          name: 'Vichy',
                                          slug:
                                              'https://cdn.simpleicons.org/vichy/0056b3.svg',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.brandLogoCardModel3,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: const BrandLogoCard2Widget(
                                          name: 'Bioderma',
                                          slug:
                                              'https://cdn.simpleicons.org/vichy/0056b3.svg',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.brandLogoCardModel4,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: const BrandLogoCard2Widget(
                                          name: 'Centrum',
                                          slug:
                                              'https://cdn.simpleicons.org/vichy/0056b3.svg',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.brandLogoCardModel5,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: const BrandLogoCard2Widget(
                                          name: 'Panadol',
                                          slug:
                                              'https://cdn.simpleicons.org/vichy/0056b3.svg',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.brandLogoCardModel6,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: const BrandLogoCard2Widget(
                                          name: 'Eucerin',
                                          slug:
                                              'https://cdn.simpleicons.org/vichy/0056b3.svg',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.brandLogoCardModel7,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: const BrandLogoCard2Widget(
                                          name: 'Avene',
                                          slug:
                                              'https://cdn.simpleicons.org/vichy/0056b3.svg',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.brandLogoCardModel8,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: const BrandLogoCard2Widget(
                                          name: 'CeraVe',
                                          slug:
                                              'https://cdn.simpleicons.org/vichy/0056b3.svg',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.brandLogoCardModel9,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: const BrandLogoCard2Widget(
                                          name: 'Mustela',
                                          slug:
                                              'https://cdn.simpleicons.org/vichy/0056b3.svg',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.brandLogoCardModel10,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: const BrandLogoCard2Widget(
                                          name: 'Dettol',
                                          slug:
                                              'https://cdn.simpleicons.org/vichy/0056b3.svg',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.brandLogoCardModel11,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: const BrandLogoCard2Widget(
                                          name: 'Garnier',
                                          slug:
                                              'https://cdn.simpleicons.org/vichy/0056b3.svg',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.brandLogoCardModel12,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: const BrandLogoCard2Widget(
                                          name: 'Nivea',
                                          slug:
                                              'https://cdn.simpleicons.org/vichy/0056b3.svg',
                                        ),
                                      ),
                                    ],
                                  ),
                                ].divide(const SizedBox(height: 16.0)),
                              ),
                            ].divide(const SizedBox(height: 24.0)),
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
