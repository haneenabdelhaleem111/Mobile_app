import '/components/button22_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'primary_button4_widget.dart' show PrimaryButton4Widget;
import 'package:flutter/material.dart';

class PrimaryButton4Model extends FlutterFlowModel<PrimaryButton4Widget> {
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
