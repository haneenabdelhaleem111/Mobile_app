import '/components/empty_state_connection_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'empty_no_connection_model.dart';
export 'empty_no_connection_model.dart';

class EmptyNoConnectionWidget extends StatefulWidget {
  const EmptyNoConnectionWidget({super.key});

  static String routeName = 'empty_no_connection';
  static String routePath = '/emptyNoConnection';

  @override
  State<EmptyNoConnectionWidget> createState() =>
      _EmptyNoConnectionWidgetState();
}

class _EmptyNoConnectionWidgetState extends State<EmptyNoConnectionWidget> {
  late EmptyNoConnectionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyNoConnectionModel());
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
            model: _model.emptyStateConnectionModel,
            updateCallback: () => safeSetState(() {}),
            child: EmptyStateConnectionWidget(),
          ),
        ),
      ),
    );
  }
}
