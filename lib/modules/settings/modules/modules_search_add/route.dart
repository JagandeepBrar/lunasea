import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesSearchAddRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/search/add';

    @override
    State<SettingsModulesSearchAddRoute> createState() => _State();
}

class _State extends State<SettingsModulesSearchAddRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Add Indexer');

    Widget get _body => LSListView(
        children: [],
    );
}
