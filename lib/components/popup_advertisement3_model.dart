import '/components/button4_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'popup_advertisement3_widget.dart' show PopupAdvertisement3Widget;
import 'package:flutter/material.dart';

class PopupAdvertisement3Model
    extends FlutterFlowModel<PopupAdvertisement3Widget> {
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
