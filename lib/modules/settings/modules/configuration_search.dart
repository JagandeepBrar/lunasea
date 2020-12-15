import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSearchRouter extends LunaPageRouter {
    SettingsConfigurationSearchRouter() : super('/settings/configuration/search');

    void defineRoute(FluroRouter router) => router.define(
        fullRoute,
        handler: Handler(handlerFunc: (context, params) => _SettingsConfigurationSearchRoute()),
        transitionType: LunaRouter.transitionType,
    );
}

class _SettingsConfigurationSearchRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationSearchRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationSearchRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Search',
        actions: [_helpMessageButton],
    );
    
    Widget get _helpMessageButton => LSIconButton(
        icon: Icons.help_outline,
        onPressed: () async => SettingsDialogs.helpMessage(
            context,
            title: SearchConstants.MODULE_MAP.name,
            message: SearchConstants.MODULE_MAP.helpMessage,
            github: SearchConstants.MODULE_MAP.github,
            website: SearchConstants.MODULE_MAP.website,
        ),
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.indexersBox.listenable(),
        builder: (context, box, _) => LSListView(
            children: [
                ..._indexerSection,
                ..._filteringSection,
            ],
        ),
    );

    List<Widget> get _indexerSection => [
        if(Database.indexersBox.isEmpty) LSGenericMessage(text: 'No Indexers Added'),
        ..._indexers,
        LSButton(
            text: 'Add New Indexer',
            onTap: () async => SettingsConfigurationSearchAddRouter().navigateTo(context),
        ),
    ];

    List<Widget> get _indexers {
        List<LSCardTile> list = List.generate(
            Database.indexersBox.length,
            (index) => _indexerTile(Database.indexersBox.getAt(index), index),
        );
        list.sort((a,b) => (a.subtitle as LSSubtitle).text.toLowerCase().trim().compareTo((b.subtitle as LSSubtitle).text.toLowerCase().trim()));
        return list;
    }

    List<Widget> get _filteringSection => [
        LSHeader(text: 'Filtering'),
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

    Widget _indexerTile(IndexerHiveObject indexer, int index) => LSCardTile(
        title: LSTitle(text: indexer.displayName),
        subtitle: LSSubtitle(text: indexer.host),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => SettingsConfigurationSearchEditRouter().navigateTo(
            context,
            index: index,
        ),
    );
}
