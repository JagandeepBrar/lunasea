import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchIndexerTile extends StatelessWidget {
    final IndexerHiveObject indexer;

    SearchIndexerTile({
        Key key,
        @required this.indexer,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: indexer.displayName),
            subtitle: LunaText.subtitle(text: indexer.host),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
            onTap: () async {
                context.read<SearchState>().indexer = indexer;
                SearchCategoriesRouter().navigateTo(context);
            },
        );
    }
}
