import '/components/primary_button3_widget.dart';
import '/components/product_mini_card_widget.dart';
import '/components/secondary_button_widget.dart';
import '/components/success_header_widget.dart';
import '/components/summary_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'order_success_widget.dart' show OrderSuccessWidget;
import 'package:flutter/material.dart';

class OrderSuccessModel extends FlutterFlowModel<OrderSuccessWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for SuccessHeader.
  late SuccessHeaderModel successHeaderModel;
  // Model for ProductMiniCard.
  late ProductMiniCardModel productMiniCardModel1;
  // Model for ProductMiniCard.
  late ProductMiniCardModel productMiniCardModel2;
  // Model for SummaryItem.
  late SummaryItemModel summaryItemModel1;
  // Model for SummaryItem.
  late SummaryItemModel summaryItemModel2;
  // Model for SummaryItem.
  late SummaryItemModel summaryItemModel3;
  // Model for PrimaryButton.
  late PrimaryButton3Model primaryButtonModel;
  // Model for SecondaryButton.
  late SecondaryButtonModel secondaryButtonModel;

  @override
  void initState(BuildContext context) {
    successHeaderModel = createModel(context, () => SuccessHeaderModel());
    productMiniCardModel1 = createModel(context, () => ProductMiniCardModel());
    productMiniCardModel2 = createModel(context, () => ProductMiniCardModel());
    summaryItemModel1 = createModel(context, () => SummaryItemModel());
    summaryItemModel2 = createModel(context, () => SummaryItemModel());
    summaryItemModel3 = createModel(context, () => SummaryItemModel());
    primaryButtonModel = createModel(context, () => PrimaryButton3Model());
    secondaryButtonModel = createModel(context, () => SecondaryButtonModel());
  }

  @override
  void dispose() {
    successHeaderModel.dispose();
    productMiniCardModel1.dispose();
    productMiniCardModel2.dispose();
    summaryItemModel1.dispose();
    summaryItemModel2.dispose();
    summaryItemModel3.dispose();
    primaryButtonModel.dispose();
    secondaryButtonModel.dispose();
  }
}
