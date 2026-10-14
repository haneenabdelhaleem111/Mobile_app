import '/components/button20_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'product_card10_widget.dart' show ProductCard10Widget;
import 'package:flutter/material.dart';

class ProductCard10Model extends FlutterFlowModel<ProductCard10Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button20Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button20Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
