import 'package:flutter/material.dart';
import 'package:lunasea/system/ui.dart';

class ViewLogs extends StatelessWidget {
    final String type;

    ViewLogs({
        Key key,
        @required this.type,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return _ViewLogsWidget(type: type);
    }
}

class _ViewLogsWidget extends StatefulWidget {
    final String type;

    _ViewLogsWidget({
        Key key,
        @required this.type,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() {
        return _ViewLogsState(type: type);
    }
}

class _ViewLogsState extends State<StatefulWidget> {
    final String type;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    
    _ViewLogsState({
        Key key,
        @required this.type,
    });

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: Navigation.getAppBar('$type Logs', context),
            body: Notifications.centeredMessage('No Logs Found'),
        );
    }
}
