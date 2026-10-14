import '/components/button12_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'primary_button2_model.dart';
export 'primary_button2_model.dart';

class PrimaryButton2Widget extends StatefulWidget {
  const PrimaryButton2Widget({
    super.key,
    this.icon,
    String? label,
  }) : this.label = label ?? 'Buy Now';

  final Widget? icon;
  final String label;

  @override
  State<PrimaryButton2Widget> createState() => _PrimaryButton2WidgetState();
}

class _PrimaryButton2WidgetState extends State<PrimaryButton2Widget> {
  late PrimaryButton2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrimaryButton2Model());
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
      child: Button12Widget(
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
