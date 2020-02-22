import 'package:flutter/material.dart';
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
            valueListenable: Database.getIndexersBox().listenable(),
            builder: (context, box, widget) {
                return _body;
            },
        ),
    );

    Widget get _body => LSListView(
        children: <Widget>[
            LSCardTile(
                title: LSTitle(text: 'Add Indexer'),
                subtitle: LSSubtitle(text: 'Add an usenet indexer to LunaSea'),
                trailing: LSIconButton(icon: Icons.add),
                onTap: _enterAddIndexer,
            ),
            LSDivider(),
            if(Database.getIndexersBox().length == 0) LSGenericMessage(text: 'No Indexers Added'),
            ...List.generate(Database.getIndexersBox().length, (index) {
                IndexerHiveObject indexer = Database.getIndexersBox().getAt(index);
                return LSCardTile(
                    title: LSTitle(text: indexer.displayName),
                    subtitle: LSTitle(text: indexer.host),
                );
            }),
        ],
    );

    Future<void> _enterAddIndexer() async {
        final result = await Navigator.of(context).pushNamed(SettingsIndexersAdd.ROUTE_NAME);
        if(result != null && (result as dynamic)[0] == 'indexer_added')
            Notifications.showSnackBar(_scaffoldKey, 'Indexer added!');
    }
}
