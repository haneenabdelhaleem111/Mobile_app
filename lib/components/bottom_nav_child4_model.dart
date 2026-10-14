import '/components/nav_item4_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bottom_nav_child4_widget.dart' show BottomNavChild4Widget;
import 'package:flutter/material.dart';

class BottomNavChild4Model extends FlutterFlowModel<BottomNavChild4Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for NavItem.
  late NavItem4Model navItemModel1;
  // Model for NavItem.
  late NavItem4Model navItemModel2;
  // Model for NavItem.
  late NavItem4Model navItemModel3;
  // Model for NavItem.
  late NavItem4Model navItemModel4;

  @override
  void initState(BuildContext context) {
    navItemModel1 = createModel(context, () => NavItem4Model());
    navItemModel2 = createModel(context, () => NavItem4Model());
    navItemModel3 = createModel(context, () => NavItem4Model());
    navItemModel4 = createModel(context, () => NavItem4Model());
  }

  @override
  void dispose() {
    navItemModel1.dispose();
    navItemModel2.dispose();
    navItemModel3.dispose();
    navItemModel4.dispose();
  }
}
