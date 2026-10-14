import '/components/account_menu_item_widget.dart';
import '/components/button16_widget.dart';
import '/components/quick_stat_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'account_dashboard_widget.dart' show AccountDashboardWidget;
import 'package:flutter/material.dart';

class AccountDashboardModel extends FlutterFlowModel<AccountDashboardWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for QuickStat.
  late QuickStatModel quickStatModel1;
  // Model for QuickStat.
  late QuickStatModel quickStatModel2;
  // Model for AccountMenuItem.
  late AccountMenuItemModel accountMenuItemModel1;
  // Model for AccountMenuItem.
  late AccountMenuItemModel accountMenuItemModel2;
  // Model for AccountMenuItem.
  late AccountMenuItemModel accountMenuItemModel3;
  // Model for AccountMenuItem.
  late AccountMenuItemModel accountMenuItemModel4;
  // Model for AccountMenuItem.
  late AccountMenuItemModel accountMenuItemModel5;
  // Model for AccountMenuItem.
  late AccountMenuItemModel accountMenuItemModel6;
  // Model for Button.
  late Button16Model buttonModel;

  @override
  void initState(BuildContext context) {
    quickStatModel1 = createModel(context, () => QuickStatModel());
    quickStatModel2 = createModel(context, () => QuickStatModel());
    accountMenuItemModel1 = createModel(context, () => AccountMenuItemModel());
    accountMenuItemModel2 = createModel(context, () => AccountMenuItemModel());
    accountMenuItemModel3 = createModel(context, () => AccountMenuItemModel());
    accountMenuItemModel4 = createModel(context, () => AccountMenuItemModel());
    accountMenuItemModel5 = createModel(context, () => AccountMenuItemModel());
    accountMenuItemModel6 = createModel(context, () => AccountMenuItemModel());
    buttonModel = createModel(context, () => Button16Model());
  }

  @override
  void dispose() {
    quickStatModel1.dispose();
    quickStatModel2.dispose();
    accountMenuItemModel1.dispose();
    accountMenuItemModel2.dispose();
    accountMenuItemModel3.dispose();
    accountMenuItemModel4.dispose();
    accountMenuItemModel5.dispose();
    accountMenuItemModel6.dispose();
    buttonModel.dispose();
  }
}
