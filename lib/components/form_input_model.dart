import '/components/text_field5_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'form_input_widget.dart' show FormInputWidget;
import 'package:flutter/material.dart';

class FormInputModel extends FlutterFlowModel<FormInputWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for TextField.
  late TextField5Model textFieldModel;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextField5Model());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
  }
}
