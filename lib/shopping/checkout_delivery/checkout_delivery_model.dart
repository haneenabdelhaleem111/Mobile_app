import '/components/address_card_widget.dart';
import '/components/button11_widget.dart';
import '/components/checkout_step_widget.dart';
import '/components/payment_option_widget.dart';
import '/components/summary_row2_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'checkout_delivery_widget.dart' show CheckoutDeliveryWidget;
import 'package:flutter/material.dart';

class CheckoutDeliveryModel extends FlutterFlowModel<CheckoutDeliveryWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for CheckoutStep.
  late CheckoutStepModel checkoutStepModel1;
  // Model for CheckoutStep.
  late CheckoutStepModel checkoutStepModel2;
  // Model for CheckoutStep.
  late CheckoutStepModel checkoutStepModel3;
  // Model for Button.
  late Button11Model buttonModel1;
  // Model for AddressCard.
  late AddressCardModel addressCardModel;
  // Model for PaymentOption.
  late PaymentOptionModel paymentOptionModel;
  // Model for SummaryRow.
  late SummaryRow2Model summaryRowModel1;
  // Model for SummaryRow.
  late SummaryRow2Model summaryRowModel2;
  // Model for SummaryRow.
  late SummaryRow2Model summaryRowModel3;
  // Model for SummaryRow.
  late SummaryRow2Model summaryRowModel4;
  // Model for Button.
  late Button11Model buttonModel2;

  @override
  void initState(BuildContext context) {
    checkoutStepModel1 = createModel(context, () => CheckoutStepModel());
    checkoutStepModel2 = createModel(context, () => CheckoutStepModel());
    checkoutStepModel3 = createModel(context, () => CheckoutStepModel());
    buttonModel1 = createModel(context, () => Button11Model());
    addressCardModel = createModel(context, () => AddressCardModel());
    paymentOptionModel = createModel(context, () => PaymentOptionModel());
    summaryRowModel1 = createModel(context, () => SummaryRow2Model());
    summaryRowModel2 = createModel(context, () => SummaryRow2Model());
    summaryRowModel3 = createModel(context, () => SummaryRow2Model());
    summaryRowModel4 = createModel(context, () => SummaryRow2Model());
    buttonModel2 = createModel(context, () => Button11Model());
  }

  @override
  void dispose() {
    checkoutStepModel1.dispose();
    checkoutStepModel2.dispose();
    checkoutStepModel3.dispose();
    buttonModel1.dispose();
    addressCardModel.dispose();
    paymentOptionModel.dispose();
    summaryRowModel1.dispose();
    summaryRowModel2.dispose();
    summaryRowModel3.dispose();
    summaryRowModel4.dispose();
    buttonModel2.dispose();
  }
}
