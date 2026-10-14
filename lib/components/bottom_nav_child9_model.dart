import '/components/nav_item9_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bottom_nav_child9_widget.dart' show BottomNavChild9Widget;
import 'package:flutter/material.dart';

class BottomNavChild9Model extends FlutterFlowModel<BottomNavChild9Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for NavItem.
  late NavItem9Model navItemModel1;
  // Model for NavItem.
  late NavItem9Model navItemModel2;
  // Model for NavItem.
  late NavItem9Model navItemModel3;
  // Model for NavItem.
  late NavItem9Model navItemModel4;

  @override
  void initState(BuildContext context) {
    navItemModel1 = createModel(context, () => NavItem9Model());
    navItemModel2 = createModel(context, () => NavItem9Model());
    navItemModel3 = createModel(context, () => NavItem9Model());
    navItemModel4 = createModel(context, () => NavItem9Model());
  }

  @override
  void dispose() {
    navItemModel1.dispose();
    navItemModel2.dispose();
    navItemModel3.dispose();
    navItemModel4.dispose();
  }
}
