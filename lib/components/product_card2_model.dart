import '/components/button3_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'product_card2_widget.dart' show ProductCard2Widget;
import 'package:flutter/material.dart';

class ProductCard2Model extends FlutterFlowModel<ProductCard2Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button3Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button3Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
