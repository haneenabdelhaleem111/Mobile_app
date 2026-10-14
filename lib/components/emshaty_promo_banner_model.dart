import '/components/button23_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'emshaty_promo_banner_widget.dart' show EmshatyPromoBannerWidget;
import 'package:flutter/material.dart';

class EmshatyPromoBannerModel
    extends FlutterFlowModel<EmshatyPromoBannerWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button23Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button23Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
