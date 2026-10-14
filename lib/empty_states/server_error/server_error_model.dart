import '/components/empty_state_server_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'server_error_widget.dart' show ServerErrorWidget;
import 'package:flutter/material.dart';

class ServerErrorModel extends FlutterFlowModel<ServerErrorWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for empty_state_server component.
  late EmptyStateServerModel emptyStateServerModel;

  @override
  void initState(BuildContext context) {
    emptyStateServerModel = createModel(context, () => EmptyStateServerModel());
  }

  @override
  void dispose() {
    emptyStateServerModel.dispose();
  }
}
