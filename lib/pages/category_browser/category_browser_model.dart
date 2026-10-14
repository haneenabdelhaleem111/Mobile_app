import '/components/category_item_widget.dart';
import '/components/offer_banner8_widget.dart';
import '/components/search_bar9_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'category_browser_widget.dart' show CategoryBrowserWidget;
import 'package:flutter/material.dart';

class CategoryBrowserModel extends FlutterFlowModel<CategoryBrowserWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for SearchBar.
  late SearchBar9Model searchBarModel;
  // Model for OfferBanner.
  late OfferBanner8Model offerBannerModel;
  // Model for CategoryItem.
  late CategoryItemModel categoryItemModel1;
  // Model for CategoryItem.
  late CategoryItemModel categoryItemModel2;
  // Model for CategoryItem.
  late CategoryItemModel categoryItemModel3;
  // Model for CategoryItem.
  late CategoryItemModel categoryItemModel4;
  // Model for CategoryItem.
  late CategoryItemModel categoryItemModel5;
  // Model for CategoryItem.
  late CategoryItemModel categoryItemModel6;
  // Model for CategoryItem.
  late CategoryItemModel categoryItemModel7;

  @override
  void initState(BuildContext context) {
    searchBarModel = createModel(context, () => SearchBar9Model());
    offerBannerModel = createModel(context, () => OfferBanner8Model());
    categoryItemModel1 = createModel(context, () => CategoryItemModel());
    categoryItemModel2 = createModel(context, () => CategoryItemModel());
    categoryItemModel3 = createModel(context, () => CategoryItemModel());
    categoryItemModel4 = createModel(context, () => CategoryItemModel());
    categoryItemModel5 = createModel(context, () => CategoryItemModel());
    categoryItemModel6 = createModel(context, () => CategoryItemModel());
    categoryItemModel7 = createModel(context, () => CategoryItemModel());
  }

  @override
  void dispose() {
    searchBarModel.dispose();
    offerBannerModel.dispose();
    categoryItemModel1.dispose();
    categoryItemModel2.dispose();
    categoryItemModel3.dispose();
    categoryItemModel4.dispose();
    categoryItemModel5.dispose();
    categoryItemModel6.dispose();
    categoryItemModel7.dispose();
  }
}
