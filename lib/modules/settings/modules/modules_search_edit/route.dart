import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesSearchEditRouteArguments {
    final IndexerHiveObject indexer;

    SettingsModulesSearchEditRouteArguments({
        @required this.indexer,
    });
}

class SettingsModulesSearchEditRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/search/edit';

    @override
    State<SettingsModulesSearchEditRoute> createState() => _State();
}

class _State extends State<SettingsModulesSearchEditRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Edit Indexer');

    Widget get _body => LSListView(
        children: [],
    );
}
