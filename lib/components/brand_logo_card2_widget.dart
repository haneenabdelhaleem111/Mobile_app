import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'brand_logo_card2_model.dart';
export 'brand_logo_card2_model.dart';

class BrandLogoCard2Widget extends StatefulWidget {
  const BrandLogoCard2Widget({
    super.key,
    String? name,
    String? slug,
  })  : this.name = name ?? 'La Roche-Posay',
        this.slug = slug ?? 'https://cdn.simpleicons.org/vichy/0056b3.svg';

  final String name;
  final String slug;

  @override
  State<BrandLogoCard2Widget> createState() => _BrandLogoCard2WidgetState();
}

class _BrandLogoCard2WidgetState extends State<BrandLogoCard2Widget> {
  late BrandLogoCard2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BrandLogoCard2Model());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 80.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.network(
            valueOrDefault<String>(
              widget.slug,
              'https://cdn.simpleicons.org/vichy/0056b3.svg',
            ),
            width: 32.0,
            height: 32.0,
            fit: BoxFit.contain,
          ),
          Text(
            valueOrDefault<String>(
              widget.name,
              'La Roche-Posay',
            ),
            style: FlutterFlowTheme.of(context).labelSmall.override(
                  font: GoogleFonts.inter(
                    fontWeight:
                        FlutterFlowTheme.of(context).labelSmall.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelSmall.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).secondaryText,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).labelSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                  lineHeight: 1.2,
                ),
          ),
        ].divide(SizedBox(height: 4.0)),
      ),
    );
  }
}
