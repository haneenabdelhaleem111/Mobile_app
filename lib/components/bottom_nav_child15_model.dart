import '/components/nav_item15_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bottom_nav_child15_widget.dart' show BottomNavChild15Widget;
import 'package:flutter/material.dart';

class BottomNavChild15Model extends FlutterFlowModel<BottomNavChild15Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for NavItem.
  late NavItem15Model navItemModel1;
  // Model for NavItem.
  late NavItem15Model navItemModel2;
  // Model for NavItem.
  late NavItem15Model navItemModel3;
  // Model for NavItem.
  late NavItem15Model navItemModel4;

  @override
  void initState(BuildContext context) {
    navItemModel1 = createModel(context, () => NavItem15Model());
    navItemModel2 = createModel(context, () => NavItem15Model());
    navItemModel3 = createModel(context, () => NavItem15Model());
    navItemModel4 = createModel(context, () => NavItem15Model());
  }

  @override
  void dispose() {
    navItemModel1.dispose();
    navItemModel2.dispose();
    navItemModel3.dispose();
    navItemModel4.dispose();
  }
}
