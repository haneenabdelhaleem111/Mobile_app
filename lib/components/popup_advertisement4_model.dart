import '/components/button5_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'popup_advertisement4_widget.dart' show PopupAdvertisement4Widget;
import 'package:flutter/material.dart';

class PopupAdvertisement4Model
    extends FlutterFlowModel<PopupAdvertisement4Widget> {
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
