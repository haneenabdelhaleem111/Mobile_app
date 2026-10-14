import '/components/button8_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'offer_banner8_widget.dart' show OfferBanner8Widget;
import 'package:flutter/material.dart';

class OfferBanner8Model extends FlutterFlowModel<OfferBanner8Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button8Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button8Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
