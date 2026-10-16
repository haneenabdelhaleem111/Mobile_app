import '/components/button24_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'emshaty_promo_banner2_model.dart';
export 'emshaty_promo_banner2_model.dart';

class EmshatyPromoBanner2Widget extends StatefulWidget {
  const EmshatyPromoBanner2Widget({
    super.key,
    String? btnLabel,
    String? subtitle,
    String? title,
  })  : btnLabel = btnLabel ?? 'Shop Now',
        subtitle =
            subtitle ?? 'Boost your immunity today with our premium selection',
        title = title ?? '25% Off Vitamins';

  final String btnLabel;
  final String subtitle;
  final String title;

  @override
  State<EmshatyPromoBanner2Widget> createState() =>
      _EmshatyPromoBanner2WidgetState();
}

class _EmshatyPromoBanner2WidgetState extends State<EmshatyPromoBanner2Widget> {
  late EmshatyPromoBanner2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmshatyPromoBanner2Model());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            FlutterFlowTheme.of(context).primary,
            FlutterFlowTheme.of(context).secondary
          ],
          stops: const [0.0, 1.0],
          begin: const AlignmentDirectional(-1.0, 0.0),
          end: const AlignmentDirectional(1.0, 0),
        ),
        borderRadius: BorderRadius.circular(24.0),
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          child: Container(
            height: 112.0,
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        valueOrDefault<String>(
                          widget.title,
                          '25% Off Vitamins',
                        ),
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontStyle,
                                  lineHeight: 1.3,
                                ),
                      ),
                      Text(
                        valueOrDefault<String>(
                          widget.subtitle,
                          'Boost your immunity today with our premium selection',
                        ),
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontStyle,
                              ),
                              color: const Color(0xCCFFFFFF),
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
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            8.0, 0.0, 8.0, 0.0),
                        child: Container(
                          child: Container(
                            child: wrapWithModel(
                              model: _model.buttonModel,
                              updateCallback: () => safeSetState(() {}),
                              child: Button24Widget(
                                iconPresent: false,
                                iconEndPresent: false,
                                content: valueOrDefault<String>(
                                  widget.btnLabel,
                                  'Shop Now',
                                ),
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
                Container(
                  width: 100.0,
                  height: 100.0,
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: const Icon(
                    Icons.local_pharmacy_rounded,
                    color: const Color(0x33FFFFFF),
                    size: 80.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
