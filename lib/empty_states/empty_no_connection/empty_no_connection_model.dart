import '/components/empty_state_connection_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'empty_no_connection_widget.dart' show EmptyNoConnectionWidget;
import 'package:flutter/material.dart';

class EmptyNoConnectionModel extends FlutterFlowModel<EmptyNoConnectionWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for empty_state_connection component.
  late EmptyStateConnectionModel emptyStateConnectionModel;

  @override
  void initState(BuildContext context) {
    emptyStateConnectionModel =
        createModel(context, () => EmptyStateConnectionModel());
  }

  @override
  void dispose() {
    emptyStateConnectionModel.dispose();
  }
}
