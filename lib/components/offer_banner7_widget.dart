import '/components/button7_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_palette/material_palette.dart';
import 'offer_banner7_model.dart';
export 'offer_banner7_model.dart';

class OfferBanner7Widget extends StatefulWidget {
  const OfferBanner7Widget({
    super.key,
    String? btnText,
    String? subtitle,
    String? title,
  })  : this.btnText = btnText ?? 'Shop Now',
        this.subtitle = subtitle ?? 'Boost your immunity today',
        this.title = title ?? '20% OFF Vitamins';

  final String btnText;
  final String subtitle;
  final String title;

  @override
  State<OfferBanner7Widget> createState() => _OfferBanner7WidgetState();
}

class _OfferBanner7WidgetState extends State<OfferBanner7Widget> {
  late OfferBanner7Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OfferBanner7Model());
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
      child: Stack(
        alignment: AlignmentDirectional(-1.0, -1.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                shape: BoxShape.rectangle,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return FbmGradientShaderFill(
                    width: constraints.maxWidth.isFinite
                        ? constraints.maxWidth
                        : 200.0,
                    height: constraints.maxHeight.isFinite
                        ? constraints.maxHeight
                        : 200.0,
                    params: ShaderParams(values: {
                      'gradientAngle': 135.0,
                      'gradientScale': 1.27,
                      'gradientOffset': 0.19,
                      'noiseIntensity': 0.81,
                      'ditherStrength': 0.0,
                      'ditherScale': 1.0,
                      'animSpeed': 0.33,
                      'octaves': 6.06,
                      'lacunarity': 2.35,
                      'persistence': 0.5,
                      'noiseScale': 4.5,
                      'colorCount': 3.0,
                      'softness': 1.0,
                      'exposure': 1.0,
                      'contrast': 1.0,
                      'bumpStrength': 0.1,
                      'lightDirX': 0.5,
                      'lightDirY': 0.6,
                      'lightDirZ': 0.9,
                      'lightIntensity': 0.89,
                      'ambient': 0.29,
                      'specular': 0.16,
                      'shininess': 3.06,
                      'metallic': 0.0,
                      'roughness': 0.49,
                      'edgeFade': 0.0,
                      'edgeFadeMode': 1.0
                    }, colors: {
                      'color0': FlutterFlowTheme.of(context).primary,
                      'color1': FlutterFlowTheme.of(context).secondary,
                      'color2': Color(0x00808080),
                      'color3': Color(0x00808080),
                      'color4': Color(0x00808080),
                      'color5': Color(0x00808080),
                      'color6': Color(0x00808080),
                      'color7': Color(0x00808080),
                      'color8': Color(0x00808080),
                      'color9': Color(0x00808080)
                    }),
                    animationMode: ShaderAnimationMode.continuous,
                    cache: false,
                  );
                },
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        widget.title,
                        '20% OFF Vitamins',
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
                        'Boost your immunity today',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: Color(0xE6FFFFFF),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                            lineHeight: 1.5,
                          ),
                    ),
                    wrapWithModel(
                      model: _model.buttonModel,
                      updateCallback: () => safeSetState(() {}),
                      child: Button7Widget(
                        iconPresent: false,
                        iconEndPresent: false,
                        content: valueOrDefault<String>(
                          widget.btnText,
                          'Shop Now',
                        ),
                        variant: 'outline',
                        size: 'small',
                        fullWidth: false,
                        loading: false,
                        disabled: false,
                      ),
                    ),
                  ].divide(SizedBox(height: 8.0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
