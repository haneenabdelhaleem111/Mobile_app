import '/components/empty_state_no_cart_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'empty_cart_widget.dart' show EmptyCartWidget;
import 'package:flutter/material.dart';

class EmptyCartModel extends FlutterFlowModel<EmptyCartWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for empty_state_no_cart component.
  late EmptyStateNoCartModel emptyStateNoCartModel;

  @override
  void initState(BuildContext context) {
    emptyStateNoCartModel = createModel(context, () => EmptyStateNoCartModel());
  }

  @override
  void dispose() {
    emptyStateNoCartModel.dispose();
  }
}
