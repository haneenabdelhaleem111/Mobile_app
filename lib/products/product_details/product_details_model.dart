import '/components/product_card12_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'product_details_widget.dart' show ProductDetailsWidget;
import 'package:flutter/material.dart';

class ProductDetailsModel extends FlutterFlowModel<ProductDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ProductCard.
  late ProductCard12Model productCardModel1;
  // Model for ProductCard.
  late ProductCard12Model productCardModel2;
  // Model for ProductCard.
  late ProductCard12Model productCardModel3;

  @override
  void initState(BuildContext context) {
    productCardModel1 = createModel(context, () => ProductCard12Model());
    productCardModel2 = createModel(context, () => ProductCard12Model());
    productCardModel3 = createModel(context, () => ProductCard12Model());
  }

  @override
  void dispose() {
    productCardModel1.dispose();
    productCardModel2.dispose();
    productCardModel3.dispose();
  }
}
