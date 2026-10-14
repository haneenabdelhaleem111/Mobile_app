import '/components/empty_state_no_order_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'empty_no_orders_widget.dart' show EmptyNoOrdersWidget;
import 'package:flutter/material.dart';

class EmptyNoOrdersModel extends FlutterFlowModel<EmptyNoOrdersWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for empty_state_no_order component.
  late EmptyStateNoOrderModel emptyStateNoOrderModel;

  @override
  void initState(BuildContext context) {
    emptyStateNoOrderModel =
        createModel(context, () => EmptyStateNoOrderModel());
  }

  @override
  void dispose() {
    emptyStateNoOrderModel.dispose();
  }
}
