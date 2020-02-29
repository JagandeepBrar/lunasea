import 'package:flutter/material.dart';
import 'package:lunasea/core/database.dart';
import 'package:lunasea/routes/search/categories.dart';
import 'package:lunasea/widgets/ui.dart';

class SearchIndexers extends StatefulWidget {
    static const ROUTE_NAME = '/search/indexers';

    @override
    State<SearchIndexers> createState() =>  _State();
}

class _State extends State<SearchIndexers> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.indexersBox.listenable(),
        builder: (context, indexerBox, widget) => Scaffold(
            key: _scaffoldKey,
            appBar: _appBar,
            drawer: _drawer,
            body: _body,
        ),
    );

    Widget get _appBar => LSAppBar(title: 'Search');

    Widget get _drawer => LSDrawer(page: 'search');

    Widget get _body => LSListViewBuilder(
        itemCount: Database.indexersBox.length,
        itemBuilder: (context, index) => _indexerTile(index),
    );

    Widget _indexerTile(int index) => LSCardTile(
        title: LSTitle(text: (Database.indexersBox.getAt(index) as IndexerHiveObject).displayName),
        subtitle: LSSubtitle(text: (Database.indexersBox.getAt(index) as IndexerHiveObject).host),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        leading: LSIconButton(icon: Icons.rss_feed, color: LSColors.list(index)),
        onTap: () => _enterIndexer(Database.indexersBox.getAt(index)),
    );

    Future<void> _enterIndexer(IndexerHiveObject indexer) async => Navigator.of(context).pushNamed(
        SearchCategories.ROUTE_NAME,
        arguments: SearchCategoriesArguments(indexer: indexer),
    );
}
