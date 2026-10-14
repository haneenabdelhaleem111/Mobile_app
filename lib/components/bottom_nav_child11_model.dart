import '/components/nav_item11_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bottom_nav_child11_widget.dart' show BottomNavChild11Widget;
import 'package:flutter/material.dart';

class BottomNavChild11Model extends FlutterFlowModel<BottomNavChild11Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for NavItem.
  late NavItem11Model navItemModel1;
  // Model for NavItem.
  late NavItem11Model navItemModel2;
  // Model for NavItem.
  late NavItem11Model navItemModel3;
  // Model for NavItem.
  late NavItem11Model navItemModel4;
  // Model for NavItem.
  late NavItem11Model navItemModel5;

  @override
  void initState(BuildContext context) {
    navItemModel1 = createModel(context, () => NavItem11Model());
    navItemModel2 = createModel(context, () => NavItem11Model());
    navItemModel3 = createModel(context, () => NavItem11Model());
    navItemModel4 = createModel(context, () => NavItem11Model());
    navItemModel5 = createModel(context, () => NavItem11Model());
  }

  @override
  void dispose() {
    navItemModel1.dispose();
    navItemModel2.dispose();
    navItemModel3.dispose();
    navItemModel4.dispose();
    navItemModel5.dispose();
  }
}
