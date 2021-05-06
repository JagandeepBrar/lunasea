import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSearchRouter extends SettingsPageRouter {
  SettingsConfigurationSearchRouter() : super('/settings/configuration/search');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router);
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Search',
      scrollControllers: [scrollController],
      actions: [
        LunaIconButton(
          icon: Icons.help_outline,
          onPressed: () async =>
              SettingsDialogs().moduleInformation(context, LunaModule.SEARCH),
        ),
      ],
    );
  }

  Widget _bottomNavigationBar() {
    return LunaBottomActionBar(
      actions: [
        LunaButton.text(
          text: 'Add Indexer',
          icon: Icons.add_rounded,
          onTap: () async =>
              SettingsConfigurationSearchAddRouter().navigateTo(context),
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
          ..._indexerSection(),
          ..._customization(),
        ],
      ),
    );
  }

  List<Widget> _indexerSection() => [
        if (Database.indexersBox.isEmpty)
          LunaMessage(text: 'No Indexers Found'),
        ..._indexers,
      ];

  List<Widget> get _indexers {
    List<IndexerHiveObject> indexers = Database.indexersBox.values.toList();
    indexers.sort((a, b) =>
        a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase()));
    List<LunaListTile> list = List.generate(
      indexers.length,
      (index) => _indexerTile(indexers[index], indexers[index].key),
    );
    return list;
  }

  Widget _indexerTile(IndexerHiveObject indexer, int index) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: indexer.displayName),
      subtitle: LunaText.subtitle(text: indexer.host),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async => SettingsConfigurationSearchEditRouter().navigateTo(
        context,
        indexerId: index,
      ),
    );
  }

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
