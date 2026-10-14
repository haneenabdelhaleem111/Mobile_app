import '/components/button19_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'secondary_button_model.dart';
export 'secondary_button_model.dart';

class SecondaryButtonWidget extends StatefulWidget {
  const SecondaryButtonWidget({
    super.key,
    String? label,
    String? icon,
  })  : this.label = label ?? 'Back to Shopping',
        this.icon = icon ?? 'shopping_bag_outlined';

  final String label;
  final String icon;

  @override
  State<SecondaryButtonWidget> createState() => _SecondaryButtonWidgetState();
}

class _SecondaryButtonWidgetState extends State<SecondaryButtonWidget> {
  late SecondaryButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SecondaryButtonModel());
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
        iconPresent: false,
        iconEndPresent: false,
        content: valueOrDefault<String>(
          widget.label,
          'Back to Shopping',
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
