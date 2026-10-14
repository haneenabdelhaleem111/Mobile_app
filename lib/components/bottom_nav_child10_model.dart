import '/components/nav_item10_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bottom_nav_child10_widget.dart' show BottomNavChild10Widget;
import 'package:flutter/material.dart';

class BottomNavChild10Model extends FlutterFlowModel<BottomNavChild10Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for NavItem.
  late NavItem10Model navItemModel1;
  // Model for NavItem.
  late NavItem10Model navItemModel2;
  // Model for NavItem.
  late NavItem10Model navItemModel3;
  // Model for NavItem.
  late NavItem10Model navItemModel4;

  @override
  void initState(BuildContext context) {
    navItemModel1 = createModel(context, () => NavItem10Model());
    navItemModel2 = createModel(context, () => NavItem10Model());
    navItemModel3 = createModel(context, () => NavItem10Model());
    navItemModel4 = createModel(context, () => NavItem10Model());
  }

  @override
  void dispose() {
    navItemModel1.dispose();
    navItemModel2.dispose();
    navItemModel3.dispose();
    navItemModel4.dispose();
  }
}
