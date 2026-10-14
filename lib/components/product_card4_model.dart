import '/components/button5_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'product_card4_widget.dart' show ProductCard4Widget;
import 'package:flutter/material.dart';

class ProductCard4Model extends FlutterFlowModel<ProductCard4Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button5Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button5Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
