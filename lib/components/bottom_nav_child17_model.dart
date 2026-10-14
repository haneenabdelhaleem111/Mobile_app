import '/components/nav_item17_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bottom_nav_child17_widget.dart' show BottomNavChild17Widget;
import 'package:flutter/material.dart';

class BottomNavChild17Model extends FlutterFlowModel<BottomNavChild17Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for NavItem.
  late NavItem17Model navItemModel1;
  // Model for NavItem.
  late NavItem17Model navItemModel2;
  // Model for NavItem.
  late NavItem17Model navItemModel3;
  // Model for NavItem.
  late NavItem17Model navItemModel4;

  @override
  void initState(BuildContext context) {
    navItemModel1 = createModel(context, () => NavItem17Model());
    navItemModel2 = createModel(context, () => NavItem17Model());
    navItemModel3 = createModel(context, () => NavItem17Model());
    navItemModel4 = createModel(context, () => NavItem17Model());
  }

  @override
  void dispose() {
    navItemModel1.dispose();
    navItemModel2.dispose();
    navItemModel3.dispose();
    navItemModel4.dispose();
  }
}
