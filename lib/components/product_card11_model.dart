import '/components/button21_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'product_card11_widget.dart' show ProductCard11Widget;
import 'package:flutter/material.dart';

class ProductCard11Model extends FlutterFlowModel<ProductCard11Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button21Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button21Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
