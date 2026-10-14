import '/components/button7_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'offer_banner7_widget.dart' show OfferBanner7Widget;
import 'package:flutter/material.dart';

class OfferBanner7Model extends FlutterFlowModel<OfferBanner7Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button7Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button7Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
