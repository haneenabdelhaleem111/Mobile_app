import '/components/product_card13_widget.dart';
import '/components/text_field8_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'deals_widget.dart' show DealsWidget;
import 'package:flutter/material.dart';

class DealsModel extends FlutterFlowModel<DealsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextField8Model textFieldModel;
  // Model for ProductCard.
  late ProductCard13Model productCardModel1;
  // Model for ProductCard.
  late ProductCard13Model productCardModel2;
  // Model for ProductCard.
  late ProductCard13Model productCardModel3;
  // Model for ProductCard.
  late ProductCard13Model productCardModel4;
  // Model for ProductCard.
  late ProductCard13Model productCardModel5;
  // Model for ProductCard.
  late ProductCard13Model productCardModel6;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextField8Model());
    productCardModel1 = createModel(context, () => ProductCard13Model());
    productCardModel2 = createModel(context, () => ProductCard13Model());
    productCardModel3 = createModel(context, () => ProductCard13Model());
    productCardModel4 = createModel(context, () => ProductCard13Model());
    productCardModel5 = createModel(context, () => ProductCard13Model());
    productCardModel6 = createModel(context, () => ProductCard13Model());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
    productCardModel1.dispose();
    productCardModel2.dispose();
    productCardModel3.dispose();
    productCardModel4.dispose();
    productCardModel5.dispose();
    productCardModel6.dispose();
  }
}
