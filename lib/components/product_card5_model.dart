import '/components/button6_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'product_card5_widget.dart' show ProductCard5Widget;
import 'package:flutter/material.dart';

class ProductCard5Model extends FlutterFlowModel<ProductCard5Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button6Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button6Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
