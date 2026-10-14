import '/components/button7_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'popup_advertisement6_widget.dart' show PopupAdvertisement6Widget;
import 'package:flutter/material.dart';

class PopupAdvertisement6Model
    extends FlutterFlowModel<PopupAdvertisement6Widget> {
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
