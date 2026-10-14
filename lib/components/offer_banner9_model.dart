import '/components/button10_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'offer_banner9_widget.dart' show OfferBanner9Widget;
import 'package:flutter/material.dart';

class OfferBanner9Model extends FlutterFlowModel<OfferBanner9Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button10Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button10Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
