import '/components/button3_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'popup_advertisement2_widget.dart' show PopupAdvertisement2Widget;
import 'package:flutter/material.dart';

class PopupAdvertisement2Model
    extends FlutterFlowModel<PopupAdvertisement2Widget> {
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
