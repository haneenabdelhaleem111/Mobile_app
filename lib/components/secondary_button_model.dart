import '/components/button19_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'secondary_button_widget.dart' show SecondaryButtonWidget;
import 'package:flutter/material.dart';

class SecondaryButtonModel extends FlutterFlowModel<SecondaryButtonWidget> {
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
