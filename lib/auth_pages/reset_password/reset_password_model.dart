import '/components/auth_header_widget.dart';
import '/components/button14_widget.dart';
import '/components/button_auth_widget.dart';
import '/components/text_field4_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'reset_password_widget.dart' show ResetPasswordWidget;
import 'package:flutter/material.dart';

class ResetPasswordModel extends FlutterFlowModel<ResetPasswordWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for AuthHeader.
  late AuthHeaderModel authHeaderModel;
  // Model for TextField.
  late TextField4Model textFieldModel;
  // Model for Button_auth component.
  late ButtonAuthModel buttonAuthModel;
  // Model for Button.
  late Button14Model buttonModel;

  @override
  void initState(BuildContext context) {
    authHeaderModel = createModel(context, () => AuthHeaderModel());
    textFieldModel = createModel(context, () => TextField4Model());
    buttonAuthModel = createModel(context, () => ButtonAuthModel());
    buttonModel = createModel(context, () => Button14Model());
  }

  @override
  void dispose() {
    authHeaderModel.dispose();
    textFieldModel.dispose();
    buttonAuthModel.dispose();
    buttonModel.dispose();
  }
}
