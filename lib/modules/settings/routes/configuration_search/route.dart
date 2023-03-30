import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/models/indexer.dart';
import 'package:lunasea/modules/search/core.dart';
import 'package:lunasea/router/routes/settings.dart';

class ConfigurationSearchRoute extends StatefulWidget {
  const ConfigurationSearchRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationSearchRoute> createState() => _State();
}

class _State extends State<ConfigurationSearchRoute>
    with LunaScrollControllerMixin {
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

  PreferredSizeWidget _appBar() {
    return LunaAppBar(
      title: 'search.Search'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _bottomNavigationBar() {
    return LunaBottomActionBar(
      actions: [
        LunaButton.text(
          text: 'search.AddIndexer'.tr(),
          icon: Icons.add_rounded,
          onTap: SettingsRoutes.CONFIGURATION_SEARCH_ADD_INDEXER.go,
        ),
      ],
    );
  }

  Widget _body() {
    return LunaBox.indexers.listenableBuilder(
      builder: (context, _) => LunaListView(
        controller: scrollController,
        children: [
          LunaModule.SEARCH.informationBanner(),
          ..._indexerSection(),
          ..._customization(),
        ],
      ),
    );
  }

  List<Widget> _indexerSection() {
    if (LunaBox.indexers.isEmpty) {
      return [LunaMessage(text: 'search.NoIndexersFound'.tr())];
    }
    return _indexers;
  }

  List<Widget> get _indexers {
    List<LunaIndexer> indexers = LunaBox.indexers.data.toList();
    indexers.sort((a, b) =>
        a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase()));
    List<LunaBlock> list = List.generate(
      indexers.length,
      (index) =>
          _indexerTile(indexers[index], indexers[index].key) as LunaBlock,
    );
    return list;
  }

  Widget _indexerTile(LunaIndexer indexer, int index) {
    return LunaBlock(
      title: indexer.displayName,
      body: [TextSpan(text: indexer.host)],
      trailing: const LunaIconButton.arrow(),
      onTap: () => SettingsRoutes.CONFIGURATION_SEARCH_EDIT_INDEXER.go(
        params: {
          'id': index.toString(),
        },
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
    const _db = SearchDatabase.HIDE_XXX;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'search.HideAdultCategories'.tr(),
        body: [TextSpan(text: 'search.HideAdultCategoriesDescription'.tr())],
        trailing: LunaSwitch(
          value: _db.read(),
          onChanged: _db.update,
        ),
      ),
    );
  }

  Widget _showLinks() {
    const _db = SearchDatabase.SHOW_LINKS;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'search.ShowLinks'.tr(),
        body: [TextSpan(text: 'search.ShowLinksDescription'.tr())],
        trailing: LunaSwitch(
          value: _db.read(),
          onChanged: _db.update,
        ),
      ),
    );
  }
}
