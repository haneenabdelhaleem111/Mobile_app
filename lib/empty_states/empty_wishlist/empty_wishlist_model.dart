import '/components/no_wishlist_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'empty_wishlist_widget.dart' show EmptyWishlistWidget;
import 'package:flutter/material.dart';

class EmptyWishlistModel extends FlutterFlowModel<EmptyWishlistWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for no_wishlist component.
  late NoWishlistModel noWishlistModel;

  @override
  void initState(BuildContext context) {
    noWishlistModel = createModel(context, () => NoWishlistModel());
  }

  @override
  void dispose() {
    noWishlistModel.dispose();
  }
}
