import '/components/button6_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'offer_banner6_widget.dart' show OfferBanner6Widget;
import 'package:flutter/material.dart';

class OfferBanner6Model extends FlutterFlowModel<OfferBanner6Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button6Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button6Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
