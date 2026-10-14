import '/components/button10_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'product_card8_widget.dart' show ProductCard8Widget;
import 'package:flutter/material.dart';

class ProductCard8Model extends FlutterFlowModel<ProductCard8Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button10Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button10Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
