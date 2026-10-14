import '/components/button_auth_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'empty_state_no_order_widget.dart' show EmptyStateNoOrderWidget;
import 'package:flutter/material.dart';

class EmptyStateNoOrderModel extends FlutterFlowModel<EmptyStateNoOrderWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button_auth component.
  late ButtonAuthModel buttonAuthModel;

  @override
  void initState(BuildContext context) {
    buttonAuthModel = createModel(context, () => ButtonAuthModel());
  }

  @override
  void dispose() {
    buttonAuthModel.dispose();
  }
}
