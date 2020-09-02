import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesSearchIndexerTile extends StatelessWidget {
    final IndexerHiveObject indexer;

    SettingsModulesSearchIndexerTile({
        Key key,
        @required this.indexer,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: indexer.displayName),
        subtitle: LSSubtitle(text: indexer.host),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _enterIndexer(context),
    );

    Future<void> _enterIndexer(BuildContext context) async => await Navigator.of(context).pushNamed(
        SettingsModulesSearchEditRoute.ROUTE_NAME,
        arguments: SettingsModulesSearchEditRouteArguments(indexer: indexer),
    );
}