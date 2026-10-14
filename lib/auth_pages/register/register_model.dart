import '/components/button13_widget.dart';
import '/components/button_auth_widget.dart';
import '/components/text_field3_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'register_widget.dart' show RegisterWidget;
import 'package:flutter/material.dart';

class RegisterModel extends FlutterFlowModel<RegisterWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextField3Model textFieldModel1;
  // Model for TextField.
  late TextField3Model textFieldModel2;
  // Model for TextField.
  late TextField3Model textFieldModel3;
  // Model for TextField.
  late TextField3Model textFieldModel4;
  // Model for Button_auth component.
  late ButtonAuthModel buttonAuthModel;
  // Model for Button.
  late Button13Model buttonModel;

  @override
  void initState(BuildContext context) {
    textFieldModel1 = createModel(context, () => TextField3Model());
    textFieldModel2 = createModel(context, () => TextField3Model());
    textFieldModel3 = createModel(context, () => TextField3Model());
    textFieldModel4 = createModel(context, () => TextField3Model());
    buttonAuthModel = createModel(context, () => ButtonAuthModel());
    buttonModel = createModel(context, () => Button13Model());
  }

  @override
  void dispose() {
    textFieldModel1.dispose();
    textFieldModel2.dispose();
    textFieldModel3.dispose();
    textFieldModel4.dispose();
    buttonAuthModel.dispose();
    buttonModel.dispose();
  }
}
