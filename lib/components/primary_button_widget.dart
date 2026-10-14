import '/components/button12_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'primary_button_model.dart';
export 'primary_button_model.dart';

class PrimaryButtonWidget extends StatefulWidget {
  const PrimaryButtonWidget({
    super.key,
    String? content,
    this.icon,
    bool? loading,
  })  : this.content = content ?? 'Add to Cart',
        this.loading = loading ?? false;

  final String content;
  final Widget? icon;
  final bool loading;

  @override
  State<PrimaryButtonWidget> createState() => _PrimaryButtonWidgetState();
}

class _PrimaryButtonWidgetState extends State<PrimaryButtonWidget> {
  late PrimaryButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrimaryButtonModel());
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
          widget.content,
          'Add to Cart',
        ),
        variant: 'primary',
        size: 'large',
        fullWidth: true,
        loading: valueOrDefault<bool>(
          widget.loading,
          false,
        ),
        disabled: false,
      ),
    );
  }
}
