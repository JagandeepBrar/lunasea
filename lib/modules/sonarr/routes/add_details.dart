import 'package:flutter/material.dart';

class SonarrAddDetails extends StatefulWidget {
    static const ROUTE_NAME = '/lidarr/add/details';

    @override
    State<SonarrAddDetails> createState() => _State();
}

class _State extends State<SonarrAddDetails> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
    );
}
