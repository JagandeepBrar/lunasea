import 'package:f_logs/f_logs.dart' as FLog;
import 'package:flutter/material.dart';
import 'package:lunasea/system/ui.dart';

class LogDetails extends StatelessWidget {
    final FLog.Log log;

    LogDetails({
        Key key,
        @required this.log,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return _LogDetailsWidget(log: log);
    }
}

class _LogDetailsWidget extends StatefulWidget {
    final FLog.Log log;

    _LogDetailsWidget({
        Key key,
        @required this.log,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() {
        return _LogDetailsState(log: log);
    }
}

class _LogDetailsState extends State<StatefulWidget> {
    final FLog.Log log;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    
    _LogDetailsState({
        Key key,
        @required this.log,
    });

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: Navigation.getAppBar('Log Details', context),
        );
    }
}
