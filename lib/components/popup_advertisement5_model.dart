import '/components/button6_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'popup_advertisement5_widget.dart' show PopupAdvertisement5Widget;
import 'package:flutter/material.dart';

class PopupAdvertisement5Model
    extends FlutterFlowModel<PopupAdvertisement5Widget> {
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
