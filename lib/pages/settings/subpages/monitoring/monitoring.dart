import 'package:flutter/material.dart';
import 'package:lunasea/system/ui.dart';

class Monitoring extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return _MonitoringWidget();
    }
}

class _MonitoringWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _MonitoringState();
    }
}

class _MonitoringState extends State<StatefulWidget> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: Navigation.getAppBar('Settings', context),
            body: Notifications.centeredMessage('Coming Soon'),
        );
    }
}
