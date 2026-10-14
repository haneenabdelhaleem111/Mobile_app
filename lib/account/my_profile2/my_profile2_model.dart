import '/components/button17_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'my_profile2_widget.dart' show MyProfile2Widget;
import 'package:flutter/material.dart';

class MyProfile2Model extends FlutterFlowModel<MyProfile2Widget> {
  ///  State fields for stateful widgets in this page.

  // Model for Button.
  late Button17Model buttonModel1;
  // Model for Button.
  late Button17Model buttonModel2;

  @override
  void initState(BuildContext context) {
    buttonModel1 = createModel(context, () => Button17Model());
    buttonModel2 = createModel(context, () => Button17Model());
  }

  @override
  void dispose() {
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
