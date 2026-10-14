import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'bottom_nav3_model.dart';
export 'bottom_nav3_model.dart';

class BottomNav3Widget extends StatefulWidget {
  const BottomNav3Widget({
    super.key,
    this.child,
  });

  final Widget Function()? child;

  @override
  State<BottomNav3Widget> createState() => _BottomNav3WidgetState();
}

class _BottomNav3WidgetState extends State<BottomNav3Widget> {
  late BottomNav3Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BottomNav3Model());
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
