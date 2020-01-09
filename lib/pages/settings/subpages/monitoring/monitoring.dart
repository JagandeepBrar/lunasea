import 'package:flutter/material.dart';
import 'package:lunasea/system/ui.dart';

class Monitoring extends StatefulWidget {
    @override
    State<Monitoring> createState() {
        return _State();
    }
}

class _State extends State<Monitoring> {
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
