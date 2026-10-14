import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'emshaty_category2_model.dart';
export 'emshaty_category2_model.dart';

class EmshatyCategory2Widget extends StatefulWidget {
  const EmshatyCategory2Widget({
    super.key,
    this.icon,
    Color? tint,
    String? title,
  })  : this.tint = tint ?? const Color(0x00000000),
        this.title = title ?? 'Medicines';

  final Widget? icon;
  final Color tint;
  final String title;

  @override
  State<EmshatyCategory2Widget> createState() => _EmshatyCategory2WidgetState();
}

class _EmshatyCategory2WidgetState extends State<EmshatyCategory2Widget> {
  late EmshatyCategory2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmshatyCategory2Model());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 64.0,
            height: 64.0,
            decoration: BoxDecoration(
              color: valueOrDefault<Color>(
                widget.tint,
                FlutterFlowTheme.of(context).primary,
              ),
              borderRadius: BorderRadius.circular(24.0),
              shape: BoxShape.rectangle,
            ),
            child: widget.icon!,
          ),
          Text(
            valueOrDefault<String>(
              widget.title,
              'Medicines',
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            style: FlutterFlowTheme.of(context).labelMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight:
                        FlutterFlowTheme.of(context).labelMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).labelMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                  lineHeight: 1.3,
                ),
          ),
        ].divide(SizedBox(height: 8.0)),
      ),
    );
  }
}
