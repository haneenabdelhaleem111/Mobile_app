import '/components/button22_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'primary_button4_model.dart';
export 'primary_button4_model.dart';

class PrimaryButton4Widget extends StatefulWidget {
  const PrimaryButton4Widget({
    super.key,
    String? content,
    this.icon,
    bool? loading,
  })  : content = content ?? 'Add to Cart',
        loading = loading ?? false;

  final String content;
  final Widget? icon;
  final bool loading;

  @override
  State<PrimaryButton4Widget> createState() => _PrimaryButton4WidgetState();
}

class _PrimaryButton4WidgetState extends State<PrimaryButton4Widget> {
  late PrimaryButton4Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrimaryButton4Model());
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
          widget.content,
          'Add to Cart',
        ),
        variant: 'primary',
        size: 'large',
        fullWidth: false,
        loading: valueOrDefault<bool>(
          widget.loading,
          false,
        ),
        disabled: false,
      ),
    );
  }
}
