import '/components/button25_widget.dart';
import '/components/policy_section_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'terms_conditions_widget.dart' show TermsConditionsWidget;
import 'package:flutter/material.dart';

class TermsConditionsModel extends FlutterFlowModel<TermsConditionsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PolicySection.
  late PolicySectionModel policySectionModel1;
  // Model for PolicySection.
  late PolicySectionModel policySectionModel2;
  // Model for PolicySection.
  late PolicySectionModel policySectionModel3;
  // Model for PolicySection.
  late PolicySectionModel policySectionModel4;
  // Model for Button.
  late Button25Model buttonModel;

  @override
  void initState(BuildContext context) {
    policySectionModel1 = createModel(context, () => PolicySectionModel());
    policySectionModel2 = createModel(context, () => PolicySectionModel());
    policySectionModel3 = createModel(context, () => PolicySectionModel());
    policySectionModel4 = createModel(context, () => PolicySectionModel());
    buttonModel = createModel(context, () => Button25Model());
  }

  @override
  void dispose() {
    policySectionModel1.dispose();
    policySectionModel2.dispose();
    policySectionModel3.dispose();
    policySectionModel4.dispose();
    buttonModel.dispose();
  }
}
