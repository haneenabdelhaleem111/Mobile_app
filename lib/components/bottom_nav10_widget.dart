import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'bottom_nav10_model.dart';
export 'bottom_nav10_model.dart';

class BottomNav10Widget extends StatefulWidget {
  const BottomNav10Widget({
    super.key,
    this.child,
  });

  final Widget Function()? child;

  @override
  State<BottomNav10Widget> createState() => _BottomNav10WidgetState();
}

class _BottomNav10WidgetState extends State<BottomNav10Widget> {
  late BottomNav10Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BottomNav10Model());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Builder(builder: (_) {
                return widget.child != null
                    ? widget.child!()
                    : SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
