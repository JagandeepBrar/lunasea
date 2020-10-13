import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesSearchIndexerTile extends StatelessWidget {
    final IndexerHiveObject indexer;
    final int index;

    SettingsModulesSearchIndexerTile({
        Key key,
        @required this.indexer,
        @required this.index,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: indexer.displayName),
        subtitle: LSSubtitle(text: indexer.host),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _enterIndexer(context),
    );

    Future<void> _enterIndexer(BuildContext context) async => SettingsModulesSearchEditRouter.navigateTo(
        context,
        index: index,
    );
}