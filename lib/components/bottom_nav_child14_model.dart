import '/components/nav_item14_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bottom_nav_child14_widget.dart' show BottomNavChild14Widget;
import 'package:flutter/material.dart';

class BottomNavChild14Model extends FlutterFlowModel<BottomNavChild14Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for NavItem.
  late NavItem14Model navItemModel1;
  // Model for NavItem.
  late NavItem14Model navItemModel2;
  // Model for NavItem.
  late NavItem14Model navItemModel3;
  // Model for NavItem.
  late NavItem14Model navItemModel4;

  @override
  void initState(BuildContext context) {
    navItemModel1 = createModel(context, () => NavItem14Model());
    navItemModel2 = createModel(context, () => NavItem14Model());
    navItemModel3 = createModel(context, () => NavItem14Model());
    navItemModel4 = createModel(context, () => NavItem14Model());
  }

  @override
  void dispose() {
    navItemModel1.dispose();
    navItemModel2.dispose();
    navItemModel3.dispose();
    navItemModel4.dispose();
  }
}
