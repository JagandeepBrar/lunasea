import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';

class RadarrAddSearch extends StatefulWidget {
    static const ROUTE_NAME = '/radarr/add/search';

    @override
    State<RadarrAddSearch> createState() => _State();
}

class _State extends State<RadarrAddSearch> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
    );

    Widget get _appBar => LSAppBar(title: 'Add Movie');
}
