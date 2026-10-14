import '/components/product_card11_widget.dart';
import '/components/text_field7_widget.dart';
import '/components/wishlist_product_card2_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'wishlist_widget.dart' show WishlistWidget;
import 'package:flutter/material.dart';

class WishlistModel extends FlutterFlowModel<WishlistWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextField7Model textFieldModel;
  // Model for WishlistProductCard.
  late WishlistProductCard2Model wishlistProductCardModel1;
  // Model for WishlistProductCard.
  late WishlistProductCard2Model wishlistProductCardModel2;
  // Model for WishlistProductCard.
  late WishlistProductCard2Model wishlistProductCardModel3;
  // Model for WishlistProductCard.
  late WishlistProductCard2Model wishlistProductCardModel4;
  // Model for ProductCard.
  late ProductCard11Model productCardModel1;
  // Model for ProductCard.
  late ProductCard11Model productCardModel2;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextField7Model());
    wishlistProductCardModel1 =
        createModel(context, () => WishlistProductCard2Model());
    wishlistProductCardModel2 =
        createModel(context, () => WishlistProductCard2Model());
    wishlistProductCardModel3 =
        createModel(context, () => WishlistProductCard2Model());
    wishlistProductCardModel4 =
        createModel(context, () => WishlistProductCard2Model());
    productCardModel1 = createModel(context, () => ProductCard11Model());
    productCardModel2 = createModel(context, () => ProductCard11Model());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
    wishlistProductCardModel1.dispose();
    wishlistProductCardModel2.dispose();
    wishlistProductCardModel3.dispose();
    wishlistProductCardModel4.dispose();
    productCardModel1.dispose();
    productCardModel2.dispose();
  }
}
