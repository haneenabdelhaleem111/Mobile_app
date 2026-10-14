import '/components/nav_item7_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bottom_nav_child7_widget.dart' show BottomNavChild7Widget;
import 'package:flutter/material.dart';

class BottomNavChild7Model extends FlutterFlowModel<BottomNavChild7Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for NavItem.
  late NavItem7Model navItemModel1;
  // Model for NavItem.
  late NavItem7Model navItemModel2;
  // Model for NavItem.
  late NavItem7Model navItemModel3;
  // Model for NavItem.
  late NavItem7Model navItemModel4;

  @override
  void initState(BuildContext context) {
    navItemModel1 = createModel(context, () => NavItem7Model());
    navItemModel2 = createModel(context, () => NavItem7Model());
    navItemModel3 = createModel(context, () => NavItem7Model());
    navItemModel4 = createModel(context, () => NavItem7Model());
  }

  @override
  void dispose() {
    navItemModel1.dispose();
    navItemModel2.dispose();
    navItemModel3.dispose();
    navItemModel4.dispose();
  }
}
