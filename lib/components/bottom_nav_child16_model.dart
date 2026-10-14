import '/components/nav_item16_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bottom_nav_child16_widget.dart' show BottomNavChild16Widget;
import 'package:flutter/material.dart';

class BottomNavChild16Model extends FlutterFlowModel<BottomNavChild16Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for NavItem.
  late NavItem16Model navItemModel1;
  // Model for NavItem.
  late NavItem16Model navItemModel2;
  // Model for NavItem.
  late NavItem16Model navItemModel3;
  // Model for NavItem.
  late NavItem16Model navItemModel4;

  @override
  void initState(BuildContext context) {
    navItemModel1 = createModel(context, () => NavItem16Model());
    navItemModel2 = createModel(context, () => NavItem16Model());
    navItemModel3 = createModel(context, () => NavItem16Model());
    navItemModel4 = createModel(context, () => NavItem16Model());
  }

  @override
  void dispose() {
    navItemModel1.dispose();
    navItemModel2.dispose();
    navItemModel3.dispose();
    navItemModel4.dispose();
  }
}
