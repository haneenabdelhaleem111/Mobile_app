import '/components/button24_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'emshaty_product_card2_widget.dart' show EmshatyProductCard2Widget;
import 'package:flutter/material.dart';

class EmshatyProductCard2Model
    extends FlutterFlowModel<EmshatyProductCard2Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button24Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button24Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
