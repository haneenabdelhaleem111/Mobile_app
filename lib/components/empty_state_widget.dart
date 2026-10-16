import '/components/button_auth_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'empty_state_model.dart';
export 'empty_state_model.dart';

class EmptyStateWidget extends StatefulWidget {
  const EmptyStateWidget({
    super.key,
    String? type,
  }) : type = type ?? 'empty_cart';

  final String type;

  @override
  State<EmptyStateWidget> createState() => _EmptyStateWidgetState();
}

class _EmptyStateWidgetState extends State<EmptyStateWidget> {
  late EmptyStateModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyStateModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Container(
          child: Container(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    color: const Color(0x1A0056B3),
                    borderRadius: BorderRadius.circular(9999.0),
                    shape: BoxShape.rectangle,
                  ),
                  alignment: const AlignmentDirectional(0.0, 0.0),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        () {
                          if (valueOrDefault<String>(
                                widget.type,
                                'empty_cart',
                              ) ==
                              'empty_wishlist') {
                            return 'Wishlist is empty';
                          } else if (valueOrDefault<String>(
                                widget.type,
                                'empty_cart',
                              ) ==
                              'no_internet') {
                            return 'No connection';
                          } else if (valueOrDefault<String>(
                                widget.type,
                                'empty_cart',
                              ) ==
                              'no_orders') {
                            return 'No orders yet';
                          } else if (valueOrDefault<String>(
                                widget.type,
                                'empty_cart',
                              ) ==
                              'server_error') {
                            return 'Server error';
                          } else {
                            return 'Your cart is empty';
                          }
                        }(),
                        'Your cart is empty',
                      ),
                      textAlign: TextAlign.center,
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
                                color: FlutterFlowTheme.of(context).primaryText,
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
                        () {
                          if (valueOrDefault<String>(
                                widget.type,
                                'empty_cart',
                              ) ==
                              'empty_wishlist') {
                            return 'Save your favorite products here to find them easily later.';
                          } else if (valueOrDefault<String>(
                                widget.type,
                                'empty_cart',
                              ) ==
                              'no_internet') {
                            return 'Please check your internet connection and try again.';
                          } else if (valueOrDefault<String>(
                                widget.type,
                                'empty_cart',
                              ) ==
                              'no_orders') {
                            return 'When you place an order, it will appear here for tracking.';
                          } else if (valueOrDefault<String>(
                                widget.type,
                                'empty_cart',
                              ) ==
                              'server_error') {
                            return 'We\'re having trouble reaching our pharmacy. Please try again later.';
                          } else {
                            return 'Looks like you haven\'t added any medicines or healthcare products yet.';
                          }
                        }(),
                        'Looks like you haven\'t added any medicines or healthcare products yet.',
                      ),
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).secondaryText,
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
                  ].divide(const SizedBox(height: 8.0)),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 0.0, 16.0, 0.0),
                  child: Container(
                    child: Container(),
                  ),
                ),
                wrapWithModel(
                  model: _model.buttonAuthModel,
                  updateCallback: () => safeSetState(() {}),
                  child: const ButtonAuthWidget(
                    iconPresent: false,
                    iconEndPresent: false,
                    content: 'Start Shopping',
                    fullWidth: false,
                    loading: false,
                    disabled: false,
                  ),
                ),
              ].divide(const SizedBox(height: 24.0)),
            ),
          ),
        ),
      ),
    );
  }
}
