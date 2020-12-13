import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSearchRouter extends LunaPageRouter {
    static const ROUTE_NAME = '/settings/configuration/search';

    Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        ROUTE_NAME,
    );

    String route(List parameters) => ROUTE_NAME;
    
    void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsModulesSearchRoute()),
        transitionType: LunaRouter.transitionType,
    );
}

class _SettingsModulesSearchRoute extends StatefulWidget {
    @override
    State<_SettingsModulesSearchRoute> createState() => _State();
}

class _State extends State<_SettingsModulesSearchRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final _helpMessage = [
        'LunaSea currently supports all indexers that support the newznab protocol, including NZBHydra2.',
    ].join('\n\n');

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Search',
        actions: [
            LSIconButton(
                icon: Icons.help_outline,
                onPressed: () async => LunaDialogs.textPreview(context, 'Help', _helpMessage),
            )
        ],
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.indexersBox.listenable(),
        builder: (context, box, _) => LSListView(
            children: [
                if(Database.indexersBox.isEmpty) _noIndexersMessage,
                ..._indexerList,
                _addIndexerButton,
                ..._filteringSection,
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

    Widget get _noIndexersMessage => LSGenericMessage(text: 'No Indexers Added');

    Widget get _addIndexerButton => LSButton(
        text: 'Add New Indexer',
        onTap: () async => SettingsModulesSearchAddRouter.navigateTo(context),
    );

    List<Widget> get _filteringSection => [
        LSHeader(
            text: 'Filtering',
            subtitle: 'Options related to filtering the search results',
        ),
        _hideAdultCategoriesTile,
    ];

    Widget get _hideAdultCategoriesTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [SearchDatabaseValue.HIDE_XXX.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Hide Adult Categories'),
            subtitle: LSSubtitle(text: 'Hide Adult Content'),
            trailing: Switch(
                value: SearchDatabaseValue.HIDE_XXX.data,
                onChanged: (value) => SearchDatabaseValue.HIDE_XXX.put(value),
            ),
        ),
    );
}
