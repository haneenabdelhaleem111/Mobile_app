import '/components/button22_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'primary_button22_widget.dart' show PrimaryButton22Widget;
import 'package:flutter/material.dart';

class PrimaryButton22Model extends FlutterFlowModel<PrimaryButton22Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button22Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button22Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
