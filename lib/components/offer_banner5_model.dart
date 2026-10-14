import '/components/button5_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'offer_banner5_widget.dart' show OfferBanner5Widget;
import 'package:flutter/material.dart';

class OfferBanner5Model extends FlutterFlowModel<OfferBanner5Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button5Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button5Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
