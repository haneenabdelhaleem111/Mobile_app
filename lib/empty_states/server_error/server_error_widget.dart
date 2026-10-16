import '/components/empty_state_server_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'server_error_model.dart';
export 'server_error_model.dart';

class ServerErrorWidget extends StatefulWidget {
  const ServerErrorWidget({super.key});

  static String routeName = 'server_error';
  static String routePath = '/serverError';

  @override
  State<ServerErrorWidget> createState() => _ServerErrorWidgetState();
}

class _ServerErrorWidgetState extends State<ServerErrorWidget> {
  late ServerErrorModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ServerErrorModel());
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
            model: _model.emptyStateServerModel,
            updateCallback: () => safeSetState(() {}),
            child: const EmptyStateServerWidget(),
          ),
        ),
      ),
    );
  }
}
