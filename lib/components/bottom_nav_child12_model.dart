import '/components/nav_item12_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bottom_nav_child12_widget.dart' show BottomNavChild12Widget;
import 'package:flutter/material.dart';

class BottomNavChild12Model extends FlutterFlowModel<BottomNavChild12Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for NavItem.
  late NavItem12Model navItemModel1;
  // Model for NavItem.
  late NavItem12Model navItemModel2;
  // Model for NavItem.
  late NavItem12Model navItemModel3;
  // Model for NavItem.
  late NavItem12Model navItemModel4;
  // Model for NavItem.
  late NavItem12Model navItemModel5;

  @override
  void initState(BuildContext context) {
    navItemModel1 = createModel(context, () => NavItem12Model());
    navItemModel2 = createModel(context, () => NavItem12Model());
    navItemModel3 = createModel(context, () => NavItem12Model());
    navItemModel4 = createModel(context, () => NavItem12Model());
    navItemModel5 = createModel(context, () => NavItem12Model());
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
