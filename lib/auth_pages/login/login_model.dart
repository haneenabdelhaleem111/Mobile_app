import '/components/button_auth_widget.dart';
import '/components/button_fp_widget.dart';
import '/components/text_field2_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'login_widget.dart' show LoginWidget;
import 'package:flutter/material.dart';

class LoginModel extends FlutterFlowModel<LoginWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextField2Model textFieldModel1;
  // Model for TextField.
  late TextField2Model textFieldModel2;
  // Model for Button_auth component.
  late ButtonAuthModel buttonAuthModel;
  // Model for Button.
  late ButtonFpModel buttonModel1;
  // Model for Button.
  late ButtonFpModel buttonModel2;

  @override
  void initState(BuildContext context) {
    textFieldModel1 = createModel(context, () => TextField2Model());
    textFieldModel2 = createModel(context, () => TextField2Model());
    buttonAuthModel = createModel(context, () => ButtonAuthModel());
    buttonModel1 = createModel(context, () => ButtonFpModel());
    buttonModel2 = createModel(context, () => ButtonFpModel());
  }

  @override
  void dispose() {
    textFieldModel1.dispose();
    textFieldModel2.dispose();
    buttonAuthModel.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
