import '/components/button4_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'offer_banner4_widget.dart' show OfferBanner4Widget;
import 'package:flutter/material.dart';

class OfferBanner4Model extends FlutterFlowModel<OfferBanner4Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button4Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button4Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
