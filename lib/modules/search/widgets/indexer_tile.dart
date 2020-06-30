import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchIndexerTile extends StatelessWidget {
    final IndexerHiveObject indexer;
    final int index;

    SearchIndexerTile({
        @required this.indexer,
        this.index = 0,
    });

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: indexer.displayName),
        subtitle: LSSubtitle(text: indexer.host),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        leading: LSIconButton(icon: Icons.rss_feed, color: LSColors.list(index)),
        onTap: () async => _enterIndexer(context),
    );

    Future<void> _enterIndexer(BuildContext context) async {
        Provider.of<SearchModel>(context, listen: false)?.indexer = indexer;
        await Navigator.of(context).pushNamed(SearchCategories.ROUTE_NAME);
    }
}
