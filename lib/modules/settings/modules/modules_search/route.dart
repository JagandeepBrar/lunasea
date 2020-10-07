import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesSearchRouter {
    static const ROUTE_NAME = '/settings/modules/search';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsModulesSearchRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsModulesSearchRouter._();
}

class _SettingsModulesSearchRoute extends StatefulWidget {
    @override
    State<_SettingsModulesSearchRoute> createState() => _State();
}

class _State extends State<_SettingsModulesSearchRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        popUntil: '/settings',
        title: 'Search',
        actions: [
            LSIconButton(
                icon: Icons.brush,
                onPressed: () async => SettingsCustomizationSearchRouter.navigateTo(context),
            ),
        ]
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.indexersBox.listenable(),
        builder: (context, box, _) => LSListView(
            children: [
                LSHeader(
                    text: 'Newznab Indexers',
                    subtitle: 'Supports all standard newznab-based indexers, including NZBHydra2',
                ),
                if(Database.indexersBox.isEmpty) _noIndexers,
                ..._indexerList,
                _addIndexer,
            ],
        ),
    );

    List<Widget> get _indexerList {
        List<SettingsModulesSearchIndexerTile> list = List.generate(Database.indexersBox.length, (index) => SettingsModulesSearchIndexerTile(
            indexer: Database.indexersBox.getAt(index),
            index: index,
        ));
        list.sort((a,b) => a.indexer.displayName.toLowerCase().trim().compareTo(b.indexer.displayName.toLowerCase().trim()));
        return list;
    }

    Widget get _noIndexers => LSGenericMessage(text: 'No Indexers Added');

    Widget get _addIndexer => LSButton(
        text: 'Add New Indexer',
        onTap: () async => SettingsModulesSearchAddRouter.navigateTo(context),
    );
}
