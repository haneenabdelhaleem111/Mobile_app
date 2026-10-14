import '/components/button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'offer_banner_widget.dart' show OfferBannerWidget;
import 'package:flutter/material.dart';

class OfferBannerModel extends FlutterFlowModel<OfferBannerWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
