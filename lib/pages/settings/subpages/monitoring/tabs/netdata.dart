import 'package:flutter/material.dart';
import 'package:lunasea/system/ui.dart';

class Netdata extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return _NetdataWidget();
    }
}

class _NetdataWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _NetdataState();
    }
}

class _NetdataState extends State<StatefulWidget> {
    @override
    Widget build(BuildContext context) {
        return Notifications.centeredMessage('Coming Soon');
    }
}
