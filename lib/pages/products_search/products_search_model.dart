import '/components/filter_chip2_widget.dart';
import '/components/product_card13_widget.dart';
import '/components/text_field8_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'products_search_widget.dart' show ProductsSearchWidget;
import 'package:flutter/material.dart';

class ProductsSearchModel extends FlutterFlowModel<ProductsSearchWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextField8Model textFieldModel;
  // Model for FilterChip.
  late FilterChip2Model filterChipModel1;
  // Model for FilterChip.
  late FilterChip2Model filterChipModel2;
  // Model for FilterChip.
  late FilterChip2Model filterChipModel3;
  // Model for FilterChip.
  late FilterChip2Model filterChipModel4;
  // Model for FilterChip.
  late FilterChip2Model filterChipModel5;
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
    filterChipModel1 = createModel(context, () => FilterChip2Model());
    filterChipModel2 = createModel(context, () => FilterChip2Model());
    filterChipModel3 = createModel(context, () => FilterChip2Model());
    filterChipModel4 = createModel(context, () => FilterChip2Model());
    filterChipModel5 = createModel(context, () => FilterChip2Model());
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
