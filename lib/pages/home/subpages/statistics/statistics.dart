import 'package:flutter/material.dart';
import 'package:lunasea/system/ui.dart';

class Statistics extends StatefulWidget {
    @override
    State<Statistics> createState() {
        return _State();
    }
}

class _State extends State<Statistics> {
    @override
    Widget build(BuildContext context) {
        return Notifications.centeredMessage('Coming Soon');
    }
}
