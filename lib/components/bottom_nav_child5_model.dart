import '/components/nav_item5_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bottom_nav_child5_widget.dart' show BottomNavChild5Widget;
import 'package:flutter/material.dart';

class BottomNavChild5Model extends FlutterFlowModel<BottomNavChild5Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for NavItem.
  late NavItem5Model navItemModel1;
  // Model for NavItem.
  late NavItem5Model navItemModel2;
  // Model for NavItem.
  late NavItem5Model navItemModel3;
  // Model for NavItem.
  late NavItem5Model navItemModel4;

  @override
  void initState(BuildContext context) {
    navItemModel1 = createModel(context, () => NavItem5Model());
    navItemModel2 = createModel(context, () => NavItem5Model());
    navItemModel3 = createModel(context, () => NavItem5Model());
    navItemModel4 = createModel(context, () => NavItem5Model());
  }

  @override
  void dispose() {
    navItemModel1.dispose();
    navItemModel2.dispose();
    navItemModel3.dispose();
    navItemModel4.dispose();
  }
}
