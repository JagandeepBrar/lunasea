import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSearchRouter extends LunaPageRouter {
    SettingsConfigurationSearchRouter() : super('/settings/configuration/search');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationSearchRoute());
}

class _SettingsConfigurationSearchRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationSearchRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationSearchRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Search',
            scrollControllers: [scrollController],
            actions: [
                LunaIconButton(
                    icon: Icons.help_outline,
                    onPressed: () async => SettingsDialogs().moduleInformation(context, LunaModule.SEARCH),
                ),
            ],
        );
    }

    Widget _body() {
        return ValueListenableBuilder(
            valueListenable: Database.indexersBox.listenable(),
            builder: (context, box, _) => LunaListView(
                controller: scrollController,
                children: [
                    ..._indexerSection,
                    ..._customization(),
                ],
            ),
        );
    }

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
            (index) {
                IndexerHiveObject indexer = Database.indexersBox.getAt(index);
                return _indexerTile(indexer, indexer.key);
            }
        );
        list.sort((a,b) => (a.subtitle as LSSubtitle).text.toLowerCase().trim().compareTo((b.subtitle as LSSubtitle).text.toLowerCase().trim()));
        return list;
    }

    Widget _indexerTile(IndexerHiveObject indexer, int index) => LSCardTile(
        title: LSTitle(text: indexer.displayName),
        subtitle: LSSubtitle(text: indexer.host),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => SettingsConfigurationSearchEditRouter().navigateTo(
            context,
            indexerId: index,
        ),
    );

    List<Widget> _customization() {
        return [
            LunaDivider(),
            _hideAdultCategories(),
            _showLinks(),
        ];
    }

    Widget _hideAdultCategories() {
        return SearchDatabaseValue.HIDE_XXX.listen(
            builder: (context, box, widget) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Hide Adult Categories'),
                subtitle: LunaText.subtitle(text: 'Hide Adult Content'),
                trailing: LunaSwitch(
                    value: SearchDatabaseValue.HIDE_XXX.data,
                    onChanged: (value) => SearchDatabaseValue.HIDE_XXX.put(value),
                ),
            ),
        );
    }

    Widget _showLinks() {
        return SearchDatabaseValue.SHOW_LINKS.listen(
            builder: (context, box, widget) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Show Links'),
                subtitle: LunaText.subtitle(text: 'Show Download and Comments Links'),
                trailing: LunaSwitch(
                    value: SearchDatabaseValue.SHOW_LINKS.data,
                    onChanged: (value) => SearchDatabaseValue.SHOW_LINKS.put(value),
                ),
            ),
        );
    }
}
