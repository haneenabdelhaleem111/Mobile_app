import '/components/button19_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'primary_button3_model.dart';
export 'primary_button3_model.dart';

class PrimaryButton3Widget extends StatefulWidget {
  const PrimaryButton3Widget({
    super.key,
    this.icon,
    String? label,
  }) : label = label ?? 'Track Order';

  final Widget? icon;
  final String label;

  @override
  State<PrimaryButton3Widget> createState() => _PrimaryButton3WidgetState();
}

class _PrimaryButton3WidgetState extends State<PrimaryButton3Widget> {
  late PrimaryButton3Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrimaryButton3Model());
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
      child: Button19Widget(
        icon: widget.icon,
        iconPresent: false,
        iconEndPresent: false,
        content: valueOrDefault<String>(
          widget.label,
          'Track Order',
        ),
        variant: 'outline',
        size: 'large',
        fullWidth: true,
        loading: false,
        disabled: false,
      ),
    );
  }
}
