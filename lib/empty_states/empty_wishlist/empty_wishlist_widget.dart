import '/components/no_wishlist_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'empty_wishlist_model.dart';
export 'empty_wishlist_model.dart';

class EmptyWishlistWidget extends StatefulWidget {
  const EmptyWishlistWidget({super.key});

  static String routeName = 'empty_wishlist';
  static String routePath = '/emptyWishlist';

  @override
  State<EmptyWishlistWidget> createState() => _EmptyWishlistWidgetState();
}

class _EmptyWishlistWidgetState extends State<EmptyWishlistWidget> {
  late EmptyWishlistModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyWishlistModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: wrapWithModel(
            model: _model.noWishlistModel,
            updateCallback: () => safeSetState(() {}),
            child: const NoWishlistWidget(),
          ),
        ),
      ),
    );
  }
}
