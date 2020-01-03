import 'package:flutter/material.dart';
import 'package:lunasea/system/ui.dart';

class Logging extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return _LoggingWidget();
    }
}

class _LoggingWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _LoggingState();
    }
}

class _LoggingState extends State<StatefulWidget> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            body: _loggingSettings(),
        );
    }

    Widget _loggingSettings() {
        return ListView(
            children: <Widget>[

            ],
            padding: Elements.getListViewPadding(),
        );
    }
}
