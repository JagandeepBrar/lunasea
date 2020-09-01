import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesSearchRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/search';

    @override
    State<SettingsModulesSearchRoute> createState() => _State();
}

class _State extends State<SettingsModulesSearchRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(
        title: 'Search',
        actions: [
            LSIconButton(
                icon: Icons.brush,
                onPressed: () async => Navigator.of(context).pushNamed(SettingsCustomizationSearchRoute.ROUTE_NAME),
            ),
        ]
    );

    Widget get _body => LSListView(
        children: [
            LSHeader(
                text: 'Newznab Indexers',
                subtitle: 'Supports all standard newznab-based indexers, including NZBHydra2',
            ),
            if(Database.indexersBox.isEmpty) _noIndexers,
            ..._indexerList,
            LSDivider(),
            _addIndexer,

        ],
    );

    List<Widget> get _indexerList {
        List<SettingsModulesSearchIndexerTile> list = List.generate(Database.indexersBox.length, (index) => SettingsModulesSearchIndexerTile(
            indexer: Database.indexersBox.getAt(index),
        ));
        list.sort((a,b) => a.indexer.displayName.toLowerCase().trim().compareTo(b.indexer.displayName.toLowerCase().trim()));
        return list;
    }

    Widget get _noIndexers => LSGenericMessage(text: 'No Indexers Added');

    Widget get _addIndexer => LSButton(
        text: 'Add New Indexer',
        onTap: () async => Navigator.of(context).pushNamed(SettingsModulesSearchAddRoute.ROUTE_NAME),
    );
}
