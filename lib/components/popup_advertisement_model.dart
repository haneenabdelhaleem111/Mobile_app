import '/components/button2_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'popup_advertisement_widget.dart' show PopupAdvertisementWidget;
import 'package:flutter/material.dart';

class PopupAdvertisementModel
    extends FlutterFlowModel<PopupAdvertisementWidget> {
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
