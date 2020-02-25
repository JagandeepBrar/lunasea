import 'package:flutter/material.dart';
import 'package:lunasea/routes/settings/routes.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/core/database.dart';
import './indexers/add.dart';

class SettingsIndexers extends StatefulWidget {
    @override
    State<SettingsIndexers> createState() => _State();
}

class _State extends State<SettingsIndexers> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: LSAppBar(title: 'Settings'),
        body: ValueListenableBuilder(
            valueListenable: Database.indexersBox.listenable(),
            builder: (context, box, widget) {
                return _body;
            },
        ),
    );

    Widget get _body => LSListView(
        children: <Widget>[
            LSCardTile(
                title: LSTitle(text: 'Add Indexer'),
                subtitle: LSSubtitle(text: 'Add a new indexer to LunaSea'),
                trailing: LSIconButton(icon: Icons.add),
                onTap: _enterAddIndexer,
            ),
            LSDivider(),
            if(Database.indexersBox.length == 0) LSGenericMessage(text: 'No Indexers Added'),
            ...List.generate(Database.indexersBox.length, (index) {
                IndexerHiveObject indexer = Database.indexersBox.getAt(index);
                return LSCardTile(
                    title: LSTitle(text: indexer.displayName),
                    subtitle: LSSubtitle(text: indexer.host),
                    trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                    onTap: () => _enterEditIndexer(indexer),
                );
            }),
        ],
    );

    Future<void> _enterAddIndexer() async {
        final result = await Navigator.of(context).pushNamed(SettingsIndexersAdd.ROUTE_NAME);
        if(result != null && (result as dynamic)[0] == 'indexer_added')
            Notifications.showSnackBar(_scaffoldKey, 'Indexer added');
    }

    Future<void> _enterEditIndexer(IndexerHiveObject indexer) async {
        final result = await Navigator.of(context).pushNamed(
            SettingsIndexerEdit.ROUTE_NAME,
            arguments: SettingsIndexerEditArguments(indexer: indexer),
        );
        if(result != null && (result as dynamic)[0] == 'indexer_deleted')
            Notifications.showSnackBar(_scaffoldKey, 'Deleted indexer');
    }
}
