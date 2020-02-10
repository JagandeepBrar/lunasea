import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class Calendar extends StatefulWidget {
    @override
    State<Calendar> createState() {
        return _State();
    }
}

class _State extends State<Calendar> {
    @override
    Widget build(BuildContext context) {
        return Notifications.centeredMessage('Coming Soon');
    }
}
