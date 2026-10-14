import '/components/button10_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'popup_advertisement7_widget.dart' show PopupAdvertisement7Widget;
import 'package:flutter/material.dart';

class PopupAdvertisement7Model
    extends FlutterFlowModel<PopupAdvertisement7Widget> {
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
