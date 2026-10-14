import '/components/button7_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'product_card6_widget.dart' show ProductCard6Widget;
import 'package:flutter/material.dart';

class ProductCard6Model extends FlutterFlowModel<ProductCard6Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button7Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button7Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
