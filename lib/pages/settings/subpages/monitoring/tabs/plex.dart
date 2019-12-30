import 'package:flutter/material.dart';
import 'package:lunasea/system/ui.dart';

class Plex extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return _PlexWidget();
    }
}

class _PlexWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _PlexState();
    }
}

class _PlexState extends State<StatefulWidget> {
    @override
    Widget build(BuildContext context) {
        return Notifications.centeredMessage('Coming Soon');
    }
}
