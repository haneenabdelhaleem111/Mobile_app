import '/components/filter_chip_widget.dart';
import '/components/product_card7_widget.dart';
import '/components/text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'product_search_filter_widget.dart' show ProductSearchFilterWidget;
import 'package:flutter/material.dart';

class ProductSearchFilterModel
    extends FlutterFlowModel<ProductSearchFilterWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for FilterChip.
  late FilterChipModel filterChipModel1;
  // Model for FilterChip.
  late FilterChipModel filterChipModel2;
  // Model for FilterChip.
  late FilterChipModel filterChipModel3;
  // Model for FilterChip.
  late FilterChipModel filterChipModel4;
  // Model for FilterChip.
  late FilterChipModel filterChipModel5;
  // Model for ProductCard.
  late ProductCard7Model productCardModel1;
  // Model for ProductCard.
  late ProductCard7Model productCardModel2;
  // Model for ProductCard.
  late ProductCard7Model productCardModel3;
  // Model for ProductCard.
  late ProductCard7Model productCardModel4;
  // Model for ProductCard.
  late ProductCard7Model productCardModel5;
  // Model for ProductCard.
  late ProductCard7Model productCardModel6;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextFieldModel());
    filterChipModel1 = createModel(context, () => FilterChipModel());
    filterChipModel2 = createModel(context, () => FilterChipModel());
    filterChipModel3 = createModel(context, () => FilterChipModel());
    filterChipModel4 = createModel(context, () => FilterChipModel());
    filterChipModel5 = createModel(context, () => FilterChipModel());
    productCardModel1 = createModel(context, () => ProductCard7Model());
    productCardModel2 = createModel(context, () => ProductCard7Model());
    productCardModel3 = createModel(context, () => ProductCard7Model());
    productCardModel4 = createModel(context, () => ProductCard7Model());
    productCardModel5 = createModel(context, () => ProductCard7Model());
    productCardModel6 = createModel(context, () => ProductCard7Model());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
    filterChipModel1.dispose();
    filterChipModel2.dispose();
    filterChipModel3.dispose();
    filterChipModel4.dispose();
    filterChipModel5.dispose();
    productCardModel1.dispose();
    productCardModel2.dispose();
    productCardModel3.dispose();
    productCardModel4.dispose();
    productCardModel5.dispose();
    productCardModel6.dispose();
  }
}
