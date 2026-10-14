import '/components/brand_logo_card_widget.dart';
import '/components/button24_widget.dart';
import '/components/emshaty_category2_widget.dart';
import '/components/emshaty_product_card2_widget.dart';
import '/components/emshaty_promo_banner2_widget.dart';
import '/components/emshaty_search_bar2_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for EmshatySearchBar.
  late EmshatySearchBar2Model emshatySearchBarModel;
  // Model for EmshatyPromoBanner.
  late EmshatyPromoBanner2Model emshatyPromoBannerModel1;
  // Model for Button.
  late Button24Model buttonModel1;
  // Model for EmshatyCategory.
  late EmshatyCategory2Model emshatyCategoryModel1;
  // Model for EmshatyCategory.
  late EmshatyCategory2Model emshatyCategoryModel2;
  // Model for EmshatyCategory.
  late EmshatyCategory2Model emshatyCategoryModel3;
  // Model for EmshatyCategory.
  late EmshatyCategory2Model emshatyCategoryModel4;
  // Model for EmshatyCategory.
  late EmshatyCategory2Model emshatyCategoryModel5;
  // Model for Button.
  late Button24Model buttonModel2;
  // Model for BrandLogoCard.
  late BrandLogoCardModel brandLogoCardModel1;
  // Model for BrandLogoCard.
  late BrandLogoCardModel brandLogoCardModel2;
  // Model for BrandLogoCard.
  late BrandLogoCardModel brandLogoCardModel3;
  // Model for BrandLogoCard.
  late BrandLogoCardModel brandLogoCardModel4;
  // Model for BrandLogoCard.
  late BrandLogoCardModel brandLogoCardModel5;
  // Model for Button.
  late Button24Model buttonModel3;
  // Model for EmshatyProductCard.
  late EmshatyProductCard2Model emshatyProductCardModel1;
  // Model for EmshatyProductCard.
  late EmshatyProductCard2Model emshatyProductCardModel2;
  // Model for EmshatyProductCard.
  late EmshatyProductCard2Model emshatyProductCardModel3;
  // Model for EmshatyPromoBanner.
  late EmshatyPromoBanner2Model emshatyPromoBannerModel2;
  // Model for Button.
  late Button24Model buttonModel4;
  // Model for EmshatyProductCard.
  late EmshatyProductCard2Model emshatyProductCardModel4;
  // Model for EmshatyProductCard.
  late EmshatyProductCard2Model emshatyProductCardModel5;
  // Model for EmshatyProductCard.
  late EmshatyProductCard2Model emshatyProductCardModel6;

  @override
  void initState(BuildContext context) {
    emshatySearchBarModel =
        createModel(context, () => EmshatySearchBar2Model());
    emshatyPromoBannerModel1 =
        createModel(context, () => EmshatyPromoBanner2Model());
    buttonModel1 = createModel(context, () => Button24Model());
    emshatyCategoryModel1 = createModel(context, () => EmshatyCategory2Model());
    emshatyCategoryModel2 = createModel(context, () => EmshatyCategory2Model());
    emshatyCategoryModel3 = createModel(context, () => EmshatyCategory2Model());
    emshatyCategoryModel4 = createModel(context, () => EmshatyCategory2Model());
    emshatyCategoryModel5 = createModel(context, () => EmshatyCategory2Model());
    buttonModel2 = createModel(context, () => Button24Model());
    brandLogoCardModel1 = createModel(context, () => BrandLogoCardModel());
    brandLogoCardModel2 = createModel(context, () => BrandLogoCardModel());
    brandLogoCardModel3 = createModel(context, () => BrandLogoCardModel());
    brandLogoCardModel4 = createModel(context, () => BrandLogoCardModel());
    brandLogoCardModel5 = createModel(context, () => BrandLogoCardModel());
    buttonModel3 = createModel(context, () => Button24Model());
    emshatyProductCardModel1 =
        createModel(context, () => EmshatyProductCard2Model());
    emshatyProductCardModel2 =
        createModel(context, () => EmshatyProductCard2Model());
    emshatyProductCardModel3 =
        createModel(context, () => EmshatyProductCard2Model());
    emshatyPromoBannerModel2 =
        createModel(context, () => EmshatyPromoBanner2Model());
    buttonModel4 = createModel(context, () => Button24Model());
    emshatyProductCardModel4 =
        createModel(context, () => EmshatyProductCard2Model());
    emshatyProductCardModel5 =
        createModel(context, () => EmshatyProductCard2Model());
    emshatyProductCardModel6 =
        createModel(context, () => EmshatyProductCard2Model());
  }

  @override
  void dispose() {
    emshatySearchBarModel.dispose();
    emshatyPromoBannerModel1.dispose();
    buttonModel1.dispose();
    emshatyCategoryModel1.dispose();
    emshatyCategoryModel2.dispose();
    emshatyCategoryModel3.dispose();
    emshatyCategoryModel4.dispose();
    emshatyCategoryModel5.dispose();
    buttonModel2.dispose();
    brandLogoCardModel1.dispose();
    brandLogoCardModel2.dispose();
    brandLogoCardModel3.dispose();
    brandLogoCardModel4.dispose();
    brandLogoCardModel5.dispose();
    buttonModel3.dispose();
    emshatyProductCardModel1.dispose();
    emshatyProductCardModel2.dispose();
    emshatyProductCardModel3.dispose();
    emshatyPromoBannerModel2.dispose();
    buttonModel4.dispose();
    emshatyProductCardModel4.dispose();
    emshatyProductCardModel5.dispose();
    emshatyProductCardModel6.dispose();
  }
}
