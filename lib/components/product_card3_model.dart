import '/components/button4_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'product_card3_widget.dart' show ProductCard3Widget;
import 'package:flutter/material.dart';

class ProductCard3Model extends FlutterFlowModel<ProductCard3Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button4Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button4Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
