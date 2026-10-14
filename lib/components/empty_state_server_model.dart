import '/components/button_auth_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'empty_state_server_widget.dart' show EmptyStateServerWidget;
import 'package:flutter/material.dart';

class EmptyStateServerModel extends FlutterFlowModel<EmptyStateServerWidget> {
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
