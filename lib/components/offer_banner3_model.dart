import '/components/button3_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'offer_banner3_widget.dart' show OfferBanner3Widget;
import 'package:flutter/material.dart';

class OfferBanner3Model extends FlutterFlowModel<OfferBanner3Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button3Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button3Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
