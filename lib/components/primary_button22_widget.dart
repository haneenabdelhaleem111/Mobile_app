import '/components/button22_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'primary_button22_model.dart';
export 'primary_button22_model.dart';

class PrimaryButton22Widget extends StatefulWidget {
  const PrimaryButton22Widget({
    super.key,
    this.icon,
    String? label,
  }) : label = label ?? 'Buy Now';

  final Widget? icon;
  final String label;

  @override
  State<PrimaryButton22Widget> createState() => _PrimaryButton22WidgetState();
}

class _PrimaryButton22WidgetState extends State<PrimaryButton22Widget> {
  late PrimaryButton22Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrimaryButton22Model());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return wrapWithModel(
      model: _model.buttonModel,
      updateCallback: () => safeSetState(() {}),
      child: Button22Widget(
        icon: widget.icon,
        iconPresent: false,
        iconEndPresent: false,
        content: valueOrDefault<String>(
          widget.label,
          'Buy Now',
        ),
        variant: 'primary',
        size: 'large',
        fullWidth: true,
        loading: false,
        disabled: false,
      ),
    );
  }
}
