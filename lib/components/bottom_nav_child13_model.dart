import '/components/nav_item13_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bottom_nav_child13_widget.dart' show BottomNavChild13Widget;
import 'package:flutter/material.dart';

class BottomNavChild13Model extends FlutterFlowModel<BottomNavChild13Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for NavItem.
  late NavItem13Model navItemModel1;
  // Model for NavItem.
  late NavItem13Model navItemModel2;
  // Model for NavItem.
  late NavItem13Model navItemModel3;
  // Model for NavItem.
  late NavItem13Model navItemModel4;

  @override
  void initState(BuildContext context) {
    navItemModel1 = createModel(context, () => NavItem13Model());
    navItemModel2 = createModel(context, () => NavItem13Model());
    navItemModel3 = createModel(context, () => NavItem13Model());
    navItemModel4 = createModel(context, () => NavItem13Model());
  }

  @override
  void dispose() {
    navItemModel1.dispose();
    navItemModel2.dispose();
    navItemModel3.dispose();
    navItemModel4.dispose();
  }
}
