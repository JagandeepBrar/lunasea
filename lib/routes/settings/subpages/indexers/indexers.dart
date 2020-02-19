import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';

class Indexers extends StatefulWidget {
    @override
    State<Indexers> createState() {
        return _State();
    }
}

class _State extends State<Indexers> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: LSAppBar(title: 'Settings'),
            body: Notifications.centeredMessage('Coming Soon'),
        );
    }
}
