import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';

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
            appBar: LSAppBar('Settings'),
            body: Notifications.centeredMessage('Coming Soon'),
        );
    }
}
