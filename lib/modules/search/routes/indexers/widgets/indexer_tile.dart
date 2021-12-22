import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchIndexerTile extends StatelessWidget {
  final IndexerHiveObject indexer;

  const SearchIndexerTile({
    Key key,
    @required this.indexer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: indexer.displayName,
      body: [TextSpan(text: indexer.host)],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        context.read<SearchState>().indexer = indexer;
        SearchCategoriesRouter().navigateTo(context);
      },
    );
  }
}
