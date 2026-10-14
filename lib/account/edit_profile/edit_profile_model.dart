import '/components/button18_widget.dart';
import '/components/form_input_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'edit_profile_widget.dart' show EditProfileWidget;
import 'package:flutter/material.dart';

class EditProfileModel extends FlutterFlowModel<EditProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for FormInput.
  late FormInputModel formInputModel1;
  // Model for FormInput.
  late FormInputModel formInputModel2;
  // Model for FormInput.
  late FormInputModel formInputModel3;
  // Model for FormInput.
  late FormInputModel formInputModel4;
  // Model for Button.
  late Button18Model buttonModel1;
  // Model for Button.
  late Button18Model buttonModel2;
  // Model for Button.
  late Button18Model buttonModel3;

  @override
  void initState(BuildContext context) {
    formInputModel1 = createModel(context, () => FormInputModel());
    formInputModel2 = createModel(context, () => FormInputModel());
    formInputModel3 = createModel(context, () => FormInputModel());
    formInputModel4 = createModel(context, () => FormInputModel());
    buttonModel1 = createModel(context, () => Button18Model());
    buttonModel2 = createModel(context, () => Button18Model());
    buttonModel3 = createModel(context, () => Button18Model());
  }

  @override
  void dispose() {
    formInputModel1.dispose();
    formInputModel2.dispose();
    formInputModel3.dispose();
    formInputModel4.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
    buttonModel3.dispose();
  }
}
