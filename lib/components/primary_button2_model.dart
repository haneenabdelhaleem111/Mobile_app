import '/components/button12_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'primary_button2_widget.dart' show PrimaryButton2Widget;
import 'package:flutter/material.dart';

class PrimaryButton2Model extends FlutterFlowModel<PrimaryButton2Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button12Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button12Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
