import 'package:flutter/material.dart';
import 'package:lunasea/system/ui.dart';

class Tautulli extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return _TautulliWidget();
    }
}

class _TautulliWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _TautulliState();
    }
}

class _TautulliState extends State<StatefulWidget> {
    @override
    Widget build(BuildContext context) {
        return Notifications.centeredMessage('Coming Soon');
    }
}
