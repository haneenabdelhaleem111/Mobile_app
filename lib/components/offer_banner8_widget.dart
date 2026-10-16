import '/components/button8_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'offer_banner8_model.dart';
export 'offer_banner8_model.dart';

class OfferBanner8Widget extends StatefulWidget {
  const OfferBanner8Widget({
    super.key,
    String? imageDesc,
    String? subtitle,
    String? title,
  })  : imageDesc = imageDesc ??
            'https://dimg.dreamflow.cloud/v1/image/luxury%20skincare%20bottles%20with%20water%20droplets',
        subtitle = subtitle ?? 'Up to 30% off on La Roche-Posay & Vichy',
        title = title ?? 'Dermacosmetics';

  final String imageDesc;
  final String subtitle;
  final String title;

  @override
  State<OfferBanner8Widget> createState() => _OfferBanner8WidgetState();
}

class _OfferBanner8WidgetState extends State<OfferBanner8Widget> {
  late OfferBanner8Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OfferBanner8Model());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.0),
      child: Container(
        height: 160.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primary,
          borderRadius: BorderRadius.circular(24.0),
          shape: BoxShape.rectangle,
        ),
        child: Stack(
          alignment: const AlignmentDirectional(-1.0, -1.0),
          children: [
            Opacity(
              opacity: 0.4,
              child: CachedNetworkImage(
                fadeInDuration: const Duration(milliseconds: 0),
                fadeOutDuration: const Duration(milliseconds: 0),
                imageUrl: valueOrDefault<String>(
                  widget.imageDesc,
                  'https://dimg.dreamflow.cloud/v1/image/luxury%20skincare%20bottles%20with%20water%20droplets',
                ),
                fit: BoxFit.cover,
                alignment: const Alignment(0.0, 0.0),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: const LinearGradient(
                  colors: const [Color(0xCC0056B3), Colors.transparent],
                  stops: const [0.0, 1.0],
                  begin: const AlignmentDirectional(-1.0, 0.0),
                  end: const AlignmentDirectional(1.0, 0),
                ),
                shape: BoxShape.rectangle,
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  child: Container(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              valueOrDefault<String>(
                                widget.title,
                                'Dermacosmetics',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FontWeight.w800,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontStyle,
                                    lineHeight: 1.3,
                                  ),
                            ),
                            Text(
                              valueOrDefault<String>(
                                widget.subtitle,
                                'Up to 30% off on La Roche-Posay & Vichy',
                              ),
                              maxLines: 2,
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                                    color: const Color(0xE6FFFFFF),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                            ),
                          ].divide(const SizedBox(height: 4.0)),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              4.0, 0.0, 4.0, 0.0),
                          child: Container(
                            child: Container(
                              child: wrapWithModel(
                                model: _model.buttonModel,
                                updateCallback: () => safeSetState(() {}),
                                child: const Button8Widget(
                                  iconPresent: false,
                                  iconEndPresent: false,
                                  content: 'Shop Now',
                                  variant: 'secondary',
                                  size: 'small',
                                  fullWidth: false,
                                  loading: false,
                                  disabled: false,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ].divide(const SizedBox(height: 8.0)),
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
