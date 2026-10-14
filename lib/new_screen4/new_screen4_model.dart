import '/components/button23_widget.dart';
import '/components/emshaty_category_widget.dart';
import '/components/emshaty_product_card_widget.dart';
import '/components/emshaty_promo_banner_widget.dart';
import '/components/emshaty_search_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'new_screen4_widget.dart' show NewScreen4Widget;
import 'package:flutter/material.dart';

class NewScreen4Model extends FlutterFlowModel<NewScreen4Widget> {
  ///  State fields for stateful widgets in this page.

  // Model for EmshatySearchBar.
  late EmshatySearchBarModel emshatySearchBarModel;
  // Model for EmshatyPromoBanner.
  late EmshatyPromoBannerModel emshatyPromoBannerModel;
  // Model for EmshatyCategory.
  late EmshatyCategoryModel emshatyCategoryModel1;
  // Model for EmshatyCategory.
  late EmshatyCategoryModel emshatyCategoryModel2;
  // Model for EmshatyCategory.
  late EmshatyCategoryModel emshatyCategoryModel3;
  // Model for EmshatyCategory.
  late EmshatyCategoryModel emshatyCategoryModel4;
  // Model for EmshatyCategory.
  late EmshatyCategoryModel emshatyCategoryModel5;
  // Model for Button.
  late Button23Model buttonModel1;
  // Model for EmshatyProductCard.
  late EmshatyProductCardModel emshatyProductCardModel1;
  // Model for EmshatyProductCard.
  late EmshatyProductCardModel emshatyProductCardModel2;
  // Model for EmshatyProductCard.
  late EmshatyProductCardModel emshatyProductCardModel3;
  // Model for Button.
  late Button23Model buttonModel2;

  @override
  void initState(BuildContext context) {
    emshatySearchBarModel = createModel(context, () => EmshatySearchBarModel());
    emshatyPromoBannerModel =
        createModel(context, () => EmshatyPromoBannerModel());
    emshatyCategoryModel1 = createModel(context, () => EmshatyCategoryModel());
    emshatyCategoryModel2 = createModel(context, () => EmshatyCategoryModel());
    emshatyCategoryModel3 = createModel(context, () => EmshatyCategoryModel());
    emshatyCategoryModel4 = createModel(context, () => EmshatyCategoryModel());
    emshatyCategoryModel5 = createModel(context, () => EmshatyCategoryModel());
    buttonModel1 = createModel(context, () => Button23Model());
    emshatyProductCardModel1 =
        createModel(context, () => EmshatyProductCardModel());
    emshatyProductCardModel2 =
        createModel(context, () => EmshatyProductCardModel());
    emshatyProductCardModel3 =
        createModel(context, () => EmshatyProductCardModel());
    buttonModel2 = createModel(context, () => Button23Model());
  }

  @override
  void dispose() {
    emshatySearchBarModel.dispose();
    emshatyPromoBannerModel.dispose();
    emshatyCategoryModel1.dispose();
    emshatyCategoryModel2.dispose();
    emshatyCategoryModel3.dispose();
    emshatyCategoryModel4.dispose();
    emshatyCategoryModel5.dispose();
    buttonModel1.dispose();
    emshatyProductCardModel1.dispose();
    emshatyProductCardModel2.dispose();
    emshatyProductCardModel3.dispose();
    buttonModel2.dispose();
  }
}
