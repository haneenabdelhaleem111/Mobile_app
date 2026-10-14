import '/components/empty_state_no_order_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'empty_no_orders_model.dart';
export 'empty_no_orders_model.dart';

class EmptyNoOrdersWidget extends StatefulWidget {
  const EmptyNoOrdersWidget({super.key});

  static String routeName = 'empty_no_orders';
  static String routePath = '/emptyNoOrders';

  @override
  State<EmptyNoOrdersWidget> createState() => _EmptyNoOrdersWidgetState();
}

class _EmptyNoOrdersWidgetState extends State<EmptyNoOrdersWidget> {
  late EmptyNoOrdersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyNoOrdersModel());
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
            model: _model.emptyStateNoOrderModel,
            updateCallback: () => safeSetState(() {}),
            child: EmptyStateNoOrderWidget(),
          ),
        ),
      ),
    );
  }
}
