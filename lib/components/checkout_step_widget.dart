import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'checkout_step_model.dart';
export 'checkout_step_model.dart';

class CheckoutStepWidget extends StatefulWidget {
  const CheckoutStepWidget({
    super.key,
    bool? done,
    String? title,
    bool? active,
  })  : done = done ?? false,
        title = title ?? 'Address',
        active = active ?? true;

  final bool done;
  final String title;
  final bool active;

  @override
  State<CheckoutStepWidget> createState() => _CheckoutStepWidgetState();
}

class _CheckoutStepWidgetState extends State<CheckoutStepWidget> {
  late CheckoutStepModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckoutStepModel());
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 28.0,
          height: 28.0,
          decoration: BoxDecoration(
            color: valueOrDefault<Color>(
              () {
                if (valueOrDefault<bool>(
                  widget.done,
                  false,
                )) {
                  return FlutterFlowTheme.of(context).success;
                } else if (valueOrDefault<bool>(
                  widget.active,
                  true,
                )) {
                  return FlutterFlowTheme.of(context).primary;
                } else {
                  return FlutterFlowTheme.of(context).secondaryBackground;
                }
              }(),
              FlutterFlowTheme.of(context).success,
            ),
            borderRadius: BorderRadius.circular(9999.0),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: valueOrDefault<Color>(
                valueOrDefault<bool>(
                  widget.active,
                  true,
                )
                    ? FlutterFlowTheme.of(context).primary
                    : FlutterFlowTheme.of(context).alternate,
                FlutterFlowTheme.of(context).primary,
              ),
              width: 1.0,
            ),
          ),
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (valueOrDefault<bool>(
                valueOrDefault<bool>(
                  widget.done,
                  false,
                )
                    ? true
                    : false,
                true,
              ))
                SizedBox(
                  width: 16.0,
                  height: 16.0,
                  child: Stack(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    children: [
                      if (valueOrDefault<bool>(
                        valueOrDefault<bool>(
                          widget.done,
                          false,
                        )
                            ? true
                            : false,
                        true,
                      ))
                        const Icon(
                          Icons.check_rounded,
                          size: 16.0,
                        ),
                      if (valueOrDefault<bool>(
                        valueOrDefault<bool>(
                          widget.done,
                          false,
                        )
                            ? false
                            : true,
                        false,
                      ))
                        const Icon(
                          Icons.edit_location_rounded,
                          size: 16.0,
                        ),
                    ],
                  ),
                ),
              if (valueOrDefault<bool>(
                valueOrDefault<bool>(
                  widget.done,
                  false,
                )
                    ? false
                    : true,
                false,
              ))
                Text(
                  '1',
                  style: FlutterFlowTheme.of(context).labelSmall.override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).labelSmall.fontStyle,
                        ),
                        color: valueOrDefault<Color>(
                          valueOrDefault<bool>(
                            widget.active,
                            true,
                          )
                              ? Colors.white
                              : FlutterFlowTheme.of(context).secondaryText,
                          Colors.white,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).labelSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelSmall.fontStyle,
                        lineHeight: 1.2,
                      ),
                ),
            ],
          ),
        ),
        Text(
          valueOrDefault<String>(
            widget.title,
            'Address',
          ),
          style: FlutterFlowTheme.of(context).labelSmall.override(
                font: GoogleFonts.inter(
                  fontWeight:
                      FlutterFlowTheme.of(context).labelSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                ),
                color: valueOrDefault<Color>(
                  valueOrDefault<bool>(
                    widget.active,
                    true,
                  )
                      ? FlutterFlowTheme.of(context).primary
                      : FlutterFlowTheme.of(context).secondaryText,
                  FlutterFlowTheme.of(context).primary,
                ),
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                lineHeight: 1.2,
              ),
        ),
      ].divide(const SizedBox(height: 4.0)),
    );
  }
}
