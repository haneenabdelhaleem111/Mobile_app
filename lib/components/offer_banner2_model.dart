import '/components/button2_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'offer_banner2_widget.dart' show OfferBanner2Widget;
import 'package:flutter/material.dart';

class OfferBanner2Model extends FlutterFlowModel<OfferBanner2Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button2Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button2Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
