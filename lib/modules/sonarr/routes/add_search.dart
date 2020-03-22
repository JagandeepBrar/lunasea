import 'package:flutter/material.dart';
import 'package:lunasea/core/ui/navigation/appbar.dart';

class SonarrAddSearch extends StatefulWidget {
    static const ROUTE_NAME = '/sonarr/add/search';

    @override
    State<SonarrAddSearch> createState() => _State();
}

class _State extends State<SonarrAddSearch> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
    );

    Widget get _appBar => LSAppBar(title: 'Add Series');
}