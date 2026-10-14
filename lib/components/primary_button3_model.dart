import '/components/button19_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'primary_button3_widget.dart' show PrimaryButton3Widget;
import 'package:flutter/material.dart';

class PrimaryButton3Model extends FlutterFlowModel<PrimaryButton3Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button19Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button19Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
