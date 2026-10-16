import '/components/text_field5_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'form_input_model.dart';
export 'form_input_model.dart';

class FormInputWidget extends StatefulWidget {
  const FormInputWidget({
    super.key,
    String? hint,
    String? icon,
    String? label,
    String? type,
    String? value,
  })  : hint = hint ?? 'Enter your full name',
        icon = icon ?? 'person_outline_rounded',
        label = label ?? 'Full Name',
        type = type ?? 'text',
        value = value ?? 'Ahmed Al-Mansouri';

  final String hint;
  final String icon;
  final String label;
  final String type;
  final String value;

  @override
  State<FormInputWidget> createState() => _FormInputWidgetState();
}

class _FormInputWidgetState extends State<FormInputWidget> {
  late FormInputModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FormInputModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          valueOrDefault<String>(
            widget.label,
            'Full Name',
          ),
          style: FlutterFlowTheme.of(context).labelMedium.override(
                font: GoogleFonts.inter(
                  fontWeight:
                      FlutterFlowTheme.of(context).labelMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).primaryText,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                lineHeight: 1.3,
              ),
        ),
        wrapWithModel(
          model: _model.textFieldModel,
          updateCallback: () => safeSetState(() {}),
          child: TextField5Widget(
            label: '',
            labelPresent: false,
            helper: '',
            helperPresent: false,
            leadingIconPresent: false,
            trailingIconPresent: false,
            hint: valueOrDefault<String>(
              widget.hint,
              'Enter your full name',
            ),
            value: valueOrDefault<String>(
              widget.value,
              'Ahmed Al-Mansouri',
            ),
            onChange: '',
            onSubmit: '',
            variant: 'filled',
            error: false,
          ),
        ),
      ].divide(const SizedBox(height: 4.0)),
    );
  }
}
